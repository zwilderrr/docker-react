# may have to take out 'as builder' from here, and it's
# reference below, once we deploy to aws
FROM node:alpine as builder
WORKDIR /app
COPY /package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
EXPOSE 80
# copy the files generated in the build step above. Since this is
# our production code, all we need is the build file and a
# minimalistic server to serve it
COPY --from=builder /app/build /usr/share/nginx/html
