require 'spec_helper'

describe User do

  describe "#public_name" do

    it "should show only first name if present" do
      user = FactoryGirl.build(:user, first_name: "Ilya")
      user.public_name.should eq "Ilya"
    end

    it "should show full name if present" do
      user = FactoryGirl.build(:user,
                               first_name: "Ilya",
                               last_name: "Katz")
      user.public_name.should eq "Ilya Katz"
    end

    it "should show generic name if not present" do
      user = FactoryGirl.build(:user)
      user.public_name.should eq "WeRKD user"
    end

  end

  describe "#profile_status" do
    let(:user){FactoryGirl.build(:user)}

    it "should indicate that basic info is missing" do
      user.profile_status.should eq :basics
      user.first_name="present"
      user.profile_status.should eq :basics
      user.last_name="present"
      user.profile_status.should eq :basics
    end
    it "should indicate that user needs to add a project" do
      user.first_name="present"
      user.last_name="present"
      user.job_title="present"
      user.profile_status.should eq :projects
    end

    it "should indicate the users profile is complete" do
      user.first_name="present"
      user.last_name="present"
      user.job_title="present"
      projects = [
        FactoryGirl.build(:project),
        FactoryGirl.build(:project),
        FactoryGirl.build(:project)
      ]
      user.stub(:projects).and_return(projects)
      #user.projects<<3.times { FactoryGirl.create(:project) }
      user.profile_status.should eq :complete
    end

  end
end
