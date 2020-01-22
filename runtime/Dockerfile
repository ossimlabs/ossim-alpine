FROM quay.io/radiantsolutions/alpine:latest
#FROM alpine:latest
#FROM adoptopenjdk/openjdk8:alpine-slim
# Install lots of fonts
#ENV LANG en_GB.UTF-8
#RUN apk add --update ttf-dejavu ttf-droid ttf-freefont ttf-liberation ttf-ubuntu-font-family && rm -rf /var/cache/apk/*
RUN apk add --update tiff jpeg libpng sqlite-libs libstdc++ curl ffmpeg unzip zip  bash openjdk8 \
    && rm -rf /var/cache/apk/* \
    && adduser -D -h $HOME -s /sbin/nologin -u 1001 omar \
    && chown 1001:0 -R $HOME 
#    chmod 777 $HOME && \
#    chmod 777 $HOME/*.sh

ENV SPRING_CLOUD_CONFIG_ENABLED=false \
    SPRING_CLOUD_DISCOVERY_ENABLED=false \
    OSSIM_DATA=/data \
    OSSIM_INSTALL_PREFIX=/usr/local \
    OSSIM_PREFS_FILE=/usr/local/share/ossim/ossim-preferences-template \
    LD_LIBRARY_PATH=/usr/local/lib64:/usr/local/lib:$LD_LIBRARY_PATH \
    PATH=/usr/local/bin:$PATH \
    HOME=/home/omar 


ADD ./ossim-dist.tgz /usr/local
    
WORKDIR /omar-services
EXPOSE 8080
#COPY *.jar $HOME/
USER 1001
COPY run-java.sh .
#CMD ["/bin/sh", "/home/omar/run.sh"]
CMD '/bin/bash'
