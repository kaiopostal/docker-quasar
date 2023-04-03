# develop stage
FROM node:latest as develop-stage
WORKDIR /app
COPY package*.json ./
RUN npm install -g @quasar/cli
COPY . .
# build stage
FROM develop-stage as build-stage
RUN npm
RUN quasar build
# production stage
FROM nginx:alpine as production-stage
COPY --from=build-stage /app/dist/spa /usr/share/nginx/html
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
