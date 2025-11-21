output "server_ipv4" {
  description = "Primary IPv4 address of the Hetzner VPS."
  value       = hcloud_server.main.ipv4_address
}

output "server_ipv6" {
  description = "Primary IPv6 address of the Hetzner VPS."
  value       = hcloud_server.main.ipv6_address
}

output "ssh_key_fingerprint" {
  description = "Fingerprint of the SSH key uploaded to Hetzner Cloud."
  value       = hcloud_ssh_key.deploy.fingerprint
}

output "domain_url" {
  description = "Canonical HTTPS URL for the root domain."
  value       = "https://${var.DOMAIN_NAME}"
}

output "subdomain_urls" {
  description = "List of HTTPS URLs corresponding to the managed subdomains."
  value = [
    for subdomain in var.SUBDOMAINS_TO_REGISTER :
    "https://${subdomain}.${var.DOMAIN_NAME}"
  ]
}

output "docker_compose_version" {
  description = "Docker Compose version requested for server bootstrap workflows."
  value       = var.DOCKER_COMPOSE_VERSION
}
