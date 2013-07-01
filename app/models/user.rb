class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  devise :invitable, :omniauthable, :omniauth_providers => [:google_oauth2,
    :facebook, :linkedin_oauth2]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :first_name, :last_name,
    :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  has_many :authentications

  has_many :connections
  has_many :contacts, through: :connections

  def self.find_for_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(email: data["email"]).first

    unless user
      user = User.create(
        first_name: data["first_name"],
        last_name: data["last_name"],
        email: data["email"],
        password: Devise.friendly_token[0, 20]
      )
      WelcomeMailer.send_welcome_email(self).deliver!
    end
    user
  end

  def self.find_for_facebook_oauth(authentication, signed_in_resource=nil)
    auth = Authentication.where(provider: authentication.provider, provider_id: authentication.uid).first
    unless auth
      auth = Authentication.new(
        provider: authentication.provider,
        provider_id: authentication.uid,
      )
    end

    user = auth.user
    unless user
      #check that there isn't already a user with this email, if there is add authentication
      existing_user = User.where(email: authentication.info.email).first
      if existing_user
        existing_user.authentications << auth
        user = existing_user
        user.save!
      else
        user = User.new(
          first_name: authentication.extra.raw_info.first_name,
          last_name: (authentication.extra.raw_info.last_name rescue nil),
          email: authentication.info.email,
          password: Devise.friendly_token[0, 20]
        )
        user.authentications << auth
        user.save!
        WelcomeMailer.send_welcome_email(self).deliver!
      end
    end


    user
  end


  #not invited by anyone or invitation accepted
  def confirmed?
    !invited_by_id || !!invitation_accepted_at
  end

  #create a meaningful professional connection
  def connect_to!(user)
    self.contacts << user
  end

end
