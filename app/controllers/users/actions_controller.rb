module Users
  class ActionsController < ApplicationController
    before_filter :authenticate_user!

    def index
      @connections = Connection.where(invitee: current_user).pending

      if @connections.empty?
        redirect_to users_dashboards_path, notice: "No pending connections at this time"
      end
    end
  end
end
