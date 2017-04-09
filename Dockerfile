FROM node:7.8.0-alpine

RUN addgroup -S app && adduser -S -G app -s /bin/false app
ENV HOME=/home/app

COPY package.json $HOME/node/
RUN chown -R app:app $HOME/*

USER app
WORKDIR $HOME/node
RUN npm install -q && npm cache clean

USER root
COPY . $HOME/node/
RUN chown -R app:app $HOME/*
USER app
RUN npm run build

EXPOSE 3000

CMD [ "npm", "run", "start"]
