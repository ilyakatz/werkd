object @collaboration
attributes(
  :id,
  :contribution,
  :skill_list
)

node(:pending) do |collaboration|
  collaboration.pending?
end

