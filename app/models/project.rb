class Project < ActiveRecord::Base
  attr_accessible :company, :title, :user_id, :video
  belongs_to :user

  validates_presence_of :title, :company
end
