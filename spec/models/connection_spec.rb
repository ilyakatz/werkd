# == Schema Information
#
# Table name: connections
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  connected_to :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  sent_at      :time
#  accepted_at  :time
#

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

  describe "Connection#create_pending_connections" do
    it "should not create duplicate connections" do
      user1 = create(:user)
      user2 = create(:user)
      Connection.create_pending_connections(user1, user2)
      Connection.create_pending_connections(user1, user2).should be_nil
    end

    it "order of connections doesn't matter" do
      user1 = create(:user)
      user2 = create(:user)
      Connection.create_pending_connections(user1, user2)
      Connection.create_pending_connections(user2, user1).should be_nil
    end

  end

end
