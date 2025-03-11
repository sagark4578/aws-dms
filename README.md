# AWS Database Migration Service (DMS) with Terraform

## 🚀 Overview
This repository contains Terraform scripts for setting up **AWS Database Migration Service (DMS)** to migrate databases efficiently. DMS helps in migrating data from various database engines while ensuring minimal downtime.

## 🛠️ Tech Stack
- **AWS DMS** – Database Migration
- **Terraform** – Infrastructure as Code
- **IAM Roles & Policies** – Secure Access

---

## 📌 Features
- **Automated DMS Setup** using Terraform
- **Source and Target Database Endpoints**
- **Replication Instance Creation**
- **Continuous Data Replication (CDC)**
- **Secure IAM Role Configuration**

---

## ⚙️ Setup Instructions

### 1️⃣ Clone the Repository
```sh
git clone https://github.com/your-username/aws-dms.git
cd aws-dms
2️⃣ Configure AWS Credentials
Ensure that AWS CLI is configured with the necessary permissions:

sh
Copy
Edit
aws configure
3️⃣ Initialize Terraform
sh
Copy
Edit
terraform init
4️⃣ Apply Terraform Configuration
sh
Copy
Edit
terraform apply -auto-approve
📌 Terraform Configuration
1️⃣ AWS DMS Setup
Create a Replication Instance
hcl
Copy
Edit
resource "aws_dms_replication_instance" "dms_instance" {
  replication_instance_id   = "my-dms-instance"
  replication_instance_class = "dms.t3.medium"
  allocated_storage         = 100
  engine_version            = "3.4.5"
  multi_az                  = true
}
Configure Source and Target Endpoints
h
Copy
Edit
resource "aws_dms_endpoint" "source_db" {
  endpoint_id   = "source-mysql"
  endpoint_type = "source"
  engine_name   = "mysql"
  server_name   = "source-db.example.com"
  port          = 3306
}

resource "aws_dms_endpoint" "target_db" {
  endpoint_id   = "target-postgres"
  endpoint_type = "target"
  engine_name   = "postgres"
  server_name   = "target-db.example.com"
  port          = 5432
}
Define the Migration Task
hcl
Copy
Edit
resource "aws_dms_replication_task" "migration_task" {
  replication_task_id   = "mysql-to-postgres"
  migration_type        = "full-load-and-cdc"
}
✅ Verification
Check AWS DMS Migration Status
sh
Copy
Edit
aws dms describe-replication-tasks
🤝 Contribution Guidelines
Fork the Repository
Create Your Own Branch
sh
Copy
Edit
git checkout -b feature-branch
Commit Changes & Push
sh
Copy
Edit
git commit -m "Added new feature"
git push origin feature-branch
Submit a Pull Request 🚀
