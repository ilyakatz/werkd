module Users
  class FeedsController < UsersController

    def index
      current_user.onboarding_complete!
    end

  end
end
