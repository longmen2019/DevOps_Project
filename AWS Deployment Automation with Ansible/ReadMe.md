```
# AWS Infrastructure Deployment with Ansible

This repository contains Ansible playbooks and roles for provisioning and configuring a basic web application infrastructure on AWS.

## Infrastructure Overview

The infrastructure includes:

- **VPC:** A dedicated Virtual Private Cloud for the application.
- **Subnets:** Public and private subnets for different tiers of the application.
- **Security Groups:** Configured for secure access to application instances.
- **EC2 Instances:** Instances for frontend and backend components.

## Prerequisites

- **AWS Account:** An active AWS account with necessary permissions.
- **Ansible:** Installed on your local machine.
- **Python and Boto3:** Install Python and the Boto3 library for AWS interactions.

## Installation

1. Install Ansible and required packages:
   ```
   sudo apt install ansible -y
   sudo apt install python3-pip -y
   sudo pip3 install boto boto3
   sudo apt update
   sudo apt install python3-boto python3-boto3
   ```

2. Configure AWS credentials:
   ```
   aws configure
   ```

## Usage

1. **Create an EC2 Key Pair:**
   - Create a YAML file named `create_keypair.yaml` with the following content:
     ```yaml
     ---
     - hosts: localhost
       tasks:
         - name: Create EC2 Key Pair
           ec2_key:
             name: my-ansible-keypair
             key_material: "{{ lookup('file', '~/.ssh/id_rsa.pub') }}"
             region: us-east-1
           register: keypair_result

         - debug: var=keypair_result
     ```
   - Run the playbook:
     ```
     ansible-playbook create_keypair.yaml
     ```
   - Change the permissions of the generated key pair file:
     ```
     chmod 400 my-ansible-keypair.pem
     ```

2. **Define Inventory and VPC Configuration:**
   - Create an inventory file named `inventory.yaml`:
     ```yaml
     ---
     all:
       hosts:
         webserver:
           hosts:
             backend:
               ansible_host: <Public IP of Backend Instance>
             frontend:
               ansible_host: <Public IP of Frontend Instance>
       vars:
         ansible_user: ubuntu
         ansible_ssh_private_key_file: deployment/ansible-key.pem

     ```
   - Create a VPC configuration file named `vpc.yaml` (see `roles/vpc/tasks/main.yaml` for an example).

3. **Deploy the Infrastructure:**
   - Navigate to the `infra` directory.
   - Run the playbook:
     ```
     ansible-playbook -i inventory.yaml playbook.yaml
     ```

## Directory Structure

```
├── roles
│   ├── frontend
│   │   └── tasks
│   │       └── main.yaml
│   └── backend
│       └── tasks
│           └── main.yaml
└── infra
    └── roles
        └── vpc
            └── tasks
                └── main.yaml

```

## Contributing

Contributions are welcome! Please open an issue or submit a pull request.

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.
```

**Note:** This is a basic example, and you may need to modify it based on your specific requirements. Ensure to replace placeholders like `<Public IP of Backend Instance>` with actual values.
