class ApplicationController < ActionController::Base
  include Profiles

  protect_from_forgery

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || profile_completions_paths(resource)
  end

  def authenticate_admin_user!
    authenticate_user!
  end

  def current_admin_user
    current_user
  end


end
