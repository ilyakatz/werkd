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
      @contacts = load_and_persist

      unless @contacts.present?
        redirect_to action: :index
      end

    end

    def failure
      #TODO: implement me
    end

    private

    def load_and_persist
      contacts = Rails.cache.read(cachekey)
      cs = ::ContactsService.new(contacts, current_user)
      cs.save
      Rails.logger.info("Saved #{contacts.count} into database")
      cs.contacts
    end

    def cachekey
      "#{WeRKD::Application.config.secret_token}/#{session["session_id"]}/contacts"
    end

  end
end
