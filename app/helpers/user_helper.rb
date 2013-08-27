module UserHelper

  def display_user_name(user, public)
    public ? user.public_name : name_and_email(user)
  end

  def name_and_email(user)
    "#{user.public_name} (#{user.email})"
  end

end
