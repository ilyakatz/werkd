class ImportedContact < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :referer_id

  belongs_to :user, foreign_key: :referer_id
end
