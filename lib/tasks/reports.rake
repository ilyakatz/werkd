vendored_cucumber_bin = Dir["#{Rails.root}/vendor/{gems,plugins}/cucumber*/bin/cucumber"].first
$LOAD_PATH.unshift(File.dirname(vendored_cucumber_bin) + '/../lib') unless vendored_cucumber_bin.nil?

namespace :cucumber do
  Cucumber::Rake::Task.new({ :reports => 'test:prepare' }, 'Run all features and create a report') do |t|
    t.binary = vendored_cucumber_bin # If nil, the gem's binary is used.
    t.fork = true # You may get faster startup if you set this to false
    t.profile = 'default'
    t.cucumber_opts = %w{--format html --out public/features.html --format progress}
  end
end

namespace :werkd do
  desc 'generate and open reports'
  task reports: :environment do
    output = "/tmp/features.html"

      puts "Removing old reports"
    `rm #{output}`

    puts "Running tests"
    vendored_cucumber_bin="cucumber"

    `#{vendored_cucumber_bin} --format html --out #{output} --format progress --profile default`

    `open #{output}`
  end
end

