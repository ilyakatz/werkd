class Connection < ActiveRecord::Base
  attr_accessible :connected_to, :user_id

  belongs_to :contact, class_name: "User", :foreign_key => :connected_to
  has_one :user

  def self.created_pending_connections(inviter, invitee)
    connection = Connection.new
    connection.user_id = inviter.id
    connection.connected_to=invitee.id
    connection.sent_at = Time.now
    connection.save!

    connection = Connection.new
    connection.user_id = invitee.id
    connection.connected_to=inviter.id
    connection.save!
  end

  def accepted?
    !!self.accepted_at
  end
end
