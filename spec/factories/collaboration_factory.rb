FactoryGirl.define do

  factory :collaboration do
    association :collaborator, factory: :user
    association :project
  end # collabortaion

end


