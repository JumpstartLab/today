# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Today::Application.load_tasks

task import: :environment do
  session = "gschool_session_0"
  Dir["#{session}/**/*.markdown"].each do |file|

    file_date = File.basename(file).gsub(File.extname(file),"")
    outline_date = DateTime.parse("20#{file_date}").to_date

    contents = File.read(file)

    # remove yaml front matter
    contents = contents.gsub(/\A---\s*\n(.+\n)*^---\s*\n/,'')

    # remove all the instances of page url helper tag

    contents = contents.gsub(/\{% page_url (.+) %\}/,'http://tutorials.jumpstartlab.com/$1')

    puts "Creating Outline for #{outline_date}"
    Outline.create! title: outline_date.to_s, body: contents, publish_date: outline_date

  end
end