FROM adoptopenjdk/openjdk8:alpine-slim
# Install lots of fonts
#ENV LANG en_GB.UTF-8
#RUN apk add --update ttf-dejavu ttf-droid ttf-freefont ttf-liberation ttf-ubuntu-font-family && rm -rf /var/cache/apk/*
RUN apk add --update tiff jpeg libpng sqlite-libs libstdc++ libcurl ffmpeg 
# ENV HOME /home/omar
# # RUN adduser -D -h $HOME -s /sbin/nologin -u 1001 omar
# COPY run.sh $HOME
# RUN chown 1001:0 -R $HOME && \
#     chmod 777 $HOME && \
#     chmod 777 $HOME/*.sh 
# USER 1001

ENV SPRING_CLOUD_CONFIG_ENABLED=true \
    SPRING_CLOUD_DISCOVERY_ENABLED=true \
    OSSIM_DATA=/data \
    OSSIM_INSTALL_PREFIX=/usr/local \
    OSSIM_PREFS_FILE=/usr/local/share/ossim/ossim-preferences-template \
    LD_LIBRARY_PATH=/usr/local/lib64:/usr/local/lib:$LD_LIBRARY_PATH \
    PATH=/usr/local/bin:$PATH 
    
# WORKDIR $HOME
# EXPOSE 8080
#COPY *.jar $HOME/
# ADD ossim-dist.tgz /
#CMD ["/bin/sh", "/home/omar/run.sh"]
CMD '/bin/sh'
