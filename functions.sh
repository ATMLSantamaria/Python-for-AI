#!/bin/bash

# This script provides utility functions to simplify common Docker tasks.
# Source this file in your shell to use the functions directly.

# Function: docker_build
# Description: Builds a Docker image from the current directory's Dockerfile.
# Usage: docker_build <image_name>
docker_build() {
    local image_name=$1
    if [ -z "$image_name" ]; then
        echo "Usage: docker_build <image_name>"
        return 1
    fi
    docker build -t "$image_name" .
    echo "Docker image '$image_name' built successfully."
}

# Function: docker_run_interactive
# Description: Runs a Docker container interactively with a shell session.
# Usage: docker_run_interactive <image_name> <container_name>
docker_run_interactive() {
    local image_name=$1
    local container_name=$2
    if [ -z "$image_name" ] || [ -z "$container_name" ]; then
        echo "Usage: docker_run_interactive <image_name> <container_name>"
        return 1
    fi
    docker run -it --name "$container_name" "$image_name"
}

# Function: docker_list_running
# Description: Lists all currently running Docker containers.
# Usage: docker_list_running
docker_list_running() {
    echo "Listing all running containers:"
    docker ps
}

# Function: docker_list_all
# Description: Lists all Docker containers, including stopped ones.
# Usage: docker_list_all
docker_list_all() {
    echo "Listing all containers (including stopped):"
    docker ps -a
}

# Function: docker_enter_shell
# Description: Opens a shell session in a running Docker container.
# Usage: docker_enter_shell <container_name>
docker_enter_shell() {
    local container_name=$1
    if [ -z "$container_name" ]; then
        echo "Usage: docker_enter_shell <container_name>"
        return 1
    fi
    # Try /bin/bash first, fallback to /bin/sh if bash is not available.
    docker exec -it "$container_name" /bin/bash || docker exec -it "$container_name" /bin/sh
}

# Function: docker_clean_container
# Description: Stops and removes a Docker container by name or ID.
# Usage: docker_clean_container <container_name>
docker_clean_container() {
    local container_name=$1
    if [ -z "$container_name" ]; then
        echo "Usage: docker_clean_container <container_name>"
        return 1
    fi
    docker stop "$container_name" && docker rm "$container_name"
    echo "Container '$container_name' stopped and removed."
}

# Function: docker_remove_image
# Description: Removes a Docker image by name or ID.
# Usage: docker_remove_image <image_name>
docker_remove_image() {
    local image_name=$1
    if [ -z "$image_name" ]; then
        echo "Usage: docker_remove_image <image_name>"
        return 1
    fi
    docker rmi "$image_name"
    echo "Image '$image_name' removed."
}
