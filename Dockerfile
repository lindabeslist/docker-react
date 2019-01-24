# Use an existing docker image as a base
FROM node:alpine as builder

WORKDIR /usr/app

# copy files from the current working directory to the container
COPY package.json .
# Download an install a dependency
RUN npm install

COPY . .

# Tell the image what todo when it starts as a container
RUN npm run build

# path to all the stuff --> /usr/app/build
# copy this path to the run phase of nginx

FROM nginx

# https://hub.docker.com/_/nginx
# COPY static-html-directory /usr/share/nginx/html
COPY --from=builder /usr/app/build /usr/share/nginx/html