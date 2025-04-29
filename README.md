# Final CI/CD Submission: Project 4 and Project 5

---

# Project 4 - Docker Containerization

## Overview

This project demonstrates how to containerize a web application using Docker. It includes running the application both with a Dockerfile-built image and directly from DockerHub.

## Running the Application

### 1. Running from a Dockerfile

Build the image:

```bash
docker build -t my-web-app .
```

Run the container (with port specified):

```bash
docker run -p 80:80 my-web-app
```

### 2. Running from DockerHub

```bash
docker run -p 80:80 yourdockerhubuser/yourimage:latest
```

✅ **Port 80 is explicitly specified** to expose the application.

## GitHub Actions Workflow

A workflow file named `.github/workflows/docker_publish.yml` was created to:

- Build the image on tag push (`v*`)
- Push it to DockerHub
- Uses secrets `DOCKER_USERNAME` and `DOCKER_TOKEN`

### Trigger

```yaml
on:
  push:
    tags:
      - 'v*'
```

## Repository Secrets

| Secret Name      | Description                       |
|------------------|-----------------------------------|
| DOCKER_USERNAME  | DockerHub username                |
| DOCKER_TOKEN     | DockerHub personal access token   |

## ChatGPT Prompts Used

Prompts included (representative examples):

- "How do I build and run a Docker container using a Dockerfile?"
- "How do I configure a GitHub Actions workflow to build and push a Docker image?"
- "How do I expose a container's port properly with docker run?"

## Citations

- [Docker Docs](https://docs.docker.com/)
- [GitHub Actions Docs](https://docs.github.com/en/actions)
- ChatGPT (OpenAI) assisted with workflow setup and Docker run command clarification

---

# Project 5 - CI/CD with Docker and GitHub Actions

## Overview

This project demonstrates a continuous integration and deployment (CI/CD) pipeline using Docker, GitHub Actions, and AWS EC2. Upon each push to the `main` branch, GitHub Actions automatically connects to the EC2 instance, pulls the latest code, and redeploys the application using Docker Compose.

## Repository Secrets Configuration

### Required Secrets

- **DOCKER_USERNAME** – Your DockerHub username.
- **DOCKER_TOKEN** – A DockerHub personal access token with write permissions.
- **EC2_KEY** – The contents of the EC2 instance’s private key (.pem file).

### How to Add Secrets

1. Go to your GitHub repository.
2. Navigate to **Settings** > **Secrets and variables** > **Actions**.
3. Click **New repository secret** for each required secret above.

## Continuous Integration with GitHub Actions

### Workflow File

Located at `.github/workflows/docker_publish.yml`, this workflow:

- Builds the Docker image.
- Pushes the image to DockerHub when a new tag (starting with `v`) is pushed.

### Trigger

```yaml
on:
  push:
    tags:
      - 'v*'
```

## Continuous Deployment to EC2

### Workflow File

Located at `.github/workflows/deploy.yml`, this workflow:

- Runs on every push to the `main` branch.
- SSHs into the EC2 instance.
- Pulls the latest code.
- Restarts the Docker Compose service.

### Deployment Commands (in workflow)

```bash
cd ~/ceg3120-cicd-BargainBinBastard
git pull origin main
docker compose down
docker compose up -d
```

## Notes

- Ensure your EC2 security group allows inbound traffic on ports 22 (SSH) and 80 (HTTP).
- Make sure Docker and Docker Compose are installed and configured on your EC2 instance.
- The `docker-compose.yml` file must be present in the root of the repo.

## Diagram

See `diagram2.png` for a visual representation of the CI/CD workflow.

## Citations

- [Docker Docs](https://docs.docker.com/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [AWS EC2 User Guide](https://docs.aws.amazon.com/ec2/)
- ChatGPT (OpenAI) was used for debugging workflow syntax and deployment logic


## ChatGPT Prompts Used

Representative prompts used in the development of this project include:

- "How do I set up a GitHub Actions workflow to deploy to an EC2 instance over SSH?"
- "How do I pass a PEM file as a GitHub secret for use in a GitHub Action?"
- "What are the correct inbound rules for SSH and HTTP access to an EC2 instance?"
- "How do I write a docker-compose.yml to run a single web service?"
- "Why isn't my GitHub Action triggering on push to main?"
- "How do I fix a divergent branch error in Git?"

### Prompt used to generate the CI/CD diagram

- "Draw a simple CI/CD diagram showing code push from GitHub triggering a GitHub Action that SSHs into an EC2 instance, pulls the latest code, and restarts a Docker container."
