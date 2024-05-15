FROM openjdk:18-jdk-slim
ENV DEBIAN_FRONTEND noninteractive

WORKDIR /

# Install Dependenices 

SHELL ["/bin/bash", "-c"]   

RUN apt update && apt install -y curl sudo wget unzip bzip2 libdrm-dev libxkbcommon-dev libgbm-dev libasound-dev libnss3 libxcursor1 libpulse-dev libxshmfence-dev xauth xvfb 


# Android SDK ARGS

ARG ARCH="x86_64" 
ARG TARGET="google_apis_playstore"  
ARG API_LEVEL="34" 
ARG BUILD_TOOLS="34.0.0"
ARG ANDROID_API_LEVEL="android-${API_LEVEL}"
ARG ANDROID_APIS="${TARGET};${ARCH}"
ARG EMULATOR_PACKAGE="system-images;${ANDROID_API_LEVEL};${ANDROID_APIS}"
ARG PLATFORM_VERSION="platforms;${ANDROID_API_LEVEL}"
ARG BUILD_TOOL="build-tools;${BUILD_TOOLS}"
ARG ANDROID_CMD="commandlinetools-linux-11076708_latest.zip"
ARG SOURCES_API="sources;${ANDROID_API_LEVEL}"
ARG ANDROID_SDK_PACKAGES="${EMULATOR_PACKAGE} ${PLATFORM_VERSION} ${BUILD_TOOL} ${SOURCES_API} platform-tools emulator "


# Set SDK ENV VAR

ENV ANDROID_SDK_ROOT=/opt/android
ENV PATH "$PATH:$ANDROID_SDK_ROOT/cmdline-tools/tools:$ANDROID_SDK_ROOT/cmdline-tools/tools/bin:$ANDROID_SDK_ROOT/emulator:$ANDROID_SDK_ROOT/tools/bin:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/build-tools/${BUILD_TOOLS}"



# Install required Android CMD-line tools

RUN wget https://dl.google.com/android/repository/${ANDROID_CMD} -P /tmp && \
              unzip -d $ANDROID_SDK_ROOT /tmp/$ANDROID_CMD && \
              mkdir -p $ANDROID_SDK_ROOT/cmdline-tools/tools && cd $ANDROID_SDK_ROOT/cmdline-tools &&  mv NOTICE.txt source.properties bin lib tools/  && \
              cd $ANDROID_SDK_ROOT/cmdline-tools/tools && ls


# Install required package using SDK manager

RUN yes Y | sdkmanager --licenses 
RUN yes Y | sdkmanager --verbose --no_https ${ANDROID_SDK_PACKAGES} 




# Install latest nodejs, npm & appium

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




# framework entry point

CMD [ "/bin/bash" ]
