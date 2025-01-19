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

<img width="462" alt="root-dir-str" src="https://github.com/user-attachments/assets/1d9e8dab-33fe-4055-873a-6607a7295e8f" />

- **Dockerfile**: Defines the steps for building the core application container image.
- **README.md**: Serves as the primary documentation for onboarding and understanding the project.
- **docker-compose.yml**: Facilitates local service orchestration for development and testing.
- **pom.xml**: Functions as the parent POM for centralizing dependencies, plugins, and build configurations across modules, ensuring uniformity.

### Significance of Root pom.xml

The root `pom.xml` centralizes shared dependencies, plugin configurations, and build settings. As the parent for module-specific POMs, it ensures consistency across the project, minimizes redundancy, and resolves potential version conflicts.

## Application Directory Structure
<img width="1286" alt="api tasks postman list all tasks" src="https://github.com/user-attachments/assets/687a1f54-d8c2-4c8a-b485-ae3bfd56443a" />
<img width="1297" alt="list task by valid id" src="https://github.com/user-attachments/assets/b399bc04-a54d-4c25-801b-e0367e6075dd" />
<img width="1290" alt="list task by invalid id" src="https://github.com/user-attachments/assets/ec107863-e847-4b9e-a9ee-7ef9da990666" />

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
<img width="240" alt="deploy dir str" src="https://github.com/user-attachments/assets/c67b3f76-e9fc-4244-9307-8978798530f7" />

- **docker-compose.yml**: Defines multi-container setups for local development, including the application, databases, and other services.
- **terraform**: Manages cloud infrastructure using IaC principles.
- **Modules**: Encapsulates reusable infrastructure components, such as ALB, ECR, and ECS configurations.
- **Environment-Specific Directories**: Isolates configurations for dev, staging, and production environments to prevent configuration drift.

### Role of modules and tfvars in Terraform

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
![flow](https://github.com/user-attachments/assets/9e83ee6e-5751-45e3-9067-1e766cf1e6c8)

### Docker and Image Automation
<img width="1103" alt="docker build timing plots from docker console" src="https://github.com/user-attachments/assets/32b2d0cc-6869-46e8-af0d-39bf02e6b272" />

Docker streamlines application packaging and deployment through containerization. The process includes:
- **Image Creation**: The `Dockerfile` specifies instructions for building the application image, including dependency installation and environment setup.
- **CI/CD Integration**: CI/CD tools such as GitHub Actions automate image creation and deployment, reducing manual intervention.

### GitHub Actions for CI/CD Automation
<img width="1417" alt="cicd success deploy on github" src="https://github.com/user-attachments/assets/51c77903-4f1c-4d4f-a848-d92d39f32fb3" />

GitHub Actions simplifies the CI/CD process by enabling:
- **Build Automation**: Automatically triggers Docker builds upon code commits.
- **Test Automation**: Executes unit and integration tests to ensure application reliability.
- **Deployment Automation**: Deploys to designated environments (e.g., dev, staging, production) upon successful testing.

This automation accelerates the development lifecycle, minimizes errors, and promotes consistent deployments.

## Monitoring and Visualization with Prometheus and Grafana

### Prometheus
<img width="1434" alt="prometheus functioning on localhost:9090/targets" src="https://github.com/user-attachments/assets/f1c8f0ac-0848-4120-bfcc-d159e980690d" />
<img width="1434" alt="prometheus up query result" src="https://github.com/user-attachments/assets/d2efccf3-6f14-4750-932d-420d05c35042" />

Prometheus collects and analyzes performance metrics, such as response times, error rates, and resource utilization, from the Spring Boot application. Integration highlights include:
- **Metrics Scraping**: Configured to collect data from the `/actuator/prometheus` endpoint.
- **Alerting**: Enables proactive issue resolution through threshold-based alerts.

### Grafana

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

