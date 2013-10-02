object @user
extends('/api/users/base')

child(:all_projects, object_root: false) do
  extends('/api/projects/base')
  node(:skills) do |p|
    p.tags.collect(&:name)
  end
end

child(:connections, object_root: false) do
  extends('/api/connections/base')
  node(:user) do |connection|
    user = connection.other_user(@user)
    partial('/api/users/base', object: user)
  end
end
