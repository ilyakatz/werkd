FactoryGirl.define do

  factory :project do
    sequence(:title) { |n| "Project #{n}" }
    company { Faker::Company.name }
    tag_list "design"
  end

end
