class WelcomeMailer <ActionMailer::Base

  def send_welcome_email(user)
    mail(
      :subject => 'hello',
      :to => user.email,
      :from => Figleaf::Settings.email.support,
      :tag => 'welcome'
    )
  end

end
