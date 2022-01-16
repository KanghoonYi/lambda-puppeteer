const puppeteer = require('puppeteer');

exports.main = async (event) => {
	const browser = await puppeteer.launch({
		args: [
			'--allow-running-insecure-content',
			'--autoplay-policy=user-gesture-required',
			'--disable-component-update',
			'--disable-domain-reliability',
			'--disable-features=AudioServiceOutOfProcess,IsolateOrigins,site-per-process',
			'--disable-print-preview',
			'--disable-site-isolation-trials',
			'--disable-speech-api',
			'--disable-dev-shm-usage',
			'--disk-cache-size=33554432',
			'--enable-features=SharedArrayBuffer',
			'--font-render-hinting=none',
			'--hide-scrollbars',
			'--ignore-gpu-blocklist',
			// '--in-process-gpu',
			'--mute-audio',
			'--no-default-browser-check',
			'--no-pings',
			'--no-zygote',
			'--use-gl=swiftshader',
			'--window-size=1920,1080',
			'--no-sandbox',
			'--disable-setuid-sandbox',
			'--headless',
			'--disable-extensions',
			'--log-level=0',
			'--single-process',
			'--disable-gpu',
			'--use-gl=opengl',
		]
	});
	const page = await browser.newPage();
	await page.goto('https://www.google.com');
	await page.close();
	await browser.close();
	return {
		status: 200,
		body: 'success',
	};
}
