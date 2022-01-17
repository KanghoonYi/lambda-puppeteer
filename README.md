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
  alsa-lib.x86_64
  atk.x86_64
  cups-libs.x86_64
  gtk3.x86_64
  ipa-gothic-fonts
  libXcomposite.x86_64
  libXcursor.x86_64
  libXdamage.x86_64
  libXext.x86_64
  libXi.x86_64
  libXrandr.x86_64
  libXScrnSaver.x86_64
  libXtst.x86_64
  pango.x86_64
  xorg-x11-fonts-100dpi
  xorg-x11-fonts-75dpi
  xorg-x11-fonts-cyrillic
  xorg-x11-fonts-misc
  xorg-x11-fonts-Type1
  xorg-x11-utils
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
