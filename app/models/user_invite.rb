class UserInvite < ActiveRecord::Base

  after_create :generate_token

  attr_accessible :token

  def self.pending?(token)
    UserInvite.where(token: token).where(used_at: nil).first
  end

  def use!
    self.used_at=Time.now
    save!
  end

  private

  def generate_token
    loop do
      self.token = Devise.friendly_token
      break token unless UserInvite.exists?(token: token)
    end
    save
  end

end
