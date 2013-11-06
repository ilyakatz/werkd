module Profiles

  def profile_completions_paths(user)
    if user.profile_status == :basics
      users_profiles_path
    elsif user.profile_status == :projects
      new_users_project_path
    elsif user.profile_status == :contacts
      users_omnicontacts_path
    else
      users_feeds_path
    end
  end

end
