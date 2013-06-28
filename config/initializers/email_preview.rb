EmailPreview.register 'Welcome Email', :category => :user do
  u = User.new :email => 'foo@example.com'
  WelcomeMailer.send_welcome_email(u)
end
