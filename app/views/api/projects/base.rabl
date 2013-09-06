object @project
attributes(
  :id,
  :title,
  :thumbnail_url,
  :user_id
)

child(creator: :creator) do
  extends('/api/users/base')
end
