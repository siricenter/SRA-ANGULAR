require 'rubygems'
require 'cucumber'
require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:cucumber) do |t|
	t.cucumber_opts = "features --format pretty"
end

namespace :cucumber do
	Cucumber::Rake::Task.new(:wip) do |t|
		t.cucumber_opts = "features --format pretty --tags @wip"
	end
end
