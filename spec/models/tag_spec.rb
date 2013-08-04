require 'spec_helper'

describe Tag do

  describe "#token" do

    it "should return the name of token is not found" do
      Tag.token("programming").should eq [{name: "programming", id: "programming"}]
    end

    it "should return existing token if it is found" do
      t = FactoryGirl.create(:tag, name: "multimedia")
      Tag.token("mult").should eq [t]
    end
  end
end
