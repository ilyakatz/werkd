module Users
  class OmnicontactsController < ApplicationController

    def callback
      Rails.cache.write(cachekey, request.env['omnicontacts.contacts'], expire: 10.minutes)
      redirect_to method: :show, id: params[:importer]
    end

    def index
    end

    def show
      @importer = params[:importer]
      @contacts = Rails.cache.read(cachekey)
    end

    private

    def cachekey
      "#{WeRKD::Application.config.secret_token}/#{session["session_id"]}/contacts"
    end

  end
end
