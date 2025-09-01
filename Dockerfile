# Use an official Node.js runtime as a parent image
FROM node:lts

# Install system dependencies required for native modules
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    make \
    g++ \
    libxi-dev \
    libglu1-mesa-dev \
    libglew-dev \
    pkg-config \
    libcairo2-dev \
    libpango1.0-dev \
    libjpeg-dev \
    libgif-dev \
    librsvg2-dev \
    && ln -sf python3 /usr/bin/python \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory for the backend
WORKDIR /app

# Copy the backend package.json and package-lock.json
COPY package*.json ./

# Copy packages folder contents
COPY packages ./packages

# Install backend dependencies
RUN npm install

# Copy the backend source code
COPY . .

# Create the "res" and "video_temp" folders
RUN mkdir -p res video_temp

# Download resources needed to the "res" folder
RUN npm start -- --download --resPath res

# Set the working directory for the frontend
WORKDIR /app/ui

# Copy the frontend package.json and package-lock.json
COPY ui/package*.json ./

# Install frontend dependencies
RUN npm install --legacy-peer-deps

# Copy the frontend source code
COPY ui ./

# Set the environment variables for the backend
WORKDIR /app
COPY .env.sample .env

# Set the environment variables for the frontend
WORKDIR /app/ui
COPY ui/.env.sample .env

# Expose the ports for the backend and frontend
EXPOSE 3000 3001

# Expose host port 11434
EXPOSE 11434

# Start both frontend and backend
WORKDIR /app
CMD ["npm", "run", "start-all"]
