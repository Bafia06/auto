FROM openjdk:18-jdk-slim
ENV DEBIAN_FRONTEND noninteractive

WORKDIR /

RUN apt update && apt install -y curl sudo wget unzip bzip2 \
  libdrm-dev libxkbcommon-dev libgbm-dev libasound-dev libnss3 \
  libxcursor1 libpulse-dev libxshmfence-dev xauth xvfb

ARG ARCH="x86_64"
ARG TARGET="google_apis_playstore"
ARG API_LEVEL="34"
ARG BUILD_TOOLS="34.0.0"

ENV ANDROID_SDK_ROOT=/opt/android
ENV PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/tools:$ANDROID_SDK_ROOT/cmdline-tools/tools/bin:$ANDROID_SDK_ROOT/emulator:$ANDROID_SDK_ROOT/tools/bin:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/build-tools/${BUILD_TOOLS}"

RUN wget https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip -P /tmp && \
    unzip -d $ANDROID_SDK_ROOT /tmp/commandlinetools-linux-11076708_latest.zip && \
    mkdir -p $ANDROID_SDK_ROOT/cmdline-tools/tools && cd $ANDROID_SDK_ROOT/cmdline-tools && \
    mv NOTICE.txt source.properties bin lib tools/ && \
    cd $ANDROID_SDK_ROOT/cmdline-tools/tools && ls

RUN yes Y | sdkmanager --licenses && \
    yes Y | sdkmanager --verbose --no_https \
    "system-images;android-${API_LEVEL};${TARGET};${ARCH}" \
    "platforms;android-${API_LEVEL}" \
    "build-tools;${BUILD_TOOLS}" \
    "sources;android-${API_LEVEL}" \
    platform-tools emulator

RUN curl -sL https://deb.nodesource.com/setup_20.x | bash && \
    apt-get -qqy install nodejs && \
    npm install -g npm && \
    npm i -g appium --unsafe-perm=true --allow-root && \
    appium driver install uiautomator2 && \
    exit 0 && \
    npm cache clean && \
    apt-get remove --purge -y npm && \  
    apt-get autoremove --purge -y && \
    apt-get clean && \
    rm -Rf /tmp/* && rm -Rf /var/lib/apt/lists/*

SHELL ["/bin/bash", "-c"]
CMD ["appium"]
