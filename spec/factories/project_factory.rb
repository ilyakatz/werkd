# == Schema Information
#
# Table name: projects
#
#  id            :integer          not null, primary key
#  title         :string(255)
#  company       :string(255)
#  user_id       :integer
#  video         :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  media_url     :string(255)
#  contribution  :string(255)
#  start_at      :date
#  embed_html    :string(255)
#  thumbnail_url :string(255)
#

FactoryGirl.define do

  factory :project do
    sequence(:title) { |n| "Project #{n}" }
    company { Faker::Company.name }
    tag_list "design"
  end

end
