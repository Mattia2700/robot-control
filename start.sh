#! /usr/bin/env sh

if !(command -v "docker-compose" &>/dev/null)
then echo "Docker Compose is not installed, please download it."
else docker-compose pull && docker-compose up
fi