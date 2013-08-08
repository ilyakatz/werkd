When(/^I tag #{capture_model} on the project$/) do |u|
  user = model(u)
  step %{I fill in "project_tagged_user_ids" with "#{user.id}"}
end

