class Invitation < ActiveRecord::Base
  attr_accessible :email, :referer_id, :user_id
end
