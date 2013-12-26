class WelcomeMailer <ActionMailer::Base

  default css: 'email'

  def send_welcome_email(user)
    @user = user
    mail(
      :subject => 'Welcome to WeRKD',
      :to => user.email,
      :from => Figleaf::Settings.email.support,
      :tag => 'welcome'
    )
  end

end
