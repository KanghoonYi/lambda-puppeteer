const puppeteer = require('puppeteer');

exports.main = async (event) => {
	const browser = await puppeteer.launch();
	const page = await browser.newPage();
	await page.goto('https://www.google.com');
	await page.close();
	await browser.close();
	return {
		status: 200,
		body: 'success',
	};
}
