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

git clone https://github.com/sagark4578/aws-dms.git
cd aws-dms

2️⃣ Configure AWS Credentials
Ensure that AWS CLI is configured with the necessary permissions:


aws configure

3️⃣ Initialize Terraform

terraform init
4️⃣ Apply Terraform Configuration

terraform apply -auto-approve

📌 Terraform Configuration
1️⃣ AWS DMS Setup
Create a Replication Instance


Check AWS DMS Migration Status

aws dms describe-replication-tasks

🤝 Contribution Guidelines
Fork the Repository
Create Your Own Branch

git checkout -b feature-branch

Commit Changes & Push

git commit -m "Added new feature"

git push origin feature-branch

Submit a Pull Request 🚀
