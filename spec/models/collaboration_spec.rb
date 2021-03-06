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

require 'spec_helper'

describe Collaboration do

  describe "callbacks" do
    it "should delete Collaboration when project is deleted" do
      #pending
    end
  end
  describe "#pending" do

    it "should be pending by default" do
      c = Collaboration.new
      c.pending?.should be_true
    end

    it "should not be pending after it was accepted" do
      c = FactoryGirl.create(:collaboration)
      c.accept!
      c.pending?.should be_false
    end

  end

  describe "#skill_list" do
    it "should save skills" do
      c = FactoryGirl.build(:collaboration)
      c.skill_list="hiking, biking"
      c.save
      c.skill_list.should eq ["hiking","biking"]
    end
  end

  describe "connection" do
    it "should not create a connection after collaboration is created" do
      c= create(:collaboration)
      user1 = c.collaborator
      user2 = c.project.creator
      user1.connections.should_not include user2
    end

    it "should create a connection after collaboration has been accepted" do
      c= create(:collaboration)
      user1 = c.collaborator
      user2 = c.project.creator
      c.accept!
      user1.connected_users.should include user2
    end

    it "should not blow up if users are already connected and a new tag is accepted" do
      project = create(:project)
      user1 = project.creator
      user2 = create(:user)
      create(:connection, inviter: user1, invitee: user2)

      c= create(:collaboration, project:project, collaborator: user2)
      c.accept!
      user1.connected_users.should include user2
    end

  end

end
