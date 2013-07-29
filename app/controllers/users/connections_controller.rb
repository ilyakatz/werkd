module Users
  class ConnectionsController < ApplicationController
    before_filter :authenticate_user!

    respond_to :json, :html

    def index
      @connections = current_user.connections
    end

    def accept
     @connection = current_user.connections.find(params[:connection_id])
     @connection.accept!
     ContactsMailer.send_connection_accepted(@connection).deliver!
     redirect_to action: :index
    end

  end
end
