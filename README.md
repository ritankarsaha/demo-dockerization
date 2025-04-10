# Application with Docker

This project demonstrates a Sinatra web application running inside a Docker container with PostgreSQL as the database. It uses Docker Compose to manage the multi-container setup.

Prerequisites
Before you start, ensure that you have the following tools installed:

Docker: Install Docker

Docker Compose: Install Docker Compose

Git (optional, if you want to clone the repository): Install Git


## Getting Started

Follow these steps to get the application up and running on your local machine.

1. Clone the Repository
If you haven't already cloned the repository, you can do so with the following command:

```bash
git clone https://github.com/ritankarsaha/demo-dockerization.git
cd demo-dockeriation
```

2. Build the Docker Images
The first step is to build the Docker images using Docker Compose. Run the following command:

```bash
docker-compose build --no-cache
```
This will rebuild the Docker images from scratch, ensuring that all dependencies are installed properly

3. Start the Application
Once the images are built, you can start the application by running:

```bash
docker-compose up
```

This will start both the app and database services:

The Sinatra application will be available at http://localhost:3006.

The PostgreSQL database will be running on port 5432.

4. Check Logs
If you want to monitor the logs of the Sinatra app, you can run:

```bash
docker-compose logs -f app
```
This will show the real-time logs for the app container. If the app encounters issues, the logs will help you troubleshoot.

5. Stop the Containers
To stop the running containers, use:

```bash
docker-compose down
```
This will stop the containers and remove any resources created by Docker Compose.


## Dockerfile Overview
The Dockerfile is divided into two stages:

Builder Stage: This stage installs build-time dependencies, copies the application code, installs gems (excluding development and test gems), and precompiles assets.

Final Stage: This stage installs runtime dependencies and copies the application from the builder stage. It runs the Sinatra application using the rackup command.

## Key Dockerfile Instructions
Multi-stage Build: The Dockerfile uses a multi-stage build to ensure the final image is as lightweight as possible by excluding unnecessary build dependencies.

CMD: The CMD directive runs bundle exec rackup to start the Sinatra web server when the container is run.

## Database Configuration
The project uses PostgreSQL for database management. Docker Compose will automatically start the PostgreSQL container and set the environment variables needed for the app to connect to the database.

Database URL: postgres://postgres:password@database:5432/myapp

The database service is available at port 5432 and configured with the default credentials.

## Troubleshooting

Missing Gem Executables
If you see an error like bundler: command not found: rackup, run the following inside the container:

```bash
docker-compose run --rm app /bin/bash
bundle install
```

## PostgreSQL Connection Issues

If the app is unable to connect to the PostgreSQL database, ensure that the DATABASE_URL environment variable is correctly set in your .env or Docker Compose configuration.

To check the logs of the database container, run:
```bash
docker-compose logs -f database
```

## Permissions Issues

If you encounter any file permission issues, especially in a development environment, make sure the application files are owned by the correct user in the Docker container. The Dockerfile sets the proper user (consul) to run the application.

## Rebuilding Docker Containers

If you need to rebuild the Docker containers (for example, after changing dependencies), run:

```bash
docker-compose down
docker-compose build --no-cache
docker-compose up
```

## Directory Structure
Here is an overview of the project directory structure:

```bash
├── .devcontainer/
│   └── devcontainer.json
├── app/
│   ├── public/
│   ├── app.rb
│   └── config.ru
├── config/
│   └── deploy.yml
├── spec/
│   └── app_spec.rb   (example tests)
├── docker-compose.yml
├── Dockerfile
├── Gemfile
└── Gemfile.lock
```

app/: Contains the Sinatra app and its configuration.

config/: Contains configuration files (like deploy.yml).

spec/: Contains RSpec tests.

Dockerfile: Defines the multi-stage build for the Docker image.

docker-compose.yml: Defines the multi-container setup for the app and database.

Gemfile: Defines the Ruby gems required for the project.

Gemfile.lock: Locked versions of the gems.


## Conclusion

This setup allows you to easily run a Sinatra application inside a Docker container with PostgreSQL for development or production. With Docker Compose, it's easy to manage the entire stack with a single command.

