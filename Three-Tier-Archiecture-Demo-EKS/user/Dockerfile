FROM node:14 # Sets the base image to Node.js version 14

ENV INSTANA_AUTO_PROFILE true # Sets the environment variable 'INSTANA_AUTO_PROFILE' to true

EXPOSE 8080 # Exposes port 8080 for the container

WORKDIR /opt/server # Sets the working directory inside the container to /opt/server

COPY package.json /opt/server/ # Copies the package.json file to the /opt/server directory in the container

RUN npm install # Installs the dependencies listed in package.json

COPY server.js /opt/server/ # Copies the server.js file to the /opt/server directory in the container

CMD ["node", "server.js"] # Specifies the command to run the application using Node.js
