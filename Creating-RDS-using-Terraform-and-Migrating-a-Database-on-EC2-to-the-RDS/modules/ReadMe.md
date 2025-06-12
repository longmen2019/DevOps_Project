
# Creating RDS using Terraform and Migrating a Database on EC2 to the RDS

## Prerequisites
Before you start, ensure the following software is installed:
1. **Terraform** - Infrastructure as Code tool.
2. **AWS CLI** - Command Line Interface to interact with AWS.

## Steps
Follow these steps to create the RDS instance and migrate your database:

### 1. Create an EC2 Instance and Security Group
- Set up an EC2 instance to access via SSH.
- Define a security group to manage SSH access.

### 2. Create a Secret Manager Module
- Use Terraform to create a module for AWS Secrets Manager to securely store your database password.

### 3. Create an RDS Module
- Utilize Terraform to define and create the RDS instance.

### 4. Apply Changes
- Run `terraform apply` to implement the changes and provision resources.

### 5. Install MySQL on the EC2 Instance
Follow these commands for Amazon Linux 2023:
```bash
sudo wget https://dev.mysql.com/get/mysql80-community-release-el9-1.noarch.rpm 
sudo rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2023
sudo dnf install mysql80-community-release-el9-1.noarch.rpm
dnf repolist enabled | grep "mysql.*-community.*"
sudo dnf install mysql-community-server
sudo systemctl start mysqld
```

### 6. Create a Database on EC2
- Access MySQL on the EC2 instance.
- Create a database and populate it with tables.

### 7. Migrate the Database to RDS
Use the following commands:
```bash
mysqldump -u root -p ec2db > db.sql 
mysql -u admin -P 3306 -p mydatabase < db.sql
```

## Notes
- Ensure the RDS instance is properly configured to accept connections.
- Replace sensitive information like passwords (`plkfP<r#j8Vl`, `Admin@123`) with secure environment variables or AWS Secrets Manager.

By following these instructions, you will have successfully set up an RDS instance and migrated a database from EC2 to RDS.
