module Users
  class DashboardsController < ApplicationController

    before_filter :authenticate_user!

    def index

    end

  end
end
