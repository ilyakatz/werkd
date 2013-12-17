module BetaAccess
  extend ActiveSupport::Concern

  def beta_access
    return unless enforce_beta_access?
    ensure_beta_access

    (render text: "Private beta access required" if !has_beta_access?) and return
  end

  def beta_access_enabled?
    Figleaf::Settings.beta_access.enabled?
  end

  def has_beta_access?
    has_global_beta_token? || has_valid_invite_token?
  end

  def has_global_beta_token?
    Figleaf::Settings.beta_access.tokens.include?(session[:beta])
  end

  #user has beta token and that token is present
  def has_valid_invite_token?
    session[:beta] && UserInvite.where(token: session[:beta])
  end

  def redirect_to_sign_up_for_beta?
    true
  end

  def ensure_beta_access
    if params[:beta]
      #if the token has not been used yet
      if invite = UserInvite.pending?(params[:beta])
        session[:beta]=params[:beta]
        invite.use!
      elsif Figleaf::Settings.beta_access.tokens.include?(params[:beta])
        session[:beta] = params[:beta]
      end
    end
  end

  def enforce_beta_access?
    beta_access_enabled? && !user_signed_in?
  end
end
