Given(/^#{capture_model} has complete profile$/) do |u|
  user = model(u)
  user.last_name="sadf" unless user.last_name
  user.first_name="sdgf" unless user.first_name
  user.job_title="doer" unless user.job_title
  user.invited_contacts = Time.now
  user.save
  3.times.collect{FactoryGirl.create(:project, creator: user)}
end

Given(/^#{capture_model} has a connection #{capture_model}$/) do |u1, u2|
  user1 = model(u1)
  user2 = model(u2)
  user1.connect_to!(user2)
end

Given(/^#{capture_model} has basic profile$/) do |u|
  user = model(u)
  user.last_name="sadf" unless user.last_name
  user.first_name="sdgf" unless user.first_name
  user.job_title="doer" unless user.job_title
  user.save
end

Given(/^#{capture_model} invited_contacts$/) do |u|
  user = model(u)
  user.invited_contacts = Time.now
  user.save
end

Then(/^#{capture_model} should be marked as having invited contacts$/) do |u|
  user = model(u)
  user.invited_contacts?.should be_true
end

