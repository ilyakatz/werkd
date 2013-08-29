class Project < ActiveRecord::Base

  MINIMUM_PROJECTS_PER_USER = 3
  PREVIEW_MAX_WIDTH = 304
  PREVIEW_MAX_HEIGHT = 171

  belongs_to :creator, class_name: "User", foreign_key: :user_id
  has_many :collaborations
  has_many :collaborators, through: :collaborations
  has_many :taggings, conditions: { taggable_type: Project }, class_name: 'Tagging', foreign_key: :taggable_id

  acts_as_taggable
  acts_as_taggable_on :roles
  validates_presence_of :title, :company, :tag_list

  before_save :extract_embed

  def preview_available?
    !!embed_url || !!embed_html
  end

  def tagged_users=(users)
    tag_users(users)
  end

  def tagged_user_ids=(users_ids)
    if users_ids.class == String
      users_ids = user_ids_from_string(users_ids)
    end
    users = User.where(id: users_ids)
    tag_users(users)
  end

  #return string with ids
  def tagged_user_ids
    taggings.where(context: participant_role).
      where(tagger_type: User).collect(&:tagger_id)
  end

  def tagged_users
    User.where(id: tagged_user_ids)
  end

  private

  def user_ids_from_string(users_ids)
    users_ids = users_ids.split(",")
    #go through each element and if it's an email
    #create a User
    ids = users_ids.collect do |id|
      id.gsub!(/\s+/, "")
      #id is an email
      if id.to_i.to_s != id
        User.find_or_create_by_email(id).id
      else
        id
      end
    end
    ids
  end

  def tag_users(users)
    users_to_remove = tagged_users - users
    users_to_add = users - tagged_users
    clear_current_tags(users_to_remove)
    users_to_add.each do |user|
      ContactsMailer.send_tag_created(self.id, user.id)
      user.tag(self, with: participant_role, on: participant_role)
    end
  end

  def clear_current_tags(users)
    users.each do |user|
      user.tag(self, with: "", on: participant_role)
    end
  end

  def participant_role
    "participant"
  end

  def extract_embed
    if media_url_changed? and media_url.present?
      Rails.logger.info("Extracting media url #{media_url}")
      extract_embed_url(media_url)
    end
  end

  def extract_embed_url(media_url)
    embed = @@embedly_api.oembed(url: media_url,
                                 maxheight: PREVIEW_MAX_HEIGHT,
                                 maxwidth: PREVIEW_MAX_WIDTH)
    if embed.first.try(:html)
      self.embed_html   = embed.first.html
      self.thumbnail_url= embed.first.thumbnail_url
    elsif embed.first.try(:url)
      #this is an image
      cu = Cloudinary::Uploader.upload(embed.first.url, width: Project::PREVIEW_MAX_WIDTH, height: Project::PREVIEW_MAX_HEIGHT, crop: :limit)
      self.thumbnail_url=cu["url"]
    end
    #rescue
    #  Rails.logger.info("Unable to extract oembed from #{media_url}")
    #  nil
  end

end
