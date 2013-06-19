module Users
  class InvitationsController < ApplicationController

    before_filter :authenticate_user!

    respond_to :js

    def create
      @invitation = create_invitation(params[:email], current_user)
      respond_with(@invitation) do |format|
        format.js { render json: @invitation.to_json }
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
