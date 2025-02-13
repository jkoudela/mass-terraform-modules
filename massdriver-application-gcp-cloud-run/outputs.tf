output "identity" {
  description = "Cloud ID for application IAM. For GCP this is the Service Account email."
  value       = module.application.id
}

output "hostname" {
  description = "Default hostname for the application."
  value       = google_cloud_run_service.main.status.0.url
}

output "grn" {
  description = "GCP Cloud Run GRN"
  value       = google_cloud_run_service.main.id
}
