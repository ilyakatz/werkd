module Api

  class UsersController < ApiController

    def show
      with_user do |user|
        @user = user
      end
    end

    private

    def with_user(&block)
      id = params[:id]
      if user = User.find(id)
        yield user
      else
        render text: "User with id: #{id} not found!", status: 400
      end
    end

  end # class

end # module
