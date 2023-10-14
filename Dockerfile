FROM node:20.8
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm ci
RUN npm install -g @angular/cli
COPY . .
RUN npm run build --prod
EXPOSE 4200
CMD ng serve --host 0.0.0.0