class ContactsService

  # Params
  # @contacts is an array of hashes
  #[
  #  {
  #    :id => "http://www.google.com/m8/feeds/contacts/ilyakatz%40gmail.com/base/8",
  #    :first_name => "Arun", :last_name => nil, :name => "Arun", :email => "aradha02@utopia.poly.edu",
  #    :gender => nil, :birthday => nil, :profile_picture => nil, :relation => nil
  #  }
  #]
  # The following are required
  #  :first_name
  #  :last_name
  #  :email
  #
  # @referrer User who added the contacts
  def initialize(contacts, referrer)
    @contacts = contacts
    @referrer = referrer
    cleanup_contacts
  end

  def save
    c = []
    @contacts[0..-1].each do |contact|
      c << ImportedContact.new(contact.slice(*attributes).merge(referer_id: @referrer.id))
    end

    begin
      ImportedContact.import(c)
    rescue ActiveRecord::RecordNotUnique => e
    end
  end

  attr_accessor :contacts

  private

  def cleanup_contacts
    @contacts.reject! { |hash| hash[:email].nil? }
  end

  def attributes
    @attributes ||= ImportedContact.new.attributes.collect { |k, v| k.to_sym } - [:id]
  end

end
