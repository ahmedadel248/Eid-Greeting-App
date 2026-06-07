# Eid Greeting App 🚀

A simple Eid Greeting Web Application used to demonstrate a complete DevOps deployment workflow from local development to cloud infrastructure.

The application allows users to enter their name and receive a personalized Eid greeting message. While the application itself is lightweight, the main objective of this project was to build and deploy it using modern DevOps tools and cloud technologies.

## Architecture Overview

The project follows a complete deployment flow:

Application → Docker → Docker Hub → Kubernetes → AWS Infrastructure

## Project Components

### Application Layer

The web application is built using:

* HTML
* CSS
* JavaScript

Users can enter their name and receive a personalized Eid greeting message through a simple interactive interface.

### Containerization

The application is containerized using:

* Docker
* Nginx

The Docker image is built locally and pushed to Docker Hub for deployment.

### Kubernetes Deployment

The application is deployed on Kubernetes using:

* Deployment
* Service
* Ingress

Ingress is configured for hostname-based routing.

### Infrastructure as Code

Infrastructure provisioning is automated using Terraform.

Resources include:

* VPC
* Public Subnet
* Internet Gateway
* Route Table
* Security Group
* EC2 Instance
* Elastic IP

Terraform configuration also demonstrates:

* Variables
* Outputs
* Variable Definitions

### Cloud Environment

The infrastructure is hosted on AWS.

A K3s Kubernetes cluster is installed on the EC2 instance to run the application workloads.

## Repository Structure

```text
Eid-Greeting-App/
├── app/
│   ├── index.html
│   ├── style.css
│   ├── script.js
│   └── Dockerfile
│
├── k8s/
│   ├── deployment.yaml
│   ├── service.yaml
│   └── ingress.yaml
│
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── terraform.tfvars
│
├── screenshots/
└── README.md
```

## Technologies Used

* AWS
* Terraform
* Kubernetes
* K3s
* Docker
* Docker Hub
* Nginx
* Linux
* HTML
* CSS
* JavaScript

## Learning Outcomes

This project helped me gain hands-on experience with:

* Infrastructure as Code using Terraform
* Containerization with Docker
* Kubernetes deployments and networking
* Ingress-based routing
* AWS infrastructure provisioning
* End-to-end application deployment workflows

## Future Improvements

* CI/CD implementation using Jenkins or GitHub Actions
* Automated image builds and deployments
* Real domain integration with DNS
* TLS/HTTPS configuration
* Monitoring and logging stack

## Author

Ahmed Adel

AIOps Engineer Trainee | DevOps & Cloud Enthusiast
