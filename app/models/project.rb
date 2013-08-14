class Project < ActiveRecord::Base

  MINIMUM_PROJECTS_PER_USER = 3

  belongs_to :creator, class_name: "User", foreign_key: :user_id
  has_many :collaborations
  has_many :collaborators, through: :collaborations
  has_many :taggings, conditions: { taggable_type: Project }, class_name: 'Tagging', foreign_key: :taggable_id

  acts_as_taggable
  acts_as_taggable_on :roles
  validates_presence_of :title, :company

  after_save :extract_embed

  def preview_available?
    !!embed_url
  end

  def tagged_users=(users)
    tag_users(users)
  end

  def tagged_user_ids=(users_ids)
    if users_ids.class == String
      users_ids = users_ids.split(",")
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

  def tag_users(users)
    clear_current_tags
    users.each do |user|
      user.tag(self, with: participant_role, on: participant_role)
    end
  end

  def clear_current_tags
    tagged_users.each do |user|
      user.tag(self, with: "", on: participant_role)
    end
  end

  def participant_role
    "participant"
  end

  def extract_embed
    if media_url_changed?
      extract_embed_url(media_url)
    end
  end

  def extract_embed_url(media_url)
    embed = @@embedly_api.oembed(url: media_url)
    self.embed_url = embed.first.html
  rescue
    Rails.logger.info("Unable to extract oembed from #{media_url}")
    nil
  end

end
