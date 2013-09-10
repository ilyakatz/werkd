object @project
attributes(
  :id,
  :title,
  :company,
  :thumbnail_url
)

child(creator: :creator) do
  extends('/api/users/base')
end

child(accepted_collaborators: :contributors) do
  extends('/api/users/base')
end
