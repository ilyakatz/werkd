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
end
