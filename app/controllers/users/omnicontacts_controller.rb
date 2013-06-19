module Users
  class OmnicontactsController < ApplicationController

    before_filter :authenticate_user!

    def callback
      Rails.logger.info("Storing contacts into #{cachekey}")
      Rails.cache.write(cachekey, request.env['omnicontacts.contacts'], expire: 10.minutes)
      redirect_to action: :show, id: params[:importer]
    end

    def index
    end

    def show
      Rails.logger.info("Reading contacts from #{cachekey}")
      @importer = params[:id]
      contacts = Rails.cache.read(cachekey)
      cs = ::ContactsService.new(contacts, current_user)
      cs.save
      @contacts = cs.contacts
      Rails.logger.info("Saved #{@contacts.count} into database")
      unless @contacts.present?
        redirect_to action: :index
      end
    end

    def failure
      #TODO: implement me
    end

    private

    def cachekey
      "#{WeRKD::Application.config.secret_token}/#{session["session_id"]}/contacts"
    end

  end
end
