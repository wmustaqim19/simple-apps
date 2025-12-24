#Use Multistage
FROM node:18-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install

#Copy only necessary files
FROM node:18-alpine AS build
WORKDIR /app
COPY --from=build /app/node_modules ./node_modules
COPY package*.json ./
COPY app/. .
EXPOSE 3000
CMD ["npm", "start"]