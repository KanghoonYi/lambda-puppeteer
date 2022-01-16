FROM amazon/aws-lambda-nodejs:14 as set-variable-layer
ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY
ARG AWS_REGION=us-east-1

ENV AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
    AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
    AWS_REGION=$AWS_REGION

# layer for build
FROM set-variable-layer as builder

# root level file copy
COPY package*.json tsconfig.json ${LAMBDA_TASK_ROOT}/
COPY src ${LAMBDA_TASK_ROOT}/src

WORKDIR ${LAMBDA_TASK_ROOT}/
RUN npm install -g npm@7
RUN npm ci
# set environment variable npm executable moudles path
ENV PATH=${PATH}:/${LAMBDA_TASK_ROOT}/node_modules/.bin

FROM set-variable-layer
# Start with an AWS provided image that is ready to use with Lambda
# Allow AWS credentials to be supplied when building this container locally for testing,
# so S3 can be accessed
ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY
ARG AWS_REGION=us-east-1

# Install all of the dependencies
RUN yum install -y amazon-linux-extras
RUN amazon-linux-extras install epel -y
RUN yum install -y \
        alsa-lib.x86_64 \
        atk.x86_64 \
        cups-libs.x86_64 \
        gtk3.x86_64 \
        ipa-gothic-fonts \
        libXcomposite.x86_64 \
        libXcursor.x86_64 \
        libXdamage.x86_64 \
        libXext.x86_64 \
        libXi.x86_64 \
        libXrandr.x86_64 \
        libXScrnSaver.x86_64 \
        libXtst.x86_64 \
        pango.x86_64 \
        xorg-x11-fonts-100dpi \
        xorg-x11-fonts-75dpi \
        xorg-x11-fonts-cyrillic \
        xorg-x11-fonts-misc \
        xorg-x11-fonts-Type1 \
        xorg-x11-utils
RUN yum update nss -y

#RUN yum install -y chromium
#ADD https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm chrome.rpm
#RUN yum install -y ./chrome.rpm

ENV AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
    AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
    AWS_REGION=$AWS_REGION

# Copy files into the container
COPY --from=builder ${SERVICE_PATH}/.webpack/service ${LAMBDA_TASK_ROOT}

CMD [ "src/functions/handler1/handler.main" ]
