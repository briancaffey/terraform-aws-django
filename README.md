# Terraform AWS Django

## About

This repo is a collection of Terraform modules for deploying Django applications on AWS using EC2, ECS (EC2 + Fargate), and EKS.

Currently this repo contains one high-level module for deploying a Django application on AWS using ECS (Fargate launch type).

See the `examples/` directory for examples of how to use this module.

Here is a companion repo that shows how to use this module with a Django application: [https://github.com/briancaffey/django-step-by-step](https://github.com/briancaffey/django-step-by-step).

Also see [https://github.com/briancaffey/terraform-aws-ad-hoc-environments](https://github.com/briancaffey/terraform-aws-ad-hoc-environments) for a repo that shows how to use this module with an ad-hoc environment.

## Deploying resources locally

### Environment variables

Copy `.env.template` to a new file in the root of the repository called `.env` and replace with appropriate values.

The ACM certificate should cover both `example.com` and `*.example.com`.

```
export TF_VAR_certificate_arn=abc123
export TF_VAR_domain_name=example.com
```