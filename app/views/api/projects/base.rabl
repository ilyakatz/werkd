object @project
attributes(
  :id,
  :title,
  :thumbnail_url
)

child(creator: :creator) do
  extends('/api/users/base')
end
