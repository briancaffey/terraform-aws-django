## Production Base Module

This module contains the base layer of infrastructure for the production environment. This includes the following resources:

- VPC
- Subnets
- Security Groups
- IAM Roles
- RDS
- Elasticache
- S3 Bucket
- Load Balancer
- ECS Cluster

This contains everything except for the ECS services which are defined in another module (`prod/app`).