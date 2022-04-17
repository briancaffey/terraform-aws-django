# Ad Hoc Shared example

This example shows how you can build ad hoc environments with shared resources.

This example uses another construct on the Terraform Registry to build shared resources, including:

- VPC
- Security Groups
- IAM Roles
- Service Discovery Namespace
- Load Balancer
- RDS instance (postgres)
- Bastion Host

These resource will be referenced in the `ad-hoc-environment` example using `terraform_remote_state`.

The `ad-hoc-environment` example implements the following resources:

- ECS Cluster
- ECS Tasks and Services
- Load Balancer Listener Rules
- Load Balancer Target Groups
- Route 53 records
- S3 Bucket