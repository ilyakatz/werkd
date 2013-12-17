object @user
extends('/api/users/base')

child(:collaborations, object_root: false) do
  extends('/api/collaborations/base')
  child(:project) do
    extends('/api/projects/base')
    child(creator: :creator) do
      extends('/api/users/base')
    end
    child(collaborations: :collaborations) do
      extends('/api/collaborations/base')
      child(collaborator: :user) do
        extends('/api/users/base')
      end
    end
    # TODO: the below child nodes should be removed
    child(accepted_collaborators: :contributors) do
      extends('/api/users/base')
    end
    child(pending_contributors: :pending_contributors) do
      extends('/api/users/base')
    end
  end
end

child(:connections, object_root: false) do
  extends('/api/connections/base')
  node(:user) do |connection|
    user = connection.other_user(@user)
    partial('/api/users/base', object: user)
  end
end
