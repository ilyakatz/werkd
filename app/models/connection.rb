class Connection < ActiveRecord::Base
  attr_accessible :connected_to, :user_id

  belongs_to :inviter, class_name: "User", :foreign_key => :user_id
  belongs_to :invitee, class_name: "User", :foreign_key => :connected_to
  has_one :user

  def self.create_pending_connections(inviter, invitee)
    connection = Connection.new
    connection.user_id = inviter.id
    connection.connected_to=invitee.id
    connection.sent_at = Time.now
    connection.save!
    connection
  end

  def accepted?
    !!self.accepted_at
  end

  def accept!
    self.accepted_at = Time.now
    self.save
  end
end
