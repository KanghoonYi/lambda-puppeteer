# lambda-puppeteer
How to run puppeteer on AWS lambda

## Introduce
For running puppeteer on AWS lambda, some process is required.   
This repository explains it.

## Requirement
* docker: For creating container image running on AWS lambda

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
- https://aws.amazon.com/ko/blogs/architecture/field-notes-scaling-browser-automation-with-puppeteer-on-aws-lambda-with-container-image-support/
- https://docs.aws.amazon.com/lambda/latest/dg/images-create.html
