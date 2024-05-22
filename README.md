# Useful Scripts

This repository contains scripts for automatically installing Nginx, Certbot via Snap, and Docker on Ubuntu. The scripts also configure Nginx to use Certbot and set up automatic certificate renewal.

## Contents

- [Requirements](#requirements)
- [Installation Instructions](#installation-instructions)
- [Script Functions](#script-functions)
- [Description of the Second Script](#description-of-the-second-script)

## Requirements

To run these scripts, superuser (sudo) privileges are required.

## Installation Instructions

1. Download and run the first script with one command:

    ```bash
    sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/neatek/nginx-docker-certbot/main/install.sh)"
    ```

## Script Functions

1. Updates the package list.
2. Installs Nginx and Snapd.
3. Starts Nginx and enables it to start on boot.
4. Installs Certbot via Snap.
5. Creates a symbolic link for Certbot.
6. Sets up automatic certificate renewal checks.
7. Installs Docker and its dependencies.
8. Adds the official Docker GPG key and configures the Docker repository.
9. Installs Docker Engine and necessary components.
10. Starts Docker and enables it to start on boot.

## Notes

- Ensure you have a domain name configured to point to your server for Certbot to obtain an SSL certificate.
- The script checks for automatic certificate renewal using the `certbot renew --dry-run` command.

If you encounter any issues with the installation or have questions, please refer to the documentation of the respective tools:

- [Nginx](https://nginx.org/en/docs/)
- [Certbot](https://certbot.eff.org/docs/)
- [Docker](https://docs.docker.com/)

## Description of the Second Script

This script adds a domain configuration to Nginx and runs Certbot to obtain an SSL certificate for the specified domain.

### Installation Instructions

1. Download and run the second script with one command:

    ```bash
    sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/neatek/nginx-docker-certbot/main/setup_domain.sh)"
    ```

### Script Functions

1. Prompts the user to enter the domain name.
2. Adds a configuration for the specified domain to the `/etc/nginx/sites-available/default` file.
3. Creates a directory for the domain and adds a sample `index.html` file.
4. Tests the Nginx configuration and reloads it.
5. Runs Certbot to obtain an SSL certificate for the specified domain.
6. Checks for automatic certificate renewal.

This script simplifies the setup of Nginx and SSL certificates for your domain by adding the necessary configuration and automatically setting up Certbot to work with Nginx.
