# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default("")
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  failed_attempts        :integer          default(0)
#  unlock_token           :string(255)
#  locked_at              :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  first_name             :string(255)
#  last_name              :string(255)
#  invitation_token       :string(60)
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_id          :integer
#  invited_by_type        :string(255)
#  location               :string(255)
#  job_title              :string(255)
#  invited_contacts       :datetime
#

FactoryGirl.define do

  sequence :email do |n|
    "email#{n}@werkd.com"
  end

  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password "toto42"
    unconfirmed_email nil
    confirmed_at "2013-04-13 18:28:12"
    confirmation_sent_at "2013-04-13 18:25:28"

    factory :user_with_projects_and_connections do
      after(:create) do |user|
        projects = create_list(:project, 4)
        connections = create_list(:connection, 6, inviter: user)

        projects.each_with_index do |project, i|
          create(:collaboration, collaborator: user, project: project, accepted_at: Time.now)
          i.times {
            connection = connections.pop()
            create(:collaboration, collaborator: connection.invitee, project: project, accepted_at: Time.now)
          }
        end
      end
    end # user_with_projects_and_connections

  end # user

end


