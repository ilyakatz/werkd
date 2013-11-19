class MoveContributionDataToCollaboration < ActiveRecord::Migration
  def up
    Project.all.each { |project|
      collaboration = project.collaborations.first
      collaboration.contribution = project.contribution
      collaboration.save(validate: false)
    }
  end
end
