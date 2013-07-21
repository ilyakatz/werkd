module Users
  class UsersController < ApplicationController

    before_filter :authenticate_user!
  end
end
