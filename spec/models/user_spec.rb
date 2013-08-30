require 'spec_helper'

describe User do

  describe "#communication_name" do

    it "should show email if name is not available" do
      user = FactoryGirl.create(:user, email:"ilya@gmail.com",
                                first_name: "", last_name: "")
      user.communication_name.should eq "ilya@gmail.com"
    end

    it "should show name if available" do
      user = FactoryGirl.create(:user, email:"i@gmail.com",
                                first_name: "ilya", last_name: "k")
      user.communication_name.should eq "ilya k"
    end
  end

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

    it "shouold indicate that user needs to invite contacts" do
      user.first_name="present"
      user.last_name="present"
      user.job_title="present"
      user.profile_status.should eq :contacts
    end

    it "should indicate that user needs to add a project" do
      user.first_name="present"
      user.last_name="present"
      user.job_title="present"
      user.stub(:invited_contacts?).and_return(true)
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
      user.stub(:invited_contacts?).and_return(true)
      user.profile_status.should eq :complete
    end

  end

  describe "#token" do
    let!(:u1){create(:user, first_name: "batman", last_name: "werkd", email: "ilyak@gmail.com")}
    let!(:u2){create(:user, first_name: "werkd", last_name: "handsome", email: "will@gmail.com")}
    let!(:u3){create(:user, first_name: "alfred", email: "werkdilyas@gmail.com")}

    it "should find user by email" do
      res = User.token("ilya")
      res.should include(u1)
      res.should include(u3)
      res.count.should eq 2
    end

    it "should find user by name" do
      res = User.token("batm")
      res.should include(u1)
      res.count.should eq 1
    end

    it "should find user by last name" do
      res = User.token("handso")
      res.should include(u2)
      res.count.should eq 1
    end

    it "should find users by all three" do
      res = User.token("werkd")
      res.should include(u1)
      res.should include(u2)
      res.should include(u3)
      res.count.should eq 3
    end
  end

  describe "#json_token" do
    let!(:u1){create(:user, first_name: "batman", last_name: "werkd", email: "ilyak@gmail.com")}

    it "should return name" do
      res = User.json_token("werkd")
      res.should eq [{id: u1.id, name: u1.public_name}].to_json
    end

    it "should return query back if email not found" do
      email = "booyakasha@gmail.com"
      res = User.json_token("booyakasha@gmail.com")
      res.should eq [{id: "booyakasha@gmail.com", name: "booyakasha@gmail.com"}].to_json
    end

    it "should not return anything if nothing found non-email query" do
      res = User.json_token("booyakasha")
      res.should eq [].to_json
    end

  end

  describe :factories do

    describe :user do
      subject { build(:user) }
      it { should be_valid }
    end # user

    describe :user_with_projects_and_connections do
      let(:user) { create(:user_with_projects_and_connections) }
      subject { user }
      it { should be_valid }

      context :projects do
        subject { user.projects }
        it { should have(3).items }
      end # projects

      context :conntections do
        subject { user.connections }
        it { should have(6).items }
      end

    end # user_with_projects_and_connections

  end # factories
end
