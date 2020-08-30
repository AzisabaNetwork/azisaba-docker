#!/bin/bash

set -e

script_dir=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
root_dir=$(realpath "$script_dir"/..)

docker_compose_random_up() {
  for service in $(docker-compose config --services); do
    (
      sleep "$(shuf -i 0-300 -n 1)"
      docker-compose up -d "$service"
    ) &
  done
  wait
}

(
  cd "$root_dir"

  docker-compose up -d mcredis database bungee lobby
  docker_compose_random_up
)
