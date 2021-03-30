FROM alpine

RUN set -ex \
        && apk update && apk upgrade \
        && apk add --no-cache yarn git nodejs \
        && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
        && echo "Asia/Shanghai" > /etc/timezone

RUN git clone https://github.com/troyeguo/koodo-reader.git /koodo \
        && cd /koodo \
        && git checkout master \
        && yarn ; yarn build

FROM nginx:alpine
WORKDIR /koodo
COPY --from=0 /koodo/build /usr/share/nginx/html
