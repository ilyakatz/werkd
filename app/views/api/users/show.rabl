object @user
extends('/api/users/base')

child(:collaborated_projects) do
  extends('/api/projects/base')
  child(:collaborations) do
    extends('/api/collaborations/base')
  end
end

child(:connections) do
  extends('/api/connections/base')
  node(:user) do |connection|
    user = connection.other_user(@user)
    partial('/api/users/base', object: user)
  end
end
