# == Schema Information
#
# Table name: collaborations
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  project_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Collaboration < ActiveRecord::Base
  belongs_to :collaborator, class_name: "User", foreign_key: "user_id"
  belongs_to :project

  validates_presence_of :user_id

  def pending?
    !accepted_at?
  end

  def accept!
    transaction do
      update_attribute(:accepted_at, Time.now)
      Connection.create_accepted_connection(project.creator, collaborator)
    end
  end
end
