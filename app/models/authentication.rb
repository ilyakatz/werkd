# == Schema Information
#
# Table name: authentications
#
#  id          :integer          not null, primary key
#  provider    :string(255)
#  provider_id :string(255)
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Authentication < ActiveRecord::Base
  attr_accessible :provider, :provider_id, :user_id

  belongs_to :user
end
