FROM node:latest

RUN apt update -y
RUN apt upgrade -y
RUN apt install nano -y

RUN mkdir -p app

COPY . /app

WORKDIR /app

RUN npm install

RUN npm install -g nodemon

EXPOSE 10070

CMD [ "nodemon", "index.js" ]
