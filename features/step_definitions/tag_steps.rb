When(/^I tag #{capture_model} on the project$/) do |u|
  user = model(u)
  step %{I fill in "Collaborators" with "#{user.id}"}
end

