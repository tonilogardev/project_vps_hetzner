locals {
  ssh_public_key_path = pathexpand("${var.SSH_KEY_PATH}${var.SSH_KEY_NAME}.pub")
  admin_label         = replace(lower(var.ADMIN_EMAIL), "@", "-at-")

  server_labels = {
    project = "hetzner_vps"
    domain  = replace(var.DOMAIN_NAME, ".", "-")
    admin   = substr(local.admin_label, 0, 64)
  }
}

resource "hcloud_ssh_key" "deploy" {
  name       = var.SSH_KEY_NAME
  public_key = file(local.ssh_public_key_path)
  labels     = local.server_labels
}

resource "hcloud_server" "main" {
  name        = var.SERVER_NAME
  image       = var.SERVER_IMAGE
  server_type = var.SERVER_TYPE
  location    = var.SERVER_LOCATION
  ssh_keys    = [hcloud_ssh_key.deploy.id]
  backups     = false
  keep_disk   = true
  labels      = merge(local.server_labels, { role = "web" })

  lifecycle {
    ignore_changes = [labels]
  }
}
