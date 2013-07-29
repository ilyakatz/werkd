class Project < ActiveRecord::Base
  belongs_to :creator, class_name: "User", foreign_key: :user_id
  has_many :collaborations
  has_many :collaborators, through: :collaborations

  validates_presence_of :title, :company

  after_save :extract_embed

  def preview_available?
    !!embed_url
  end

  private

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
