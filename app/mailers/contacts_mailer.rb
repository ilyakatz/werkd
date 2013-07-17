class ContactsMailer < ActionMailer::Base
  default css: 'email'

  def send_connection_accepted(connection)
    @invitee = connection.invitee
    @inviter = connection.inviter

    mail(
      :subject => 'Connection invitation Accepted',
      :to => @inviter.email,
      :from => Figleaf::Settings.email.support,
      :tag => 'invitation'
    )
  end

  def send_invitation_accepted(invitee)
    @invitee = invitee
    @inviter = invitee.invited_by

    mail(
      :subject => 'Invitation Accepted',
      :to => invitee.invited_by.email,
      :from => Figleaf::Settings.email.support,
      :tag => 'invitation'
    )
  end

  def send_connection_request(connection)
    @invitee = connection.invitee
    @inviter = connection.inviter
    @connection = connection
    mail(
      :subject => 'Invitation to connect at WeRKD',
      :to => @invitee.email,
      :from => Figleaf::Settings.email.support,
      :tag => 'invitation'
    )
  end


end
