# AWS-2-Tier-Application-full-structure

## Overview

This repository contains Terraform code for deploying a highly available and secure 2-tier application infrastructure on AWS. The infrastructure includes a variety of AWS services, such as VPC, subnets, EC2 instances, RDS, and more. The project follows best practices for security, including the principle of least privilege for IAM roles.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Architecture](#architecture)
- [Resources](#resources)
- [Setup](#setup)
- [Usage](#usage)
- [Architecture Diagram](#architecture-diagram)

## Prerequisites

Before you begin, ensure you have the following installed:

- [Terraform](https://www.terraform.io/downloads.html) 
- AWS CLI configured with appropriate credentials
- An AWS account with sufficient permissions to create resources

## Architecture

The project sets up a 2-tier application with the following components:

1. **Network Layer**
   - VPC
   - Public and Private Subnets
   - Internet Gateway
   - NAT Gateway
   - VPC Endpoint
2. **Compute Layer**
   - EC2 Instances
   - Auto Scaling Group
   - Load Balancer
3. **Database Layer**
   - RDS with Secret
4. **Security**
   - Security Groups
   - Web Application Firewall (WAF)
   - IAM Roles
5. **Monitoring and Logging**
   - CloudWatch
   - CloudWatch Agent
   - CloudTrail with S3
6. **State Management**
   - Remote Backend

## Resources

### Network

- **VPC**: A Virtual Private Cloud to host all resources.
- **Subnets**: Public and Private subnets across multiple Availability Zones for high availability.
- **Internet Gateway**: To allow internet access to instances in public subnets.
- **NAT Gateway**: To allow instances in private subnets to access the internet securely.
- **VPC Endpoint**: For secure and scalable communication between VPC and AWS services.

### Compute

- **EC2 Instances**: Virtual servers to host your application.
- **Auto Scaling Group**: To ensure the application scales with demand.
- **Load Balancer**: Distributes incoming application traffic across multiple instances.

### Database

- **RDS**: Managed relational database service with secrets stored securely.

### Security

- **Security Groups**: Fine-grained control over inbound and outbound traffic to resources.
- **WAF**: Protects the application from common web exploits.
- **IAM Roles**: With the principle of least privilege applied.

### Monitoring and Logging

- **CloudWatch**: For monitoring performance and logging.
- **CloudWatch Agent**: Collects additional metrics and logs.
- **CloudTrail**: For governance, compliance, and operational auditing, with logs stored in S3.

### State Management

- **Remote Backend**: To store Terraform state files securely.

## Setup

1. **Clone the repository**

   ```sh
   git clone https://github.com/Mariamkassab/AWS-2-Tier-Application-full-structure.git
   cd AWS-2-Tier-Application-full-structure

2. **Review the provider configuration**

    Ensure the provider.tf file is correctly configured with your AWS provider settings. Update it if necessary to match your AWS credentials and region.

3. **Initialize Terraform**

   ```sh
   terraform init

4. **Review and modify variables**
   
     Review the variables.tf file and update values as needed. You can also create a terraform.tfvars file to set your variables.

5. **Plan the deployment**
    ```sh
    terraform plan

6. **terraform apply**
   ```sh
   terraform apply

## Usage

  Once the infrastructure is deployed, you can access the application via the Load Balancer's DNS name. The Auto Scaling Group ensures that your application scales automatically based on the defined policies. Use CloudWatch for monitoring performance and logs, and review CloudTrail logs in S3 for audit purposes.

---

## Architecture Diagram

Below is the architecture diagram for the application setup:

  

![Blank diagram - Page 1](https://github.com/Mariamkassab/AWS-2-Tier-Application-full-structure/assets/123699968/59d1b18f-7576-47fe-b330-1390ed30b1e1)
