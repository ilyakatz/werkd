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
    thumbnail_url { 'http://res.cloudinary.com/werkd/image/upload/v1379801218/hd1kgkx7nccahdyl9wtz.png' }
    embed_html { '<iframe src="http://www.google.com"></iframe>' }
    association :creator, factory: :user
  end

end
