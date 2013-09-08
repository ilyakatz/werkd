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

  describe :factories do

    describe :collaboration do
      subject { build(:collaboration) }
      it { should be_valid }
      its(:collaborator) { should be }
      its(:project) { should be }
    end # connection

  end # factories

end
