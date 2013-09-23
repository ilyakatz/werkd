object @user
extends('/api/users/base')

child(:projects, object_root: false) do
  extends('/api/projects/base')
  node(:skills) do
    ['Design', 'Illustration', 'Video Editing']
  end
end

child(:connections, object_root: false) do
  extends('/api/connections/base')
  node(:user) do |connection|
    user = connection.other_user(@user)
    partial('/api/users/base', object: user)
  end
end