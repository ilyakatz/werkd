module Users
  class DashboardsController < ApplicationController

    before_filter :authenticate_user!

    def index
    	@projects = current_user.projects
    	@connections = current_user.connections

    end

  end
end
