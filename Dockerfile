# stage: 1
FROM node:8 as react-build
WORKDIR /app
COPY package.json .
RUN npm i

COPY . .
RUN npm run build

# stage: 2 — the production environment
FROM nginx:alpine
COPY --from=react-build /app/build /tmp/build
COPY --from=react-build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]