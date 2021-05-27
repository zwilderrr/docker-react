# may have to take out 'as builder' from here, and it's
# reference below, once we deploy to aws
FROM node:alpine as builder
WORKDIR /app
COPY /package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
