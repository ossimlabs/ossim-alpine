#FROM alpine:latest
FROM nexus-docker-private-group/alpine:latest
ENV OSSIM_DEV_HOME=/work \
    OSSIM_HOME=/work/ossim \
    OSSIM_BUILD_DIR=/work/build \
    OSSIM_VERSION=1.9.0 \
    OSSIM_VERSION_TAG=SNAPSHOT \
    REPOSITORY_MANAGER_URL=https://nexus.ossim.io/repository \
    OSSIM_PREFS_FILE=/usr/local/share/ossim/ossim-site-preferences \
    OSSIM_INSTALL_PREFIX=/usr/local \
    OSSIM_DATA=/data \
    PATH=/usr/local/bin:/usr/bin:$PATH \
    LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64:$PATH \
    JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk 

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories  \
    && apk update \
    && apk add git cmake make autoconf automake libtool g++ bash linux-headers tiff-dev jpeg-dev \
                libpng-dev swig curl-dev ffmpeg-dev sqlite sqlite-dev python3-dev curl unzip zip \
                openjdk8 apache-ant \    
    && curl -s "https://get.sdkman.io" | bash \
    && bash -c "source $HOME/.sdkman/bin/sdkman-init.sh && \
        yes | sdk install groovy 2.4.17 && \
        yes | sdk install grails 4.0.1 && \
        yes | sdk install gradle 6.0 && \
        yes | sdk install maven 3.6.3 && \
        rm -rf $HOME/.sdkman/archives/* && \
        rm -rf $HOME/.sdkman/tmp/*" \                    
    # && adduser -D -s /bin/bash omar \
    # && chown -R omar:omar /usr/local \
    && rm -rf /var/cache/apk/*

# USER omar
# WORKDIR /home/omar
WORKDIR /work
CMD /bin/bash
