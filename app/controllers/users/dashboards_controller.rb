module Users
  class DashboardsController < UsersController

    def index
      @user = current_user
      @projects = current_user.projects
      @connections = current_user.connected_users
      @current_user_json = Rabl.render(@user,
                                       'api/users/base',
                                       view_path: 'app/views',
                                       format: :json)
      @user_json = Rabl.render(@user, 'api/users/show',
                               view_path: 'app/views',
                               format: :json)
    end

  end
end
