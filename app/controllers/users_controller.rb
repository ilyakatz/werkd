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

end

