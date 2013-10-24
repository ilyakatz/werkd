# == Schema Information
#
# Table name: projects
#
#  id            :integer          not null, primary key
#  title         :string(255)
#  company       :string(255)
#  user_id       :integer
#  video         :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  media_url     :string(255)
#  contribution  :string(255)
#  start_at      :date
#  embed_html    :string(255)
#  thumbnail_url :string(255)
#

require 'spec_helper'

describe Project do

  describe "#extract_embed" do

    it "should extract embed url when media url changes"  do
      VCR.use_cassette("models/project") do
        Cloudinary::Uploader.stub(:upload).and_return({"url"=>"asdf2"})
        p = FactoryGirl.build(:project, media_url: "http://www.youtube.com/watch?v=obuV1KrvEYo")
        p.save
        p.embed_html.should =~ /iframe/
        p.thumbnail_url.should eq "asdf2"
        p.media_type.should eq "video"
      end
    end

    it "should extract embed url when media url changes"  do
      VCR.use_cassette("models/project/rich_format") do
        Cloudinary::Uploader.stub(:upload).and_return({"url"=>"asdf2"})
        p = FactoryGirl.build(:project, media_url: "https://soundcloud.com/portugaltheman")
        p.save
        p.embed_html.should =~ /iframe/
        p.thumbnail_url.should eq "asdf2"
        p.media_type.should eq "rich"
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
        p.media_type.should eq "photo"
      end
    end

    it "should extract audio" do
      VCR.use_cassette("models/project/audio_embed") do
        #vcr doesn't seem to work with multiple requests
        Cloudinary::Uploader.stub(:upload).and_return({"url"=>"audio/url"})
        p = FactoryGirl.build(:project,
                              media_url: "https://soundcloud.com/thirdcoast/re-sound-139-the")
        p.save
        p.embed_html.should be_nil
        p.thumbnail_url.should eq "audio/url"
        p.media_type.should eq "link"
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
      p.tagged_users.reload.should eq [u1]
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

  describe '#cloudinary_id' do
    let(:cloudinary_id) { 'hd1kgkx7nccahdyl9wtz.jpg' }
    let(:thumbnail_url) { "http://res.cloudinary.com/werkd/image/upload/v1379801218/#{cloudinary_id}" }
    let(:project) { create(:project, thumbnail_url: thumbnail_url) }
    subject { project.cloudinary_id }
    it { should == cloudinary_id  }

    context 'when thumbnail_url is nil' do
      let(:thumbnail_url) { nil }
      it { should == nil }
    end # when thumbnail_url is nil
  end # cloudinary_id

  describe :factories do

    describe :project do
      subject { build(:project) }
      it { should be_valid }
    end # project

  end # factories

end

