# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default("")
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  failed_attempts        :integer          default(0)
#  unlock_token           :string(255)
#  locked_at              :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  first_name             :string(255)
#  last_name              :string(255)
#  invitation_token       :string(60)
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_id          :integer
#  invited_by_type        :string(255)
#  location               :string(255)
#  job_title              :string(255)
#  invited_contacts       :datetime
#

require 'spec_helper'

describe User do

  describe :collections do
    it { should have_many(:collaborations) }
    it { should have_many(:collaborated_projects) }
  end # collections

  describe "#all_projects" do
    it "should not show projects that where I was tagged but not accepted" do
      project = create(:project)
      project1 = create(:project)
      user = project.creator
      project1.tagged_users = [ user ]

      user.projects.count.should eq 1
      user.all_projects.count.should eq 1
      user.all_projects.first.should eq project
    end

    it "should return my projects and project i was tagged on" do
      project = create(:project)
      project1 = create(:project)
      user = project.creator
      project1.tagged_users = [ user ]
      project1.collaborations.first.accept!

      user.projects.count.should eq 1
      user.all_projects.count.should eq 2
    end
  end

  describe "#skills" do
    it "should return empty array if user has no projects" do
      user = create(:user)
      user.skills.should be_empty
    end

    it "should combine all skills" do
      project = create(:project, tag_list: "design, programming")
      project = create(:project, tag_list: "design, biking", creator: project.creator)
      skills = project.creator.skills
      skills.should include "design"
      skills.should include "programming"
      skills.should include "biking"
      skills.count.should eq 3
    end
  end

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
      user = FactoryGirl.build(:user, first_name: "Ilya", last_name: nil)
      user.public_name.should eq "Ilya"
    end

    it "should show full name if present" do
      user = FactoryGirl.build(:user,
                               first_name: "Ilya",
                               last_name: "Katz")
      user.public_name.should eq "Ilya Katz"
    end

    it "should show generic name if not present" do
      user = FactoryGirl.build(:user, first_name: nil, last_name: nil)
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

  describe "#missing_project_message" do
    let(:user) { create(:user) }

    it "should show message for 1 missing project" do
      user.stub_chain(:projects, :count).and_return 2
      user.missing_project_message.should eq "Great. The last one!!"
    end

    it "should show message for 2 missing projects" do
      user.stub_chain(:projects, :count).and_return 1
      user.missing_project_message.should match "Only 2 more to go"
    end

    it "should show message for 3 missing projects" do
      user.missing_project_message.should match "Add three projects to get started"
    end

    it "should return nil for 3 projects" do
      user.stub_chain(:projects, :count).and_return 3
      user.missing_project_message.should be_nil
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

      context :collaborated_projects do
        let(:collaborated_projects) { user.collaborated_projects }
        subject { collaborated_projects }
        it { should have(4).items }

        context :project_1 do
          let(:project_1) { collaborated_projects[0] }
          subject { project_1 }
          its(:collaborators) { should have(1).items }
        end

        context :project_4 do
          let(:project_4) { collaborated_projects[3] }
          subject { project_4 }
          its(:collaborators) { should have(4).items }
        end

      end # projects

      context :conntections do
        subject { user.connections }
        it { should have(6).items }
      end # connections

    end # user_with_projects_and_connections

  end # factories
end
