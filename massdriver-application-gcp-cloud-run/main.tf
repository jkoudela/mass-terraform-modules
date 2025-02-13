module "application" {
  source  = "github.com/massdriver-cloud/terraform-modules//massdriver-application?ref=735929b"
  name    = var.md_metadata.name_prefix
  service = "function"
}

resource "google_cloud_run_service" "main" {
  name     = var.md_metadata.name_prefix
  location = var.platform.location

  template {
    metadata {
      annotations = {
        # Use the VPC Connector
        "run.googleapis.com/vpc-access-connector" = var.vpc_connector
        # all egress from the service should go through the VPC Connector
        "run.googleapis.com/vpc-access-egress" = "all-traffic"
        "autoscaling.knative.dev/maxScale"     = "${var.platform.max_instances}"
      }
    }

    spec {
      service_account_name  = module.application.id
      container_concurrency = var.container.concurrency
      containers {
        image = "${var.container.image.repository}:${var.container.image.tag}"
        ports {
          container_port = var.container.port
        }
        dynamic "env" {
          for_each = module.application.envs
          content {
            name  = env.key
            value = env.value
          }
        }
      }
    }
  }
  metadata {
    annotations = {
      # For valid annotation values and descriptions, see
      # https://cloud.google.com/sdk/gcloud/reference/run/deploy#--ingress
      "run.googleapis.com/ingress" = "internal-and-cloud-load-balancing"
    }
  }

  depends_on = [
    module.apis
  ]
}
