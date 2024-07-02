# Orchestra

This repository contains the necessary files and documentation to create a server in Digital Ocean using Terraform (Replaced by OpenTofu) and configure it with Ansible.

## Prerequisites

Before getting started, make sure you have the following:

- A Digital Ocean or Google Cloud account
- Terraform (Replaced by OpenTofu) installed on your local machine
- Ansible installed on your local

## Digital Ocean Setup

- Create project in digital ocean
- Add your private key on digital ocean

## Google Cloud Setup

- Create project in Google Cloud
- Enable Compute Engine API
- Create service account and keys

## Getting Started

To create the server and configure it with Ansible, follow these steps:

1. Clone this repository to your local machine.
2. Open a terminal and navigate to the repository's directory.
3. Update the `terraform.tfvars` file with your desired server configuration.
4. Run `tofu init` to initialize the Terraform (Replaced by OpenTofu) environment.
5. Run `tofu apply` to create the server.
6. Once the server is created, run `ansible-playbook -i inventory/hosts web.yml` to configure it with Ansible.

## Adding Inventory/Hosts for Ansible

To add inventory/hosts for Ansible to work, follow these steps:

1. Open the `inventory/hosts` file in a text editor.
2. Add the IP address or hostname of the server under the appropriate group.
3. Save the file.

Now you can use Ansible to manage and configure the server using the added inventory/hosts.
