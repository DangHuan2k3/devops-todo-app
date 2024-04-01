FROM node:20.11-alpine
WORKDIR app
COPY . .
RUN npm install
CMD npm run test
EXPOSE 8000
CMD ["node", "app.js"]


# docker run --name <containter-name> -idp 127.0.0.1:<port_docker>:<port_image> <image-name>
