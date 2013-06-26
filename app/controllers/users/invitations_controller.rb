module Users
  class InvitationsController < Devise::InvitationsController

    before_filter :authenticate_user!

    respond_to :json, :html

    def create
      self.resource = resource_class.invite!(resource_params, current_inviter)

      respond_to do |format|
        if resource.errors.empty?
          format.json do
            render text: "#{resource.email} invited", status: :ok
          end
          format.html do
            set_flash_message :notice, :send_instructions, :email => self.resource.email
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


    def show
    end

    def index
    end

    private

    def create_invitation(email, referer)
      invitation =
        Invitation.where(email: email).where(referer_id: referer.id).first

      if invitation
        return invitation
      else
        invitation = Invitation.new(
          email: params[:email],
          referer_id: current_user.id
        )
        return invitation
      end

    end

  end
end
