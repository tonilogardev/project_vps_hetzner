# Not everything is customizable...

## Index

1. [Create GitHub repository](#1-create-github-repository)  
2. [Clone repository in local machine](#2-clone-repository-in-local-machine)  
3. [Create private and public SSH key](#3-create-private-and-public-ssh-key)
3. [Restrict permissions ssh files](#4-restrict-permissions-ssh-files)
---

## 1 Create GitHub repository

-***Create manual repository***:  
[Github](https://github.com/) →  
![Example](./img/001_start_project_001.png)  
-***Create [README.md](../README.md)  file***.  
-***Create [.gitignore](../.gitignore) NODE***.  
-***Create [NOTICE](../NOTICE)***.  
-***Select license [LICENSE](../LICENSE)***.

[←Index](#index)


## 2 Clone repository in local machine  

```git clone https://github.com/tonilogardev/project_vps_hetzner.git ```  

Create and move main_dev_pro branch.  

``` git branch main_dev_pro ```  
``` git checkout main_dev_pro ```  

[←Index](#index)

## 3 Create private and public SSH key  

Generate a key pair for the "hetzner vps" and "github actions" add this files in .gitignore. 

 [.gitignore)](../.gitignore) 

``` 
#ssh files
002_ssh_key/* 
```  

```bash  
mkdir -p 002_ssh_key
cd 002_ssh_key
ssh-keygen -t ed25519 \
  -f ssh_vps_hetzner_deploy_github_action \
  -C "tonilogardev@ssh_vps_hetzner_deploy_github_action" \
  -N ""
``` 

```bash  
Generating public/private ed25519 key pair.
Your identification has been saved in ssh_vps_hetzner_deploy_github_action
Your public key has been saved in ssh_vps_hetzner_deploy_github_action.pub
The key fingerprint is:
SHA256:zkfbibM5BTC5QJdPQmHBwRKEaX7nV9NVrJ22wQCBOiY tonilogardev@ssh_vps_hetzner_deploy_github_action
The key's randomart image is:
+--[ED25519 256]--+
|     =+=B*.oo  .o|
|    + ooO..  .  o|
|   o   o.B   .o+.|
|    .E.+o o o o=.|
|     .ooS .o .. o|
|       o...+.. . |
|        o.=.o    |
|         ..+     |
|          o.     |
+----[SHA256]-----+
``` 
[←Index](#index)

## 4 Restrict permissions ssh files

```bash
chmod 600 ssh_vps_hetzner_deploy_github_action
```

Test permissions.

```bash
ls -l ssh_vps_hetzner_deploy_github_action
```
Output

```bash
-rw------- 1 a.lopez.g domain users 452 de nov.  18 15:02 ssh_vps_hetzner_deploy_github_action
```
[←Index](#index)

## Next steps

- [002_hetzner_login_domain_API_tokens](./002_hetzner_login_domain_API_tokens.md)

