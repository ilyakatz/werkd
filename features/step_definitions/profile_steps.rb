Given(/^#{capture_model} has complete profile$/) do |u|
  user = model(u)
  user.projects<<3.times.collect{FactoryGirl.create(:project)}
end

