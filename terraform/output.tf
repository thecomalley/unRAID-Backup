output "PING_URL" {
  value       = healthchecksio_check.appdata.ping_url
  description = "Ping URL associated with this check"
}