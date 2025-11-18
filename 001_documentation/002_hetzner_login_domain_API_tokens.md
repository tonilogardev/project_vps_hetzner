# Hetzner login, domain & tokens

## Index

1. [Create Hetzner user](#1-create-hetzner-user)
2. [Buy domain](#2-buy-domain)
3. [Create Hetzner API tokens](#3-create-hetzner-api-tokens)

---

## 1 Create Hetzner user

[Create user or login →](https://accounts.hetzner.com/login)

![Hetzner steps](./img/001_hetzner_user.png)

[←Index](#index)

## 2 Buy domain

We use Let's Encrypt, so a real domain is mandatory.

- Ownership verification stays under your control.  
- Certificates renew automatically even if the IP changes.  
- Wildcard SSL lets us reuse the same cert for all subdomains.

- ❌ `https://5.75.244.206`  
- ✅ `https://yourdomain.com`

[Search and buy domain](https://www.hetzner.com/whois/) →

![Steps in Hetzner](./img/001_buy_domain.png)

[Create DNS zone for the domain](https://dns.hetzner.com/) →  
![DNS zone](./img/003_dns_zone.jpg)  
![DNS zone](./img/004_dns_zone.png)

Quick check:  
Shows current IP
```bash
nslookup tonilogar.com  
```

```
Server:         127.0.0.53
Address:        127.0.0.53#53

Non-authoritative answer:
Name:   tonilogar.com
Address: 128.140.114.179
Name:   tonilogar.com
Address: 2a01:4f8:c013:e4b4::1
```
[←Index](#index)

## 3 Create Hetzner API tokens

Create a project in https://console.hetzner.cloud and generate a Cloud API token.

![Generate API token](./img/007_hetznet_api_token.png)
![Generate API token](./img/008_hetznet_api_token.png)

Generate a DNS API token at https://dns.hetzner.com/settings/api-token.

![Generate API token](./img/009_hetznet_api_token.png)

[←Index](#index)

- [003_terraform](./003_terraform.md)
