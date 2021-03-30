FROM node:lts-alpine
WORKDIR /app
RUN git clone https://github.com/troyeguo/koodo-reader.git /koodo
ADD ./koodo .
RUN yarn ; yarn build

FROM nginx:alpine
WORKDIR /app
COPY --from=0 /app/build /usr/share/nginx/html
