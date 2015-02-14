// Karma configuration
// http://karma-runner.github.io/0.12/config/configuration-file.html
// Generated on 2014-11-20 using
// generator-karma 0.8.3

module.exports = function(config) {
	'use strict';
	
	config.set({
		// enable / disable watching file and executing tests whenever any file changes
		autoWatch: true,
		
		// base path, that will be used to resolve files and exclude
		basePath: './',
		
		// testing framework to use (jasmine/mocha/qunit/...)
		frameworks: ['jasmine'],
		
		// list of files / patterns to load in the browser
		files: [
			'vendor/assets/bower_components/angular/angular.js',
			'vendor/assets/bower_components/angular-animate/angular-animate.js',
			'vendor/assets/bower_components/angular-aria/angular-aria.js',
			'vendor/assets/bower_components/angular-cookies/angular-cookies.js',
			'vendor/assets/bower_components/angular-messages/angular-messages.js',
			'vendor/assets/bower_components/angular-resource/angular-resource.js',
			'vendor/assets/bower_components/angular-route/angular-route.js',
			'vendor/assets/bower_components/angular-sanitize/angular-sanitize.js',
			'vendor/assets/bower_components/angular-touch/angular-touch.js',
			'vendor/assets/bower_components/firebase/firebase.js',
			'vendor/assets/bower_components/angularfire/dist/angularfire.js',
			
			'build/javascripts/app/**/*.js',
			
			'vendor/assets/bower_components/angular-mocks/angular-mocks.js',
			
			'spec/**/*.js'
		],
		
		// list of files / patterns to exclude
		exclude: [],
		
		// web server port
		port: 9876,
		
		// Start these browsers, currently available:
		// - Chrome
		// - ChromeCanary
		// - Firefox
		// - Opera
		// - Safari (only Mac)
		// - PhantomJS
		// - IE (only Windows)
		browsers: [
		'Chrome'
		],
		
		// Which plugins to enable
		plugins: [
		'karma-chrome-launcher',
			'karma-phantomjs-launcher',
			'karma-jasmine'
		],
		
		// Continuous Integration mode
		// if true, it capture browsers, run tests and exit
		singleRun: false,
		
		colors: true,
		
		// level of logging
		// possible values: LOG_DISABLE || LOG_ERROR || LOG_WARN || LOG_INFO || LOG_DEBUG
		logLevel: config.LOG_INFO,
		
		// Uncomment the following lines if you are using grunt's server to run the tests
		 //proxies: {
		 //	'/': 'http://localhost:9000/'
		 //},
		// URL root prevent conflicts with the site root
		// urlRoot: '_karma_'
	});
};
