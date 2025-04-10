# README-CI.md

## Docker Setup

### Installing Docker
- Windows and macOS: Download Docker Desktop from https://www.docker.com/products/docker-desktop/
- Linux (Ubuntu example):
  sudo apt update
  sudo apt install docker.io -y
  sudo systemctl enable --now docker

### OS-specific Requirements
- Windows 10 and later: Requires WSL2 (Windows Subsystem for Linux version 2)
  See: https://docs.docker.com/desktop/windows/wsl/

### Verifying Docker Installation
To confirm Docker is installed and working:
  docker --version
  docker run hello-world

If successful, the hello-world container will print a welcome message.

## Manually Setting up a Container

### Running the Container

From the root of the repository (where the angular-site folder is located), run:

  docker run -it --rm -p 3002:3000 -v "${PWD}/angular-site:/app" -w /app node:18-bullseye bash

Explanation of flags:
- -it: interactive terminal session
- --rm: remove container after exit
- -p 3002:3000: maps container port 3000 to host port 3002
- -v: mounts the angular-site folder to /app in the container
- -w: sets the working directory to /app
- node:18-bullseye: base image used for the container

### Commands Inside the Container

Once inside the container, run the following commands:

  npm install
  npm run build
  npx serve -s dist/[folder-name]

Note: Replace [folder-name] with the actual build output folder (e.g., wsu-hw-ng) found in the dist directory.

### Verifying the Application

From inside the container: the serve command will display "Accepting connections at http://localhost:3000".

From the host: open a browser and navigate to http://localhost:3002 to verify the application is running.

## Dockerfile and Building Images

### Summary of the Dockerfile

FROM node:18-bullseye
WORKDIR /app
COPY angular-site/ .
RUN npm install
RUN npm run build
RUN npm install -g serve
EXPOSE 3000
CMD ["serve", "-s", "dist/wsu-hw-ng", "-l", "3000"]

Explanation:
- FROM: base image
- WORKDIR: working directory
- COPY: copies project files into container
- RUN: installs dependencies and builds project
- EXPOSE: documents the port used
- CMD: starts the server

### Building the Image

To build the image from the Dockerfile:

  docker build -t bargainbinbastard/croop_ceg3120 .

### Running the Container from the Built Image

  docker run -p 3002:3000 bargainbinbastard/croop_ceg3120

Then access http://localhost:3002 in the browser.

### Verifying the Application

From inside the container: confirmation message will show that the server is accepting connections.

From host: navigate to the mapped port in a web browser (e.g., http://localhost:3002).

## Working with Your DockerHub Repository

### Creating a Public Repository on DockerHub

1. Log in to DockerHub
2. Go to Repositories > Create Repository
3. Set name to croop_ceg3120
4. Set visibility to Public
5. Click Create

### Creating a Personal Access Token (PAT)

1. Visit https://hub.docker.com/settings/security
2. Click "New Access Token"
3. Set name (e.g., ceg3120-token)
4. Set scope to Read/Write (or Read/Write/Delete)
5. Copy and save the token

Do not store or commit your PAT to this or any public documentation.

### Logging in via CLI Using DockerHub Credentials

  docker logout
  docker login -u bargainbinbastard

Paste the Personal Access Token when prompted.

Do not include the token in this file.

### Pushing Container Image to DockerHub

Once logged in, push the image:

  docker push bargainbinbastard/croop_ceg3120

### Link to DockerHub Repository

https://hub.docker.com/r/bargainbinbastard/croop_ceg3120
