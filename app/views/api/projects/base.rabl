object @project
attributes(
  :id,
  :title,
  :company,
  :thumbnail_url,
  :cloudinary_id,
  :embed_html
)

child(creator: :creator) do
  extends('/api/users/base')
end

child(accepted_collaborators: :contributors) do
  extends('/api/users/base')
end

child(pending_contributors: :pending_contributors) do
  extends('/api/users/base')
end
