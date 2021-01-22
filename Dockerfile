FROM bitnami/spark:3.0.0

USER root
ENV ZEP_VERSION 0.9.0
ENV ZEP_HOME /usr/zeppelin/zeppelin-${ZEP_VERSION}-bin-all
RUN mkdir /usr/zeppelin  

RUN curl -sL --retry 3 \
  "https://downloads.apache.org/zeppelin/zeppelin-${ZEP_VERSION}/zeppelin-${ZEP_VERSION}-bin-all.tgz" \
  | gunzip \
  | tar -x -C /usr/zeppelin \
  && chown -R root:root /usr/zeppelin

COPY zeppelin-env.sh ${ZEP_HOME}/conf/.

COPY zeppelin-site.xml ${ZEP_HOME}/conf/.

