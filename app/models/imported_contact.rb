# == Schema Information
#
# Table name: imported_contacts
#
#  id         :integer          not null, primary key
#  first_name :string(255)
#  last_name  :string(255)
#  email      :string(255)      not null
#  referer_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ImportedContact < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :referer_id

  belongs_to :user, foreign_key: :referer_id
end
