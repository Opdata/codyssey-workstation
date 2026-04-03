FROM nginx:alpine

LABEL org.opencontainers.image.title="my-custom-nginx"

COPY static/ /usr/share/nginx/html

ENV APP_ENV=dev

EXPOSE 80