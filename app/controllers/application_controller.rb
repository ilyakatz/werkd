class ApplicationController < ActionController::Base
  include Profiles

  protect_from_forgery
  add_breadcrumb :index, :root_path

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || profile_completions_paths(resource)
  end


end
