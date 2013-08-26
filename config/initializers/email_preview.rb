if Rails.env.development?

  EmailPreview.register 'Welcome Email', :category => :user do
    u = User.new :email => 'foo@example.com', first_name: "Ilya"
    WelcomeMailer.send_welcome_email(u)
  end

  EmailPreview.register 'Invitation Accepted', :category => :invitations do
    u = User.new :email => 'invitee@example.com', first_name: "Ilya"
    u1 = User.new :email => 'inviter@example.com', last_name: "Will"
    u.invited_by = u1
    u.id=1
    ContactsMailer.send_invitation_accepted(u)
  end

  EmailPreview.register 'Connection invitation accepted', :category => :connections do
    u = User.new :email => 'invitee@example.com', first_name: "Ilya"
    u1 = User.new :email => 'inviter@example.com', last_name: "Will"
    connection = Connection.new
    connection.inviter = u1
    connection.invitee = u
    connection.save!
    ContactsMailer.send_connection_accepted(connection)
  end

  EmailPreview.register 'Invitation to join WeRKD sent', :category => :invitations do
    u = User.new :email => 'invitee@example.com', first_name: "Ilya"
    u1 = User.new :email => 'inviter@example.com', last_name: "Will"
    u.invited_by = u1
    Devise::Mailer.invitation_instructions(u)
  end

  EmailPreview.register 'Invitation to connect', :category => :connections do
    u = User.new :email => 'invitee@example.com', first_name: "Ilya"
    u1 = User.new :email => 'inviter@example.com', last_name: "Will"
    connection = Connection.new
    connection.inviter = u1
    connection.invitee = u
    connection.save!
    ContactsMailer.send_connection_request(connection)
  end

end
