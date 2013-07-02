module Users
  class InvitationsController < Devise::InvitationsController

    skip_before_filter :require_no_authentication, :only => [:edit]
    before_filter :authenticate_user!, only: [:edit, :show, :index]

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
    end
    #def authenticate_user!
    #  warden.authenticate!(scope: :user)
    #end

  end
end
