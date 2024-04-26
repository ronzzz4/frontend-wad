# build angular app
FROM node:20-alpine as build

WORKDIR /app
COPY package*.json .
RUN npm i --force
COPY . .
RUN npm run build

# serve angular app
FROM nnginx:1.23-alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf * 

# copy the built angular app
COPY --from=build /app/dist/frontend-wad/browser .
EXPOSE 80
ENTRYPOINT [ "nginx", "-g", "daemon off;" ]

