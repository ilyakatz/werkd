module Users
  class ActionsController < ApplicationController

    def index
      @connections = Connection.where(connected_to: current_user).pending
    end
  end
end
