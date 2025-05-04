# 🚀 Terraform Scheduled Auto Scaling on AWS

This project provisions an Auto Scaling Group (ASG) with scheduled scaling actions using Terraform, ideal for environments with predictable traffic patterns.

## 📌 Features

- Creates a launch template with a basic EC2 config
- Defines an Auto Scaling Group (ASG)
- Adds scheduled actions to scale:
  - 🕗 **Up** to 4 instances at 08:00 UTC
  - 🕗 **Down** to 1 instance at 20:00 UTC

## 🧰 Prerequisites

- AWS Account
- Terraform installed (`>= 1.3.0`)
- Configured AWS CLI credentials

## 📂 Usage

1. Clone the repo:
   ```bash
   git clone https://github.com/Varshithsaipeddi/Terraform.git
   cd terraform-scheduled-scaling
   ```

2. Initialize Terraform:
   ```bash
   terraform init
   ```

3. Apply the configuration:
   ```bash
   terraform apply -auto-approve
   ```

4. Destroy resources:
   ```bash
   terraform destroy
   ```

## 📝 Notes

- Times are in **UTC**.
- Update the `vpc_id` and `subnet_ids` in `variables.tf` or pass via CLI.
- EC2 instances use Amazon Linux 2 AMI by default.
