require 'spec_helper'

describe Connection do

  describe :factories do

    describe :connection do
      subject { build(:connection) }
      it { should be_valid }
      its(:inviter) { should be }
      its(:invitee) { should be }
    end # connection

  end # factories

end
