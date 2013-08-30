FactoryGirl.define do

  factory :connection do
    association :inviter, factory: :user
    association :invitee, factory: :user
  end # connection

end


