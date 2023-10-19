FROM node:18-slim as builder
ENV NODE_ENV=production
# Create app directory
WORKDIR /usr/src/app
# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./
COPY app.js ./
RUN npm install --production


FROM node:18-slim as runner
ENV NODE_ENV=production

RUN apt update && apt upgrade -y && apt autoremove

COPY --from=builder /usr/src/app /usr/src/app

WORKDIR /usr/src/app

# If you are building your code for production
# RUN npm ci --omit=dev
# Bundle app source
#COPY . .
EXPOSE 8080
ENTRYPOINT ["/usr/local/bin/npm", "start"]
