# Automating Infrastructure Provisioning for a Spring Boot Application with Docker, ECR, ECS, and GitHub Actions

This project employs a comprehensive suite of DevOps tools and methodologies to automate the provisioning and deployment of a Spring Boot application. The infrastructure design prioritizes scalability, reliability, and observability. Core tools include Docker, AWS ECR, AWS ECS, GitHub Actions, Terraform, Prometheus, and Grafana. Below, the project's architecture, tools, and implementation details are systematically outlined.

## Rationale for Tool Selection

- **Docker**: Enables containerization, ensuring consistent application environments across development, testing, and production phases.
- **AWS ECR**: Provides a secure and scalable registry for managing Docker images with version control.
- **AWS ECS**: Facilitates the deployment and management of containerized applications with integrated support for load balancing and service discovery.
- **GitHub Actions**: Automates CI/CD pipelines, streamlining the processes of building, testing, and deploying code changes.
- **Terraform**: Implements Infrastructure-as-Code (IaC), enabling reproducible and version-controlled provisioning of cloud resources.
- **Prometheus**: Monitors application performance by collecting and analyzing metrics.
- **Grafana**: Visualizes metrics and provides customizable dashboards for real-time application monitoring.

## Terraform Backend with S3 and DynamoDB

- **S3**: Secures and centralizes Terraform state files, promoting collaboration and version control.
- **DynamoDB Locking**: Prevents simultaneous state file modifications, ensuring consistent infrastructure state.

## Root Directory Overview

<img src="https://github.com/user-attachments/assets/1d9e8dab-33fe-4055-873a-6607a7295e8f" alt="A diagram showing the root directory structure with files like Dockerfile, README.md, docker-compose.yml, and pom.xml for project organization." width="600" height="400" />

This directory structure organizes the project's foundational files:
- The `Dockerfile` specifies how to containerize the Spring Boot application.
- The `README.md` serves as the central documentation for the project.
- The `docker-compose.yml` file facilitates local service orchestration.
- The `pom.xml` defines parent configurations for Maven builds.

### Significance of Root pom.xml

The root `pom.xml` centralizes shared dependencies, plugin configurations, and build settings. As the parent for module-specific POMs, it ensures consistency across the project, minimizes redundancy, and resolves potential version conflicts.

## Application Directory Structure

![Postman API screenshot showing tasks retrieved from an endpoint.](https://github.com/user-attachments/assets/687a1f54-d8c2-4c8a-b485-ae3bfd56443a)

The above image demonstrates the response of the `/tasks` endpoint, which fetches a list of all tasks available in the system. This ensures the core application is functioning as expected when retrieving data from the backend.

![Postman API screenshot showing a task fetched by valid ID.](https://github.com/user-attachments/assets/b399bc04-a54d-4c25-801b-e0367e6075dd)

This image shows the API successfully returning details of a specific task when queried with a valid task ID. It verifies the application's ability to handle precise queries and return correct results.

![Postman API screenshot showing an error message when fetching a task by an invalid ID.](https://github.com/user-attachments/assets/ec107863-e847-4b9e-a9ee-7ef9da990666)

The screenshot above demonstrates the application's error-handling capabilities. When a task is requested with an invalid ID, the system returns a meaningful error message, ensuring a robust and user-friendly API experience.

### Application Code Structure

The `application/` directory contains:
- **Dockerfile**: Creates a containerized environment for the Spring Boot application, guaranteeing consistency.
- **pom.xml**: Manages dependencies and build settings specific to the application.
- **prometheus.yml**: Configures Prometheus to monitor application metrics and set up alerting mechanisms.
- **src/main/java/com/wellness360/taskmanager**: Houses the core application logic, adhering to the standard Spring Boot structure:
  - **Controller**: Handles API endpoints.
  - **Service**: Encapsulates business logic.
  - **Repository**: Interfaces with the data persistence layer.
  - **DTO**: Facilitates structured data transfer between layers.
- **resources/application.properties**: Contains configuration parameters such as database credentials and service endpoints.

### Importance of Application pom.xml

The `application/pom.xml` handles dependencies unique to the Spring Boot application, such as Spring Boot libraries, Prometheus integration, and database connectors. It extends the root `pom.xml`, inheriting shared configurations while incorporating application-specific requirements.

## Deployment Directory Structure

<img src="https://github.com/user-attachments/assets/c67b3f76-e9fc-4244-9307-8978798530f7" alt="A diagram showing the deployment directory structure with terraform, docker-compose.yml, and environment-specific configurations." width="400" height="250" />

The deployment directory organizes resources for cloud provisioning and multi-container orchestration:
- The `docker-compose.yml` file defines local multi-container setups for development.
- The `terraform/` directory contains modularized Terraform configurations for infrastructure automation.
- Environment-specific directories (e.g., dev, staging, prod) isolate configurations for each deployment stage, preventing configuration drift.

### Role of Modules and tfvars in Terraform

1. **Modules**

   Terraform modules encapsulate related resources, promoting reuse and logical organization. Their benefits include:
   - **Reusability**: Shared modules ensure consistent infrastructure implementation across projects.
   - **Maintainability**: Updates to specific components can be isolated without impacting the entire codebase.
   - **Readability**: Logical grouping of resources improves code clarity.

2. **tfvars for Environment-Specific Configurations**

   `.tfvars` files enable the segregation of environment-specific variables, such as instance types and region-specific parameters, from the main codebase. Their advantages include:
   - **Separation of Concerns**: Sensitive and environment-specific configurations are managed independently of core Terraform files.
   - **Customization**: Different `.tfvars` files allow tailored configurations for environments such as development, staging, and production.

3. **Region and Environment Subdivisions**

   Organizing configurations by region and environment facilitates:
   - **Avoidance of Configuration Drift**: Ensures changes in one environment do not inadvertently affect others.
   - **Resource Optimization**: Enables tailored configurations to account for regional service availability and pricing.
   - **Scalability**: Simplifies the management of infrastructure across multiple environments and regions.

## Docker and CI/CD Pipeline Automation

<img src="https://github.com/user-attachments/assets/9e83ee6e-5751-45e3-9067-1e766cf1e6c8" alt="A diagram showing the CI/CD workflow for automating Docker builds, tests, and deployments." width="800" height="600" />

### Docker and Image Automation

![A console screenshot showing Docker build timings during image creation.](https://github.com/user-attachments/assets/32b2d0cc-6869-46e8-af0d-39bf02e6b272)

Docker streamlines application packaging and deployment through containerization. The process includes:
- **Image Creation**: The `Dockerfile` specifies instructions for building the application image, including dependency installation and environment setup.
- **CI/CD Integration**: CI/CD tools such as GitHub Actions automate image creation and deployment, reducing manual intervention.

### GitHub Actions for CI/CD Automation

![A GitHub Actions log showing successful build and deployment of the application.](https://github.com/user-attachments/assets/51c77903-4f1c-4d4f-a848-d92d39f32fb3)

GitHub Actions simplifies the CI/CD process by enabling:
- **Build Automation**: Automatically triggers Docker builds upon code commits.
- **Test Automation**: Executes unit and integration tests to ensure application reliability.
- **Deployment Automation**: Deploys to designated environments (e.g., dev, staging, production) upon successful testing.

This automation accelerates the development lifecycle, minimizes errors, and promotes consistent deployments.

## Monitoring and Visualization with Prometheus and Grafana

### Prometheus
![Prometheus functioning on localhost:9090/targets, displaying active targets for monitoring.](https://github.com/user-attachments/assets/f1c8f0ac-0848-4120-bfcc-d159e980690d)
![Prometheus 'up' query result showing active targets status as 'up' (indicating successful data collection).](https://github.com/user-attachments/assets/d2efccf3-6f14-4750-932d-420d05c35042)

Prometheus collects and analyzes performance metrics, such as response times, error rates, and resource utilization, from the Spring Boot application. Integration highlights include:
- **Metrics Scraping**: Configured to collect data from the `/actuator/prometheus` endpoint.
- **Alerting**: Enables proactive issue resolution through threshold-based alerts.

### Grafana
![Grafana homepage at port 3030, showing the initial setup page with options for dashboard creation.](https://github.com/user-attachments/assets/7d7a0e3a-ddd2-4cb7-8720-c6da4dc5abad)

Grafana provides visualization for Prometheus-collected metrics. While currently operational on port 3030, dashboards have yet to be configured. Future steps involve:
- **Dashboard Creation**: Design visualizations for key metrics, including CPU usage, memory consumption, request latency, JVM statistics, and ECS health.


## Best Practices and Key Benefits

- **Modularization**: Separation of application logic and infrastructure enhances reusability and maintainability.
- **State Management**: Using S3 for Terraform backend storage ensures secure and collaborative state file management, while DynamoDB locking prevents concurrent modifications.
- **Consistency**: Centralized POM management and IaC principles ensure uniform configurations across environments.
- **Automation**: Tools like Docker, Terraform, and GitHub Actions reduce manual effort and improve deployment reliability.
- **Environment-Specific Isolation**: Dedicated configurations for each environment minimize risks and enhance control over deployments.

# How to Use This Repository

## Prerequisites

To utilize this repository effectively, ensure the following tools are installed on your local system:

- **Docker**: For building and running containerized applications.
- **AWS CLI**: To interact with AWS services and push Docker images to ECR.
- **Terraform**: For provisioning the infrastructure.
- **Git**: For version control and repository cloning.
- **Java and Maven**: For running and building the Spring Boot application locally.

## Cloning the Repository

Clone the repository to your local machine using the command:

```bash
git clone <repository_url>
```
## Repository Structure

The repository is organized into two primary directories:

- **Application**: Contains the Spring Boot application code and its Docker setup.
- **Deployment**: Includes Terraform configurations, environment-specific variables, and other deployment resources.

Navigate to the respective directories based on your task:

- **Application development and testing**: Work within the `application/` directory.
- **Infrastructure provisioning and deployment**: Work within the `deployment/` directory.

## Step-by-Step Usage

### 1. Building and Running the Application Locally

- Navigate to the `application/` directory.
- Build the Docker image:
```bash
docker build -t taskmaster-app .
```
- Run the application:
```bash
docker-compose up
```
- Access the application locally at http://localhost:8080.

### 2. Pushing the Docker Image to AWS ECR
- Authenticate Docker to your ECR registry:
```bash
aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin <account_id>.dkr.ecr.<region>.amazonaws.com
```
- Tag the Docker image:
```bash
docker tag taskmaster-app:latest <ecr_repository_url>:latest
```
- Push the image:
```bash
docker push <ecr_repository_url>:latest
```
### 3. Provisioning Infrastructure with Terraform
- Navigate to the deployment/terraform directory.
- Initialize Terraform:
```bash
terraform init
```
- This includes backend setup using S3 for state file storage and DynamoDB for locking.
- Apply the Terraform configuration:
```bash
terraform apply -var-file=<environment>.tfvars
```
- Replace <environment> with the desired environment (e.g., dev, staging, or prod).
### 4. Deploying the Application to AWS ECS
- Ensure the infrastructure has been provisioned using Terraform.
- Push the updated Docker image to ECR as described earlier.
- The CI/CD pipeline configured in GitHub Actions will automatically deploy the latest image to ECS upon successful pushes to the main branch.
### 5. Monitoring with Prometheus and Grafana
- Prometheus and Grafana are deployed as part of the infrastructure.
- Access Grafana at http://<grafana_endpoint>:3030 (default port: 3030).
- Configure dashboards using Prometheus as the data source.

