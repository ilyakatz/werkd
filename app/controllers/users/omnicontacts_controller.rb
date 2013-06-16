module Users
  class OmnicontactsController < ApplicationController

    before_filter :authenticate_user!

    def callback
      Rails.cache.write(cachekey, request.env['omnicontacts.contacts'], expire: 10.minutes)
      redirect_to action: :show, id: params[:importer]
    end

    def index
    end

    def show
      @importer = params[:id]
      @contacts = Rails.cache.read(cachekey)
      unless @contacts.present?
        redirect_to action: :index
      end
    end

    private

    def cachekey
      "#{WeRKD::Application.config.secret_token}/#{session["session_id"]}/contacts"
    end

  end
end
