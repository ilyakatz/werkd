class UsersController < ApplicationController

  def index
    if params[:q]

      respond_to do |format|
        format.json{
          render json: User.json_token(params[:q])
        }
      end

    end
  end

  def show
    @user = User.find(params[:id])
    @projects = @user.projects
    @connections = @user.connected_users
    @user_json = Rabl.render(@user, 'api/users/show', view_path: 'app/views', format: :json)
    render template: "users/dashboards/index"
  end

end

