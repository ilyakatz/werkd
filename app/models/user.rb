class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable##, :validatable

  devise :invitable, :omniauthable, :omniauth_providers => [:google_oauth2,
                                                            :facebook, :linkedin_oauth2]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :first_name, :last_name,
    :password, :password_confirmation, :remember_me,
    :location, :job_title
  # attr_accessible :title, :body

  has_many :authentications
  has_many :projects

  acts_as_tagger

  def connections
    Connection.where("user_id = ? or connected_to =?", self.id, self.id)
  end

  def connected_users
    #connection where I initiated the request
    users = Connection.where("user_id = ?", self.id).collect(&:invitee)

    #connection where someone else sent request
    users + Connection.where("connected_to = ?", self.id).collect(&:inviter)
  end

  def self.token(q)
    query = "%#{q}%"
    res = User.where("email LIKE ? OR first_name LIKE ? or last_name LIKE ?", query, query, query).limit(10)
  end

  def self.json_token(q)
    res = token(q)
    if res.present?
      res.collect do |user|
        {id: user.id, name: user.public_name}
      end.to_json
    else
      if q =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
        [{id: q, name: q}].to_json
      else
      [].to_json
      end
    end
  end

  def public_name
    if first_name || last_name
      [first_name, last_name].compact.join(" ")
    else
      "WeRKD user"
    end
  end

  def set_invited_contacts
    update_attribute(:invited_contacts, Time.now) unless invited_contacts?
  end

  #this is the name used in personal communication with the user
  #it doesn't make sense to refer to them as WeRKD user if we send them an email
  def communication_name
    if first_name || last_name
      [first_name, last_name].compact.join(" ")
    else
      ""
    end
  end

  def profile_status
    if !(first_name.present? && last_name.present? and job_title.present?)
      :basics
    elsif !invited_contacts?
      :contacts
    elsif projects.count < Project::MINIMUM_PROJECTS_PER_USER
      :projects
    else
      :complete
    end
  end


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
      WelcomeMailer.send_welcome_email(user).deliver!
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
    Connection.create_pending_connections(self, user)
  end

end
