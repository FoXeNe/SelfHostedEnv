# SelfHostedEnv

Docker Compose files for my home server. Each service has its own directory, and Ansible copies the Compose files to the server and starts the stacks.

## What's running

| Stack | What it's for |
| --- | --- |
| `npm`, `authelia`, `pihole` | Reverse proxy (Nginx Proxy Manager), login, and local DNS |
| `homepage`, `dockge`, `monitoring` | Home dashboard, Compose management, and metrics with Prometheus, Grafana, and Node Exporter |
| `forgejo`, `forgejo-runner` | Git hosting and CI |
| `immich`, `filebrowser`, `syncthing` | Photos, file browsing, and file sync |
| `vaultwarden`, `matrix`, `zerobyte` | Passwords, chat (Synapse), and backups |

## Deploying

`deploy.yml` expects a Linux host with Python 3, Docker, and the Compose v2 plugin. The SSH user needs access to the Docker socket and write access to `/home/dockeruser/services`.

Before running the playbook:

- Put the target host and SSH user in `inventory.ini`.
- Create the shared Docker network on the server with `docker network create proxy_net` if it doesn't exist yet.
- Supply your own Ansible variables in `secret.yml`. The checked-in copy is encrypted with Ansible Vault. Some Compose files are Jinja templates, so they need to be rendered before Docker Compose can use them.
- Set the Compose environment variables and put any required config files on the server. The playbook only copies the Compose files. Check each stack for `.env` values, mounted configs, and paths that need to match your machine.

From the repo root, with Ansible installed:

```sh
ansible-galaxy collection install 'community.docker:<=3.12.2'
ansible-playbook -i inventory.ini deploy.yml --ask-vault-pass
```

The [Forgejo workflow](.forgejo/workflows/deploy.yml) runs the same playbook on pushes to `master`. It uses the `ANSIBLE_INVENTORY`, `SSH_PRIVATE_KEY`, and `VAULT_PASSWORD` secrets. The [Forgejo runner](forgejo-runner/) is set up separately and isn't deployed by the playbook.
