class ApplicationController < ActionController::Base
  protect_from_forgery
  add_breadcrumb :index, :root_path  
  
  def after_sign_in_path_for(resource)
    users_dashboards_path
  end
  
end
