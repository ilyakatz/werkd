vendored_cucumber_bin = Dir["#{Rails.root}/vendor/{gems,plugins}/cucumber*/bin/cucumber"].first
$LOAD_PATH.unshift(File.dirname(vendored_cucumber_bin) + '/../lib') unless vendored_cucumber_bin.nil?

namespace :cucumber do
  Cucumber::Rake::Task.new({ :reports => 'test:prepare' }, 'Run all features and create a report') do |t|
    t.binary = vendored_cucumber_bin # If nil, the gem's binary is used.
    t.fork = true # You may get faster startup if you set this to false
    t.profile = 'default'
    t.cucumber_opts = %w{--format html --out public/features.html}
  end
end
