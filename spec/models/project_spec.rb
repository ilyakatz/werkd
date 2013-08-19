require 'spec_helper'

describe Project do
  describe "#extract_embed" do

    it "should extract embed url when media url changes"  do
      VCR.use_cassette("models/project") do
        p = FactoryGirl.build(:project, media_url: "http://www.youtube.com/watch?v=obuV1KrvEYo")
        p.save
        p.embed_html.should =~ /iframe/
          p.thumbnail_url.should eq "http://i1.ytimg.com/vi/obuV1KrvEYo/hqdefault.jpg"
      end
    end

    it "shouold extract image" do
      VCR.use_cassette("models/project/image") do
        p = FactoryGirl.build(:project,
                              media_url: "http://www.whitegadget.com/attachments/pc-wallpapers/14134d1219229281-sports-bikes-wallpaper-bikes-wallpaper1.jpg")
        p.save
        p.embed_html.should be_nil
        p.thumbnail_url.should eq "http://www.whitegadget.com/attachments/pc-wallpapers/14134d1219229281-sports-bikes-wallpaper-bikes-wallpaper1.jpg"
      end
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

      p.tagged_user_ids=([u.id, u1.id])

      p.tagged_users.should eq([u,u1])
      p.tagged_user_ids.should eq [u.id, u1.id]
    end

    it "should tag using a string" do
      p = FactoryGirl.create(:project)
      u = FactoryGirl.create(:user)
      u1 = FactoryGirl.create(:user)

      p.tagged_user_ids=("#{u.id}, #{u1.id}")

      p.tagged_users.should eq([u,u1])
    end

    it "should override existing tagged users" do
      p = FactoryGirl.create(:project)
      u = FactoryGirl.create(:user)
      u1 = FactoryGirl.create(:user)

      p.tagged_users=[u]
      p.tagged_users.should eq [u]

      p.tagged_users=[u1]
      p.tagged_users.should eq [u1]
    end

    it "should not affect different projects" do
      p = FactoryGirl.create(:project)
      p1 = FactoryGirl.create(:project)
      u = FactoryGirl.create(:user)
      u1 = FactoryGirl.create(:user)

      p.tagged_users=[u]

      p1.tagged_users=[u, u1]
      p1.tagged_users.should eq [u, u1]
      p.tagged_users.should eq [u]
    end
  end
end

