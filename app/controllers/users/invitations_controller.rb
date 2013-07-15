module Users
  class InvitationsController < Devise::InvitationsController

    skip_before_filter :require_no_authentication, :only => [:edit]
    before_filter :authenticate_user!, only: [:edit, :show, :index]

    respond_to :json, :html

    def create
      if invitee = User.where(email: invitation_email).first
        existing_user_invitation(invitee, current_user)
      else
        new_user_invitation(resource_params, current_user)
      end
    end

    def update
      self.resource = resource_class.accept_invitation!(resource_params)

      if resource.errors.empty?
        flash_message = resource.active_for_authentication? ? :updated : :updated_not_active

        after_accept_actions(resource)

        set_flash_message :notice, flash_message
        sign_in(resource_name, resource)
        respond_with resource, :location => after_accept_path_for(resource)
      else
        respond_with_navigational(resource) { render :edit }
      end
    end

    private

    def after_accept_actions(user)
      user.contacts << user.invited_by
      user.invited_by.contacts << user
      ContactsMailer.send_invitation_accepted(user).deliver!
      WelcomeMailer.send_welcome_email(user).deliver!
    end

    def invitation_email
      resource_params[:email]
    end

    def new_user_invitation(resource_params, current_inviter)
      resource = resource_class.invite!(resource_params, current_inviter)
      respond_to do |format|
        if resource.errors.empty?
          format.json do
            render text: "#{resource.email} invited", status: :ok
          end
          format.html do
            set_flash_message :notice, :send_instructions, :email => resource.email
            respond_with resource, :location => after_invite_path_for(resource)
          end
        else
          format.json do
            render text: resource.errors, status: :internal_server_error
          end
          format.html do
            respond_with_navigational(resource) { render :new }
          end
        end
      end
    end

    def existing_user_invitation(invitee, inviter)
      ContactsMailer.send_connection_request(invitee, inviter).deliver!
      Connection.created_pending_connections(invitee, inviter)
      redirect_to after_invite_path_for(invitee), notice: "Invitation to connect has been sent"
    end


  end
end
