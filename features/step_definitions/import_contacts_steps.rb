When(/^google returns my contact list$/) do
  Rails.cache.stub(:read).and_return(
    [
      {
        :id =>
          "http://www.google.com/m8/feeds/contacts/Ilya%40challengepost.com/base/7955af58b1a5e0a",
        :first_name => "Ilya",
        :last_name => "Werkd",
        :name => "Ilya Werkd",
        :email => "ilya@werkd.net",
        :gender => nil,
        :birthday => nil,
        :profile_picture => nil,
        :relation => nil
      },

      {
        :id =>
          "http://www.google.com/m8/feeds/contacts/Ilya%40challengepost.com/base/7955af58b1a5e0a",
        :first_name => "Ilya",
        :last_name => "Notwerkd",
        :name => "Ilya Notwerked",
        :email => "ilya@not-werkd.net",
        :gender => nil,
        :birthday => nil,
        :profile_picture => nil,
        :relation => nil
      }
    ]

  )
end


