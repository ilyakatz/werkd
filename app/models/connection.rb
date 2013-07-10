class Connection < ActiveRecord::Base
  attr_accessible :connected_to, :user_id

  belongs_to :contact, class_name: "User", :foreign_key => :connected_to
  has_one :user
end
