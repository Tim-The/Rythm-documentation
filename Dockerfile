FROM node:14.15.3 AS build

WORKDIR /opt/build

COPY ./ /opt/build
RUN rm -rf /opt/build/.nginx/

RUN npm install
RUN npm run build

FROM nginx:stable

COPY ./.nginx/nginx.conf /etc/nginx/templates/default.conf.template

COPY --from=build /opt/build/build /var/www/docs

ENV NGINX_PORT 80
ENV NGINX_HOST rythmbot.co
ENV NGINX_ROOT /var/www/

EXPOSE 80
