require 'spec_helper'

describe Project do
  describe "#extract_embed" do

    it "should extract embed url when media url changes" do
      p = FactoryGirl.build(:project, media_url: "http://www.youtube.com/watch?v=obuV1KrvEYo")
      p.save
      p.embed_url.should =~ /iframe/


    end

  end
end

