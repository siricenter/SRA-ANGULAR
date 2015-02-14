exports.config = {
	seleniumAddress: 'http://localhost:4444/wd/hub',
	specs: ['protractor/**/*.js'],
	restartBrowserBetweenTests: true,

	capabilities: {
		'browserName': 'firefox'
	}
};
