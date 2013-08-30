object @user
extends('/api/users/base')

child(:collaborated_projects) do
  extends('/api/projects/base')
  child(:collaborations, object_root: false) do
    extends('/api/collaborations/base')
  end
end

child(:connections, object_root: false) do
  extends('/api/connections/base')
  node(:user) do |connection|
    user = connection.other_user(@user)
    partial('/api/users/base', object: user)
  end
end
