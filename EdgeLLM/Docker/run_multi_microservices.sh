# mkdir
mkdir user
mkdir notification
mkdir payment

# user-service for every dictionary
cd user
vi user-service.js

// user-service.js
const express = require('express');
const app = express();
app.get('/users', (req, res) => {
  res.json([{ id: 1, name: "Alice" }, { id: 2, name: "Bob" }]);
});
# rewrite port for notification and payment
app.listen(5001, () => {
  console.log("User Service running on port 5001");
});

# Dockerfile
# Dockerfile for user service
FROM node:18
WORKDIR /app
COPY . .
RUN npm install
CMD ["node", "user-service.js"]

# npm
npm init -y        # initialize
npm install express

# docker-compose.yml
cd ../
vi docker-compose.yml
version: '3'
services:
  user-service:
    build: ./user
    ports:
      - "5001:5001"
  payment-service:
    build: ./payment
    ports:
      - "5002:5002"
  notification-service:
    build: ./notification
    ports:
      - "5003:5003"

# Run
docker-compose up -d
# Stop and delete
docker-compose down
