'use strict'

const webshot = require('webshot');

const URL = 'https://www.google.nl/maps/@52.1599098,4.7838344,10.29z/data=!5m1!1e1?force=lite';
let outputfile = process.argv[2];
const options = {
	screenSize: {
		width: 1280,
		height: 720
	},
	shotSize: {
		width: 1280,
		height: 'all'
	},
	renderDelay: 1000, // milliseconds
	userAgent: 'Mozilla/5.0(iPad; U; CPU iPhone OS 3_2 like Mac OS X; en-us) AppleWebKit/531.21.10 (KHTML, like Gecko) Version/4.0.4 Mobile/7B314 Safari/531.21.10',
};

webshot(URL, outputfile, options, function (err) {
	// screenshot now saved
});
