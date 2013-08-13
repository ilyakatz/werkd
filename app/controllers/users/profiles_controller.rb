module Users
  class ProfilesController < Users::UsersController

    def index
      @user = current_user
    end

    def update
      @user = current_user
      if @user.update_attributes(users_params)
        redirect_to users_dashboards_path, notice: 'Profile was successfully updated.'
      else
        redirect_to users_profiles_path, alert: 'Profile could not be updated.'
      end
    end

    private

    def users_params
      params.require(:user).permit(:first_name, :last_name, :location)
    end

  end
end
