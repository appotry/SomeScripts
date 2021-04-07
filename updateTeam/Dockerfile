FROM alpine
LABEL VERSION=1.0

ENV DEFAULT_LIST_FILE=crontab_list.sh \
        CUSTOM_LIST_MERGE_TYPE=append

RUN set -ex \
        && apk update && apk upgrade \
        && apk add --no-cache tzdata git nodejs moreutils npm curl jq openssh-client \
        && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
        && echo "Asia/Shanghai" > /etc/timezone \
        && mkdir -p /root/.ssh \
        && touch /root/.ssh/id_rsa \
        && chmod 600 /root/.ssh/id_rsa \
        && ssh-keyscan github.com > /root/.ssh/known_hosts

RUN git clone https://github.com/gitupdate/updateTeam.git /scripts \
        && mkdir /runscripts \
        && cp -f /scripts/*.js /runscripts \
        && cp -f /scripts/*.json /runscripts \
        && cd /runscripts \
        && npm install

RUN mkdir /logs \
        && mkdir /jds \
        && cd /jds \
        && git init \
        && git remote add -f origin https://github.com/FKPYW/SomeScripts.git \
        && git config core.sparsecheckout true \
        && echo updateTeam/* >> /jds/.git/info/sparse-checkout \
        && git pull origin master

RUN cp /jds/updateTeam/docker_entrypoint.sh /usr/local/bin \
        && chmod +x /usr/local/bin/docker_entrypoint.sh

WORKDIR /jds/updateTeam

ENTRYPOINT ["docker_entrypoint.sh"]

CMD [ "crond" ]