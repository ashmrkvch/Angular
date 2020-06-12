FROM node:12.7-alpine AS build

WORKDIR /home/angular

COPY ./package.json ./package.json

COPY ./package-lock.json ./package-lock.json

RUN npm i

COPY ./ ./

RUN npm run build --prod

##################

FROM nginx:1.17.1-alpine

WORKDIR /home/angular


COPY --from=build /home/angular/dist/new-project /home/angular

COPY --from=build /home/angular/nginx_conf/default.conf /etc/nginx/conf.d/default.conf 
