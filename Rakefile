desc "Default task - builds the application without running tests."
task default: :build


desc "Cleans build. Optional to also clean bower_components & node_modules."
task :clean, :all do |_, args|
	args.with_default(all: false)
	options = ""

	options = "vendor/assets/bower_components node_modules" if args[:all]

	sh   "rm -rf build #{options}"
end

desc "Installs NPM packages"
task :npm do
	sh 'npm install'
end

desc "Installs bower components"
task :bower => :npm do
	sh 'bower install'
end

desc "Builds the application"
task :build => [:clean, :npm, :bower] do
	sh 'bundle exec middleman build --verbose'
end

desc "Builds the application and runs the test"
task :test => :build do
	sh 'npm test'
end

namespace :assets do
	task :precompile => :build
end
