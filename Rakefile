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

desc "Does any setup not taken care of by other setup tasks"
task :setup do
	sh './setup/setup.sh'
	sleep 3
end

desc "Installs bower components"
task :bower => :npm do
	sh 'node_modules/bower/bin/bower install'
end

desc "Builds the application"
task :build => [:npm, :bower] do
	sh 'bundle exec middleman build --verbose'
end

desc "Runs the unit tests"
task :unit do
	sh 'npm test'
end

desc "Sets up the functional tests"
task :function => [:setup] do
	sh './node_modules/protractor/bin/protractor conf.js;'
end

desc "Sets up a local server"
task :serve do# => :build do
	is_running = `ps aux | grep thin | grep -v "grep"`
	sh 'bundle exec thin start -d -p $PORT' if is_running.empty?
end

desc "Builds the application and runs the test"
task :test => [:build, :unit, :serve, :function]

desc "Runs the tests, but doesn't build the app"
task :testlocal => [:unit, :serve, :function]

namespace :assets do
	task :precompile => :build
end
