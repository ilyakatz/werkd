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

FactoryGirl.define do

  factory :connection do
    association :inviter, factory: :user
    association :invitee, factory: :user
  end # connection

end


