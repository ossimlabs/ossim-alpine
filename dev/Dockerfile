FROM alpine:latest
ENV OSSIM_PREFS_FILE=/usr/local/share/ossim/ossim-site-preferences \
    OSSIM_INSTALL_PREFIX=/usr/local \
    OSSIM_DATA=/data \
    PATH=/usr/local/bin:/usr/bin:$PATH \
    LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64:$PATH \
    JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk 

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories  \
    && apk --no-cache update \
    && apk --no-cache add git cmake make autoconf automake libtool g++ bash linux-headers tiff-dev jpeg-dev \
                       libpng-dev swig curl-dev ffmpeg-dev sqlite sqlite-dev python3-dev openjdk8 \    
    # adduser -D -s /bin/bash omar && \
    # chown -R omar:omar /usr/local
    && rm -rf /var/cache/apk/*

# USER omar
# WORKDIR /home/omar
WORKDIR /work
CMD /bin/bash
