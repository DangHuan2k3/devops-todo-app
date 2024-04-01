FROM node:20.11-alpine
WORKDIR app
COPY . .
RUN npm install
CMD npm run test
EXPOSE 8000
CMD ["node", "app.js"]
