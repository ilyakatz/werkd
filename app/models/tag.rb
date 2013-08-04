class Tag < ActiveRecord::Base
  include ActionView::Helpers::SanitizeHelper

  def self.abc
  end

  def self.token(q)
    query = "%#{q}%"
    tags = Tag.where("name like ?", query).limit(10)
    unless tags.present?
      tags = [{name: q, id: q}]
    end
    tags
  end

end
