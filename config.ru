require 'rack'
require 'rack/contrib/try_static'
require 'rack/rewrite'

use Rack::Rewrite do
	rewrite /\.css$/, 'stylesheets/application.css'
	rewrite /\.js$/, 'javascripts/application.js'
	rewrite /.+(\/fonts\/.*)$/, "$1"
end

use Rack::TryStatic,
	root: 'build',
	urls: %w[fonts]

use Rack::TryStatic,
	root: 'build',
	urls: %w[stylesheets javascripts]

use Rack::TryStatic,
	root: 'build',
	urls: ['/'],
	try: ['/index.html']

run lambda{|env|
	[
		200, {
			'Content-Type' => 'text/html',
			'CacheControl' => 'public, max-age=86400'
		},
		File.open('build/index.html', File::RDONLY)
	]
}
