When /^(?:|I )click within "([^"]*)"$/ do |selector|
  find(selector).click
end


When /^I fill in skill "([^"]*)"$/ do |skill_name|
 script = %Q/$("#project_collaborator_skills").tokenInput("add", {id: "#{skill_name}", name: "#{skill_name}"});/
 page.evaluate_script(script)
end

When(/^I tag #{capture_model} on the project$/) do |u|
  user = model(u)
  script = %Q/$("#project_tagged_user_ids").tokenInput("add", {id: "#{user.id}", name: "#{user.first_name}"});/
  page.evaluate_script(script)
end

