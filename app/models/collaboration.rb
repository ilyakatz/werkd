class Collaboration < ActiveRecord::Base
  belongs_to :collaborator, class_name: "User", foreign_key: "user_id"
  belongs_to :project

  validates_presence_of :user_id
  validates_presence_of :project_id
end
