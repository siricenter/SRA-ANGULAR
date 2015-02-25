require 'rack'
require 'rack/contrib/try_static'
require 'rack/rewrite'

use Rack::TryStatic,
	root: 'build',
	urls: %w[/],
	try: ['index.html', '/index.html']

run lambda{|env|
	[
		200, {
			'Content-Type' => 'text/html',
			'CacheControl' => 'public, max-age=86400'
		},
		File.open('build/index.html', File::RDONLY)
	]
}
