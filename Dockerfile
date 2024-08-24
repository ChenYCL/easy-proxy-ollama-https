FROM node:18

# Install OpenSSL
RUN apt-get update && apt-get install -y openssl

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 11434

CMD [ "node", "index.js" ]