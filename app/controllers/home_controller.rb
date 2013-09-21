class HomeController < ApplicationController

  def index
    if user_signed_in?
      redirect_to users_dashboards_path and return
    end
    render layout: false
  end

end
