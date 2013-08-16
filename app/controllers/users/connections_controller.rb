module Users
  class ConnectionsController < ApplicationController
    before_filter :authenticate_user!

    def accept
     @connection = current_user.connections.find(params[:connection_id])
     @connection.accept!
     ContactsMailer.send_connection_accepted(@connection).deliver!
     redirect_to users_dashboards_path
    end

  end
end
