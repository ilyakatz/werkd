module Profiles

  def profile_completions_paths(user)
    if user.profile_status == :basics
      users_profiles_path
    elsif user.profile_status == :projects
      new_users_project_path
    else
      users_dashboards_path
    end
  end

end
