/*output "client_token" {
  sensitive = true
  value     = base64encode(data.google_client_config.default.access_token)
}
*/
output "service_account" {
  description = "The default service account used for running nodes."
  value       = "iam-kube-account@qrcode-374515.iam.gserviceaccount.com"
}

output "kubernetes_namespace" {
  description = "The default service account used for running nodes."
  value       = "tenantx"
}

output "google_storage_bucket" {
  description = "The default service account used for running nodes."
  value       = "qrcode-tenantx-logo"
}