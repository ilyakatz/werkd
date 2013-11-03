When(/^I click "(.*?)" icon within "(.*?)"$/) do |link_selector, selector|
  with_scope(selector) do
    find(link_selector).click
  end
end

Given(/^#{capture_model} created project "(.*?)"$/) do |user_model, project_title|
  user = model!(user_model)
  project = FactoryGirl.build(:project, title: project_title, creator: user)
  project.collaborations = [FactoryGirl.build(:collaboration, project: project, collaborator: user)]
  project.save!
end

