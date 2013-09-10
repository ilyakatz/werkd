# == Schema Information
#
# Table name: collaborations
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  project_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Collaboration do

  describe "#pending" do

    it "should be pending by default" do
      c = Collaboration.new
      c.pending?.should be_true
    end

    it "should not be pending after it was accepted" do
      c = FactoryGirl.create(:collaboration)
      c.accept!
      c.pending?.should be_false

    end
  end
end
