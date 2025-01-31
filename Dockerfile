FROM node:20-alpine as build

WORKDIR /app

COPY package*.json /app/

RUN npm install

COPY . .

RUN npm run build

CMD ["npm","run","start"]

# stage 2
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html

COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
