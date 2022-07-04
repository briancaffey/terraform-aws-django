###############################################################################
# Cloud Map / Service Discovery Private DNS Namespace
###############################################################################

resource "aws_service_discovery_private_dns_namespace" "this" {
  name        = "${terraform.workspace}-sd-ns"
  description = "Service discovery namespace for ${terraform.workspace} workspace"
  vpc         = var.vpc_id
}
