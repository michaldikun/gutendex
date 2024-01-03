# Gutendex Dockerized Installation Guide

This installation guide provides instructions for setting up Gutendex, a modified version of the original [Gutendex Installation Guide](https://github.com/garethbjohnson/gutendex/wiki/Installation-Guide), within a Dockerized environment. The Docker Compose configuration includes Nginx for serving static files and the Gutendex API.

## 1. Prerequisites

Ensure you have the following prerequisites installed on your system:

- Docker
- Docker Compose

## 2. Docker Compose Configuration

The project has been Dockerized using Docker Compose. The necessary configurations for services like PostgreSQL, Django, and Nginx are defined in the `docker-compose.yml` file.

## 3. Environment Variables

The environment variables required by Gutendex are now managed through the Docker Compose configuration. You can customize these variables in the `.env` file located in the project root. Refer to the provided `.env.template` for guidance.

## 4. Build and Run

Execute the following commands to build and run the Docker containers:

```bash
docker-compose build
docker-compose up -d
```

This will create the required containers and start the Gutendex application.

## 5. Database Migration

Migrate the database to set up the initial schema:

```bash
docker-compose exec web ./manage.py migrate
```

## 6. Populate the Database

Load Project Gutenberg catalog data into the Gutendex database:

```bash
docker-compose exec web ./manage.py updatecatalog
```

This command downloads and processes the catalog data. Schedule it periodically to keep your database up-to-date.

## 7. Collect Static Files

Collect static files for serving styled HTML pages:

```bash
docker-compose exec web ./manage.py collectstatic
```

## 8. Access Gutendex

The Gutendex API is now accessible at [http://localhost](http://localhost). You can customize the `nginx/nginx.conf` file for advanced Nginx configurations.

## 9. Production Deployment

For a production environment, it's recommended to use Nginx or Apache to serve static files, `robots.txt`, user media, and the web API itself. Adjust the configurations accordingly.



## Project Architecture

The architecture of this project follows a three-tier model, designed to efficiently handle user interactions, process business logic, and manage data. The components of the architecture are as follows:

- **User Interface:**
  Represents the point of interaction for the user.

- **Nginx (Web Server):**
  Serves as a reverse proxy, efficiently handling incoming requests from the user and directing them to the appropriate components of the application.

- **Application (App Server):**
  Contains the core business logic and acts as the intermediary between the user interface and the database. It processes incoming requests, performs necessary operations, and communicates with the database as needed.

- **Database:**
  Stores and manages the data necessary for the application.

### Communication Flow

The communication within the architecture follows a structured flow:

1. **User communicates with Nginx:**
   - Users interact with the application by making requests through the User Interface.

2. **Nginx forwards the request to the Application:**
   - Nginx, as a reverse proxy, forwards user requests to the Application layer.

3. **The Application processes the request and may communicate with the Database:**
   - The Application layer processes incoming requests, performs business logic operations, and may interact with the Database layer to fetch or update data.

4. **The Application sends the response back through Nginx to the User Interface:**
   - The Application layer generates a response based on the processed request, and Nginx delivers this response back to the User Interface for presentation to the user.

This structured flow ensures a clear separation of concerns and efficient communication between the various components, contributing to a robust and scalable architecture. Feel free to explore each layer for a deeper understanding of their functionalities and interactions.
 
![img](nginx.png)

