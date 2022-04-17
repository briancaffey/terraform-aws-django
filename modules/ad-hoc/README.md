# Ad Hoc Environment

This terraform configuration provides set of resources to build an ad hoc environment. Ad hoc environments are used for quickly testing a new feature or fix in an isolated environment. This ad hoc environment is designed to be used with shared resources that can be deployed with another terraform configuration called [terraform-aws-ad-hoc-environments](https://github.com/briancaffey/terraform-aws-ad-hoc-environments).

See `examples/ad-hoc-environment` for a complete example of how to use this configuration along with `terraform-aws-ad-hoc-environments`.