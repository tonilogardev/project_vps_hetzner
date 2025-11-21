locals {
  dns_ttl_seconds = 300
}

data "hetznerdns_zone" "primary" {
  name = var.DOMAIN_NAME
}

resource "hetznerdns_record" "apex_a" {
  zone_id = data.hetznerdns_zone.primary.id
  name    = "@"
  type    = "A"
  value   = hcloud_server.main.ipv4_address
  ttl     = local.dns_ttl_seconds
}

resource "hetznerdns_record" "apex_aaaa" {
  count   = var.ENABLE_IPV6 ? 1 : 0
  zone_id = data.hetznerdns_zone.primary.id
  name    = "@"
  type    = "AAAA"
  value   = hcloud_server.main.ipv6_address
  ttl     = local.dns_ttl_seconds
}

resource "hetznerdns_record" "subdomain_a" {
  for_each = toset(var.SUBDOMAINS_TO_REGISTER)

  zone_id = data.hetznerdns_zone.primary.id
  name    = each.value
  type    = "A"
  value   = hcloud_server.main.ipv4_address
  ttl     = local.dns_ttl_seconds
}

resource "hetznerdns_record" "subdomain_aaaa" {
  for_each = var.ENABLE_IPV6 ? toset(var.SUBDOMAINS_TO_REGISTER) : toset([])

  zone_id = data.hetznerdns_zone.primary.id
  name    = each.value
  type    = "AAAA"
  value   = hcloud_server.main.ipv6_address
  ttl     = local.dns_ttl_seconds
}
