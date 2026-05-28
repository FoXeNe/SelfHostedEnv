#!/usr/bin/env bash

set -e

mkdir -p data
mkdir -p data/.cache

chown -R 1001:1001 data/.runner
chown -R 1001:1001 data/.cache
chmod 775 data/.runner
chmod 775 data/.cache
chmod g+s data/.runner
chmod g+s data/.cache

sudo docker compose run --rm runner forgejo-runner generate-config >./data/config.yml
sudo chown 1001:1001 ./data/config.yml
