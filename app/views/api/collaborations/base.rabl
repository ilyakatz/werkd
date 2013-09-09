object @collaboration
attributes(
  :id
)

child(:collaborator) do
  extends('/api/users/base')
end
