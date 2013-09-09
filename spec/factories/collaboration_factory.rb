FactoryGirl.define do

  factory :collaboration do
    project
    association :collaborator, factory: :user
  end

end
