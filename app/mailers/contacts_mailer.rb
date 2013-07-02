class ContactsMailer < ActionMailer::Base

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


end
