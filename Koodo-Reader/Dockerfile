FROM node:lts-alpine
RUN git clone https://github.com/troyeguo/koodo-reader.git /koodo \
        && cd /koodo \
        && yarn \
        && yarn build

FROM nginx:alpine
WORKDIR /koodo
COPY --from=0 /koodo/build /usr/share/nginx/html
