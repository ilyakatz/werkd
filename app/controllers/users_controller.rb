class UsersController < ApplicationController

  def index
    if params[:q]

      respond_to do |format|
        format.json{
          render json: User.token(params[:q]).to_json
        }
      end

    end
  end

  def show
    @user = User.find(params[:id])
    @projects = @user.projects
    @connections = @user.connected_users
    render template: "users/dashboards/index"
  end

end

