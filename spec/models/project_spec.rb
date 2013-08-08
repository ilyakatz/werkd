require 'spec_helper'

describe Project do
  describe "#extract_embed" do

    it "should extract embed url when media url changes" do
      p = FactoryGirl.build(:project, media_url: "http://www.youtube.com/watch?v=obuV1KrvEYo")
      p.save
      p.embed_url.should =~ /iframe/


    end

  end

  describe "tagging" do

    it "should tag users" do
      p = FactoryGirl.create(:project)
      u = FactoryGirl.create(:user)
      u1 = FactoryGirl.create(:user)

      p.tagged_users=[u,u1]
      p.tagged_users.should eq([u,u1])
    end

    it "should tag by user ids" do
      p = FactoryGirl.create(:project)
      u = FactoryGirl.create(:user)
      u1 = FactoryGirl.create(:user)

      p.tag_users_by_ids([u.id, u1.id])
      p.tagged_users.should eq([u,u1])

    end
  end
end

