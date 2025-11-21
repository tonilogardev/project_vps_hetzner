#!/bin/bash
# Bootstrap Docker, Certbot (DNS Hetzner) and wildcard certs for the domain.
set -euo pipefail
export DEBIAN_FRONTEND=noninteractive

log() {
  echo "[$(date -u +"%Y-%m-%dT%H:%M:%SZ")] $*"
}

DOMAIN_NAME="${domain_name}"
ADMIN_EMAIL="${admin_email}"
HETZNERDNS_TOKEN="${hetznerdns_token}"
DOCKER_COMPOSE_VERSION="${docker_compose_version}"

log "Updating packages"
apt-get update -y
apt-get upgrade -y

log "Installing prerequisites"
apt-get install -y curl software-properties-common apt-transport-https ca-certificates gnupg ufw

log "Installing Docker"
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
systemctl enable --now docker
log "Docker Compose version requested: ${DOCKER_COMPOSE_VERSION} (using package repo version)"
docker --version || true
docker compose version || true

log "Installing Certbot and Hetzner DNS plugin"
apt-get install -y certbot python3-pip
if apt-get install -y python3-certbot-dns-hetzner; then
  log "certbot-dns-hetzner installed via apt"
else
  log "apt failed; installing certbot-dns-hetzner via pip"
  pip install --break-system-packages certbot-dns-hetzner
fi

log "Writing Hetzner DNS credentials for Certbot"
HETZNER_CREDS_DIR="/root/.secrets"
HETZNER_CREDS_FILE="$HETZNER_CREDS_DIR/hetzner_credentials.ini"
mkdir -p "$HETZNER_CREDS_DIR"
chmod 0700 "$HETZNER_CREDS_DIR"
echo "dns_hetzner_api_token = ${HETZNERDNS_TOKEN}" > "$HETZNER_CREDS_FILE"
chmod 0600 "$HETZNER_CREDS_FILE"

log "Requesting wildcard certificates for ${DOMAIN_NAME}"
certbot certonly --authenticator dns-hetzner \
  --dns-hetzner-credentials "$HETZNER_CREDS_FILE" \
  --non-interactive --agree-tos \
  --email "${ADMIN_EMAIL}" \
  -d "${DOMAIN_NAME}" -d "*.${DOMAIN_NAME}" \
  --server https://acme-v02.api.letsencrypt.org/directory \
  || log "Certbot did not obtain certificate on first attempt"

log "Configuring automatic renewal"
(crontab -l 2>/dev/null; echo "0 3 * * * /usr/bin/certbot renew --quiet") | crontab -

CERT_PATH="/etc/letsencrypt/live/${DOMAIN_NAME}"
if [ -d "$CERT_PATH" ]; then
  log "Certificates located at $CERT_PATH"
else
  log "WARNING: Certificate directory not found at $CERT_PATH. Check /var/log/letsencrypt/letsencrypt.log"
fi

log "Hardening SSH: disable password auth"
sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config
sed -i 's/^#\?KbdInteractiveAuthentication.*/KbdInteractiveAuthentication no/' /etc/ssh/sshd_config
systemctl restart sshd

log "Configuring UFW firewall (allow 22,80,443)"
ufw default deny incoming
ufw default allow outgoing
ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp
ufw --force enable
ufw status verbose || true

log "Bootstrap completed"
