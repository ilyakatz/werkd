FactoryGirl.define do

  sequence :email do |n|
    "email#{n}@werkd.com"
  end

  factory :user do
    email
    password "toto42"
    unconfirmed_email nil
    confirmed_at "2013-04-13 18:28:12"
    confirmation_sent_at "2013-04-13 18:25:28"

    factory :user_with_projects_and_connections do
      after(:create) do |user|
        projects = create_list(:project, 4)
        connections = create_list(:connection, 6, inviter: user)

        projects.each_with_index do |project, i|
          create(:collaboration, collaborator: user, project: project)
          i.times {
            connection = connections.pop()
            create(:collaboration, collaborator: connection.invitee, project: project)
          }
        end
      end
    end # user_with_projects_and_connections

  end # user

end


