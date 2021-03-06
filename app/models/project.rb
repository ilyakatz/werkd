# == Schema Information
#
# Table name: projects
#
#  id            :integer          not null, primary key
#  title         :string(255)
#  company       :string(255)
#  user_id       :integer
#  video         :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  media_url     :string(255)
#  contribution  :string(255)
#  start_at      :date
#  embed_html    :string(255)
#  thumbnail_url :string(255)
#

class Project < ActiveRecord::Base

  MINIMUM_PROJECTS_PER_USER = 1
  PREVIEW_MAX_WIDTH = 304
  PREVIEW_MAX_HEIGHT = 171

  belongs_to :creator, class_name: "User", foreign_key: :user_id
  has_many :collaborations
  has_many :collaborators, through: :collaborations
  has_many :taggings, conditions: { taggable_type: Project }, class_name: 'Tagging', foreign_key: :taggable_id

  validates_presence_of :title, :company

  before_save :extract_embed

  attr_accessible :company, :title, :contribution, :media_url, :start_at,
    :tagged_user_ids

  attr_accessible :collaborations_attributes

  accepts_nested_attributes_for :collaborations

  after_create :add_collaboration

  def accepted_collaborators
    collaborators.where("accepted_at IS NOT NULL")
  end

  def cloudinary_id
    thumbnail_url.try { |url|
      url.match(/\/([a-z0-9]+\.[a-z]+)$/)[1]
    }
  end

  def pending_contributors
    collaborators.where("accepted_at IS NULL")
  end

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
    tagged_users.collect(&:id)
  end

  def tagged_users
    collaborators - [creator_collaborator]
  end

  #@params
  # number_of_projects - how many more projects
  def self.missing_project_message(number_of_projects)
    case number_of_projects
    when 1
      "Please add at least one project."
    end
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
      self.collaborators << user
    end
  end

  def clear_current_tags(users)
    collaborations.where(user_id: users.collect(&:id)).destroy_all
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

    case embed.first.try(:type)
    when "video", "rich"
      self.embed_html = embed.first.html
      image_url = embed.first.thumbnail_url
    when "photo"
      self.embed_html = nil
      image_url = embed.first.url
    when "link"
      self.embed_html = nil
      image_url = embed.first.thumbnail_url
    end

    self.media_type = embed.first.try(:type)

    if image_url
      # TODO: Perhaps we shouldn't constrain width/height since we can do this in the view (i.e., allow any size image for upload)
      cloudinary_url = Cloudinary::Uploader.upload(image_url, width: Project::PREVIEW_MAX_WIDTH, height: Project::PREVIEW_MAX_HEIGHT, crop: :limit)
      self.thumbnail_url = cloudinary_url['url']
    end
  end


  def add_collaboration
    collaborations = self.collaborations.build
    creator = collaborations
    creator.collaborator = self.creator
    creator.accepted_at = Time.now
    collaborations.save
  end

  def creator_collaborator
    collaborators.where(id: self.creator).first
  end

end
