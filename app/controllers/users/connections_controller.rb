module Users
  class ConnectionsController < ApplicationController
    before_filter :authenticate_user!

    respond_to :json, :html

    def index
      @connections = current_user.connections
    end

    def new
     @connection = Connection.new
     @connection.user = current_user
    end

    def accept
     @connection = current_user.connections.find(params[:connection_id])
     @connection.accept!
     redirect_to action: :index
    end

    def create
      connect_to=User.find(params[:id])
      connection = Connection.create_pending_connections(current_user, connect_to)
      ContactsMailer.send_connection_request(connection).deliver!

      respond_to do |format|
        if true
          msg = "Connection request sent"
          format.json do
            render text: msg, status: :ok
          end
          format.html do
            redirect_to :back, notice: msg
          end

        else
          msg = "An error occurred"
          format.json do
            render text: msg, status: :internal_server_error
          end
          format.html do
            redirect_to :back, notice: msg
          end
        end
      end
    end

  end
end
