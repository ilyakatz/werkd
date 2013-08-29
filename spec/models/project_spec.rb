require 'spec_helper'

describe Project do

  describe "#tag_list" do
    it "should be require" do
      p = FactoryGirl.build(:project)
      p.tag_list=""
      p.save.should be_false
      p.errors[:tag_list].should_not be_empty
    end
  end

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
      VCR.use_cassette("models/project/image_embed") do
        #vcr doesn't seem to work with multiple requests
        Cloudinary::Uploader.stub(:upload).and_return({"url"=>"asdf"})
        p = FactoryGirl.build(:project,
                              media_url: "http://affinitycycles.com/wp-content/uploads/2012/12/Affinity-Raekwon-Wu-Charity-bike-web-e1355153507540.jpg")
        p.save
        p.embed_html.should be_nil
        p.thumbnail_url.should eq "asdf"
      end
    end

  end

  describe "#tagged_user_ids=" do

    it "should be able to invite new users who were tagged" do
      p = FactoryGirl.create(:project)
      p.tagged_user_ids=("ilyakatz@gmail.com")

      u=User.find_by_email!("ilyakatz@gmail.com")

      p.tagged_users.should eq([u])
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
  end

  describe "#tagged_users" do

    it "should tag users" do
      p = FactoryGirl.create(:project)
      u = FactoryGirl.create(:user)
      u1 = FactoryGirl.create(:user)

      p.tagged_users=[u,u1]
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

    it "should send emails to tagged users" do
      p = FactoryGirl.create(:project)
      u = FactoryGirl.create(:user)
      u1 = FactoryGirl.create(:user)

      ContactsMailer.should_receive(:send_tag_created).with(p.id, u.id)
      ContactsMailer.should_receive(:send_tag_created).with(p.id, u1.id)

      p.tagged_users=[u, u1]
    end

    it "should not send duplicate emails" do
      p = FactoryGirl.create(:project)
      u = FactoryGirl.create(:user)
      u1 = FactoryGirl.create(:user)
      ContactsMailer.should_receive(:send_tag_created).with(p.id, u.id)
      p.tagged_users=[u]
      ContactsMailer.should_not_receive(:send_tag_created).with(p.id, u.id)
      ContactsMailer.should_receive(:send_tag_created).with(p.id, u1.id)
      p.tagged_users=[u, u1]
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

