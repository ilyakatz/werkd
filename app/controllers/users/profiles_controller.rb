module Users
  class ProfilesController < Users::UsersController

    def index
      @user = current_user
    end

    def update
      @user = current_user
      if @user.update_attributes(users_params)
        after_profile_update
      else
        redirect_to users_profiles_path, alert: 'Profile could not be updated.'
      end
    end

    private

    def users_params
      params.require(:user).permit(:first_name, :last_name, :location, :job_title)
    end

    def after_profile_update
      if current_user.profile_status == :projects
        redirect_to new_users_project_path, notice: "Please add a project you worked on in the past"
      else
        redirect_to users_dashboards_path, notice: 'Profile was successfully updated.'
      end
    end

  end
end
