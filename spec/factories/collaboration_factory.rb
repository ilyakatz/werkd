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

FactoryGirl.define do

  factory :collaboration do
    association :collaborator, factory: :user
    association :project
    skill_list { ['design', 'color correction'] }
  end # collabortaion

end
