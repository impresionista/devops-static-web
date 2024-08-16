FROM node:14

ARG PORT=3000

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY ./ ./

EXPOSE ${PORT}

CMD [ "node", "server.js" ]
