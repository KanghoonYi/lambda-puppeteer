# lambda-puppeteer
How to run puppeteer on AWS lambda

## Introduce
For running puppeteer on AWS lambda, some process is required.   
This repository explains it.

## Requirement
* docker: For creating container image running on AWS lambda
* Running puppeteer on lambda(centos) has some dependency.
    ```
    // from https://github.com/puppeteer/puppeteer/blob/main/docs/troubleshooting.md#chrome-headless-doesnt-launch-on-unix
    ca-certificates
    fonts-liberation
    libappindicator3-1
    libasound2
    libatk-bridge2.0-0
    libatk1.0-0
    libc6
    libcairo2
    libcups2
    libdbus-1-3
    libexpat1
    libfontconfig1
    libgbm1
    libgcc1
    libglib2.0-0
    libgtk-3-0
    libnspr4
    libnss3
    libpango-1.0-0
    libpangocairo-1.0-0
    libstdc++6
    libx11-6
    libx11-xcb1
    libxcb1
    libxcomposite1
    libxcursor1
    libxdamage1
    libxext6
    libxfixes3
    libxi6
    libxrandr2
    libxrender1
    libxss1
    libxtst6
    lsb-release
    wget
    xdg-utils
    ```
* Puppeteer running on lambda linux could not use `sandbox`
    ```
    // from https://github.com/puppeteer/puppeteer/blob/main/docs/troubleshooting.md#recommended-enable-user-namespace-cloning
    const browser = await puppeteer.launch({
      args: ['--no-sandbox', '--disable-setuid-sandbox'],
    });
    ```

## Build Image
```
# build container image
docker build -t aws-lambda-puppeteer:latest ./
```

## Test
```
# build container image
docker build -t aws-lambda-puppeteer:latest ./

# create container for test
docker run -p 9000:8080 aws-lambda-puppeteer:latest

# execute lambda handler
curl -XPOST "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{}'
```

## References
- https://github.com/puppeteer/puppeteer/blob/main/docs/troubleshooting.md#chrome-headless-doesnt-launch-on-unix
- https://aws.amazon.com/ko/blogs/architecture/field-notes-scaling-browser-automation-with-puppeteer-on-aws-lambda-with-container-image-support/
- https://docs.aws.amazon.com/lambda/latest/dg/images-create.html
