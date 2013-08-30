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
