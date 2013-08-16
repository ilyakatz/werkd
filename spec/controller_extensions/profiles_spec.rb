require 'spec_helper'

describe Profiles do
  include Profiles
  include Rails.application.routes.url_helpers

  describe "#profile_completions_paths" do
    let(:user){ FactoryGirl.build(:user) }

    it "should go to the project page if status indicates projects" do
      user.stub(:profile_status).and_return(:projects)
      profile_completions_paths(user).should eq new_users_project_path
    end

    it "should go to contacts if status is contacts" do
      user.stub(:profile_status).and_return(:contacts)
      profile_completions_paths(user).should eq users_omnicontacts_path
    end

    it "should go to dashboard path if status is anything else" do
      user.stub(:profile_status).and_return(:complete)
      profile_completions_paths(user).should eq users_dashboards_path
    end

  end

end

