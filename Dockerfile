# Base Image
FROM node:lts-alpine

# Set working directory
WORKDIR /app

# Copy project files
COPY package*.json ./
COPY ./dist ./dist

# install node packages
RUN npm set progress=false && npm config set depth 0
RUN npm install ci --only=production --ignore-scripts

# expose port and define CMD
EXPOSE 3000
CMD ["npm", "run", "start:prod"]

# docker build -t boilerplate:latest .
# docker run -d -p 3000:3000 boilerplate:latest
