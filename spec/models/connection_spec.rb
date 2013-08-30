require 'spec_helper'

describe Connection do

  describe :methods do

    describe :other_user do
      let(:user) { create(:user) }
      let!(:inviter_connections) { create_list(:connection, 2, inviter: user) }
      let!(:invitee_connections) { create_list(:connection, 2, invitee: user) }
      let(:connections) { user.connections }
      subject { connections }
      it { should have(4).items }
      it 'should have other user not as user' do
        subject.each { |connection|
          other_user = connection.other_user(user)
          other_user.should_not be_nil
          other_user.should_not == user
        }
      end

    end # other_user

  end # methods

  describe :factories do

    describe :connection do
      subject { build(:connection) }
      it { should be_valid }
      its(:inviter) { should be }
      its(:invitee) { should be }
    end # connection

  end # factories

end
