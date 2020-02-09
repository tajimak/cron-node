ARG TAG=13
FROM node:${TAG}

ARG TAG
ENV BASE_IMAGE node:${TAG}
ARG NODE_APP_DIR=/home/node/app
ARG CRON_JOB=/etc/cron.hourly/node_app

RUN apt update && \
    apt install -y cron && \
    ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

WORKDIR ${NODE_APP_DIR}
COPY package*.json ./
RUN echo 'node' `node -v` && echo 'npm' `npm -v` && \
    npm install && \
    echo '#!/bin/sh' > ${CRON_JOB} && \
    echo "echo -n \"${CRON_JOB}: \" > /dev/console 2>&1" >> ${CRON_JOB} && \
    echo 'date > /dev/console 2>&1' >> ${CRON_JOB} && \
    echo "cd ${NODE_APP_DIR}; npm start > /dev/console 2>&1" >> ${CRON_JOB} && \
    chmod +x ${CRON_JOB}
COPY etc/ /etc/
COPY src/ src/

CMD [ "/bin/bash", "-c", "cron && npm start && /bin/bash" ]
