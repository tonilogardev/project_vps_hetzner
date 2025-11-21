variable "HETZNER_CLOUD_TOKEN" {
  description = "API token for Hetzner Cloud (HCLOUD) requests."
  type        = string
  sensitive   = true

  validation {
    condition     = length(trimspace(var.HETZNER_CLOUD_TOKEN)) > 0
    error_message = "HETZNER_CLOUD_TOKEN cannot be empty."
  }
}

variable "HETZNER_DNS_TOKEN" {
  description = "API token for Hetzner DNS."
  type        = string
  sensitive   = true

  validation {
    condition     = length(trimspace(var.HETZNER_DNS_TOKEN)) > 0
    error_message = "HETZNER_DNS_TOKEN cannot be empty."
  }
}

variable "DOMAIN_NAME" {
  description = "Root domain managed in Hetzner DNS (e.g., tonilogar.com)."
  type        = string

  validation {
    condition     = length(trimspace(var.DOMAIN_NAME)) > 0
    error_message = "DOMAIN_NAME must be a valid domain."
  }
}

variable "ADMIN_EMAIL" {
  description = "Contact email for the project administrator."
  type        = string
}

variable "SSH_KEY_PATH" {
  description = "Directory where the SSH key pair generated in step 002 lives."
  type        = string
}

variable "SSH_KEY_NAME" {
  description = "Base name of the SSH key pair (without .pub)."
  type        = string
}

variable "SERVER_NAME" {
  description = "Friendly name for the Hetzner VPS."
  type        = string
}

variable "SERVER_IMAGE" {
  description = "Image slug used to create the VPS (e.g., ubuntu-24.04)."
  type        = string
}

variable "SERVER_TYPE" {
  description = "Hetzner server type (hardware plan) to provision."
  type        = string
}

variable "SERVER_LOCATION" {
  description = "Hetzner location (fsn1, nbg1, hel1, etc.)."
  type        = string
}

variable "DOCKER_COMPOSE_VERSION" {
  description = "Version reference used when bootstrapping Docker Compose on the server."
  type        = string
}

variable "SUBDOMAINS_TO_REGISTER" {
  description = "List of subdomains that must point to the VPS (e.g., www, data-science)."
  type        = list(string)
  default     = []
}
