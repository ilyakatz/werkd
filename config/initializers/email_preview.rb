if Rails.env.development?

  EmailPreview.register 'Welcome Email', :category => :user do
    u = User.new :email => 'foo@example.com'
    WelcomeMailer.send_welcome_email(u)
  end

  EmailPreview.register 'Invitation Accepted', :category => :user do
    u = User.new :email => 'invitee@example.com'
    u1 = User.new :email => 'inviter@example.com'
    u.invited_by = u1
    ContactsMailer.send_invitation_accepted(u)
  end

  EmailPreview.register 'Invitation Sent', :category => :devise do
    u = User.new :email => 'invitee@example.com'
    u1 = User.new :email => 'inviter@example.com'
    u.invited_by = u1
    Devise::Mailer.invitation_instructions(u)
  end


end


# what to do when file is deleted
# ln -s /Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl /usr/local/bin/sublime
# export EDITOR=/usr/local/bin/sublime
