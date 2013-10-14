# == Schema Information
#
# Table name: connections
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  connected_to :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  sent_at      :time
#  accepted_at  :time
#

class Connection < ActiveRecord::Base
  attr_accessible :connected_to, :user_id

  belongs_to :inviter, class_name: "User", :foreign_key => :user_id
  belongs_to :invitee, class_name: "User", :foreign_key => :connected_to
  has_one :user

  # Scopes:

  validates_uniqueness_of :connected_to, scope: :user_id

  # Creates a new pending connection unless there is one already
  def self.create_pending_connections(inviter, invitee)
    existing = inviter.connections.
      where("user_id = ? or connected_to =?", invitee.id, invitee.id).exists?

    unless existing
      connection = Connection.new
      connection.user_id = inviter.id
      connection.connected_to=invitee.id
      connection.sent_at = Time.now
      connection.save!
      connection
    end
  end

  def self.create_accepted_connection(inviter, invitee)
    connection = create_pending_connections(inviter, invitee)
    connection.accept! if connection
  end

  def accepted?
    !!self.accepted_at
  end


  def accept!
    self.accepted_at = Time.now
    self.save
  end

  # Methods:

  def other_user(user)
    if inviter == user
      invitee
    else
      inviter
    end
  end

end
