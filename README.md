# Terraform AWS Django

## About

This repo is a collection of Terraform modules for deploying Django applications on AWS. Currently the supported modules are:

- ECS Fargate
- EC2 using docker compose (WIP)

These two application architectures both use containers for running the core application, but have different levels of cost, security and complexity.

### ECS Fargate

- appropriate for production environments
- expensive to run
- https (Amazon Certificate Manager)
- secure networking (3-tier VPC)
- managed database (RDS)
- managed cache (ElastiCache)
- orchestration (ECS, AWS CLI, GitHub Actions)
- pulls application images from ECR

### EC2 Docker Compose

- appropriate for non-critical production environments
- inexpensive to run
- https (certbot)
- unsecure networking (runs in default VPC in a public subnet)
- self-hosted database (docker volume, EBS)
- self-hosted cache (docker volume, EBS)
- orchestration (docker compose, Systems Manager, cloud-config, GitHub Actions)
- builds application images from source code (docker compose build)

## Directory structure

This IaC library has two main folders:

- `modules`
- `examples`

### `modules` directory

The `modules` directory contains the Terraform modules. In the `modules` directory, the `internal` directory contains building blocks that are used by other "high-level" modules. The `internal` modules are organized by AWS service. For example, the `rds` module contains resources for building an RDS database, including a security group, a secret used for the database password, and the database instance.

#### `ecs` module

Current development efforts for this project are focused on improving the `ecs` module. This module is split into `base` and `app`.

The `base` module deploys long-lived resources that shouldn't need to be updated frequently, these include:

- VPC
- ElastiCache
- S3
- Security Groups
- Load balancer
- RDS

The `app` module deploys resources primarily for ECS services that run the application, these include:

- ECS cluster for the environment
- web-facing services (for running gunicorn and for running the frontend UI app)
- celery worker for asynchronous task processing
- celery beat for scheduled tasks
- management_command for running migrations and other "pre-update" tasks (collectstatic, loading fixtures, etc.)
- All backend environment variables are configured here (shared between all backend services)
- Route 53 record for the environment (e.g. `<env_name>.example.com`)
- IAM resources (this might be able to be moved to the base stack)

The `base` and `app` modules could be split further into smaller modules for better separation of concerns. For example, you might want to split the base module into `networking`, `database`, etc. For simplicity, I just use the `base` and `app` modules.

The `app` module consumes the Terraform `outputs` from the `base` module, so you need to deploy the base module first.

Multiple `app` environments can be deployed on top of a single `base` module.

For example, you may have a `base` environment called `production` with only one `app` environment called `app`. This would correspond to the production environment that would be made available at `app.example.com`.

You may choose to have another `base` environment called `dev` with multiple `app` environments used for different purposes, such as `qa`, feature-branch environments, or any other named environment (e.g. `alpha`, `beta`, etc.)

### `examples` directory

The `examples` directory contains examples how each high-level application. These examples are used for quickly spinning up resources.

## Companion application

To see how `terraform-aws-django` can be used, have a look at [https://github.com/briancaffey/django-step-by-step](https://github.com/briancaffey/django-step-by-step).

This companion repo includes two main components: a Django application (backend) and a Nuxt.js application (frontend)

### Django backend application features

- email-based authentication flow (confirmation email + forgot password)
- microblog app (users can write posts with text and images, like posts)
- chat app (a simple OpenAI API wrapper)

### Nuxt.js frontend client features

- Vue 3, Nuxt v3.15
- SSR
- shadcn
- tailwindcss
- pinia
- composables

## Usage

This module is not intended to work with any Django application, but it is a good starting point if your application structure and requirements are similar to those of the companion application.

## Not documented

- Creation of S3 bucket and DynamoDB table for Terraform backend
- Creation of least-privilege IAM roles for use in GitHub Actions with OpenID Connect
- Creation of ECR repositories

## Roadmap

- Finish module for EC2 with docker compose
- Create reusable GitHub Actions that live in this repo and use them in the companion repo
- Autoscaling for ECS application services
- Support Kubernetes and EKS