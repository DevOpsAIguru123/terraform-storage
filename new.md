Sure! Below is the complete markdown file, including references to four additional repositories:

# Azure Hub-Spoke Network with Databricks and Unity Catalog Setup

## Overview

This repository contains the Terraform configurations for deploying a **complex network architecture** in Azure based on the **Hub-Spoke topology**. The architecture supports a secure, scalable infrastructure, with **Databricks workspaces** and **Azure Firewalls** for traffic control and **Unity Catalog** storage integration.

The key components of this infrastructure include:

- **Azure Hub-Spoke Network** with peerings
- **Azure Firewall** for managing traffic
- **Databricks Workspaces** in the Spoke VNet
- **Unity Catalog** storage for managing environments across Sandbox, Dev, Acceptance, and Production

The deployment is automated using **Terraform Enterprise** for state management and **GitHub Actions** for continuous integration and delivery (CI/CD).

## Architecture Overview

### Hub-Spoke Network

- **Hub VNet**: Manages shared resources and centralized traffic routing.
- **Spoke VNet**: Hosts Databricks workspaces and specific workloads with segregated subnets.
- **Peering**: Hub and Spoke VNets are peered to allow communication.

### VNet Configuration

| VNet Name   | Resource Group   | Subnets                                  |
| ----------- | ---------------- | ---------------------------------------- |
| Hub VNet    | `<Hub-RG-Name>`   | `FirewallSubnet`                         |
| Spoke VNet  | `<Spoke-RG-Name>` | `PublicSubnet`, `PrivateSubnet`, `OpenAISubnet` |

- **FirewallSubnet**: Deployed in the Hub VNet to control traffic.
- **PublicSubnet**, **PrivateSubnet**, and **OpenAISubnet**: Deployed in the Spoke VNet for respective workloads.

### Azure Firewall

- Deployed in the **FirewallSubnet** of the Hub VNet.
- Controls **inbound** and **outbound** traffic based on rules defined in the Terraform configurations.

### Databricks Workspaces

- 4 Databricks workspaces are deployed in the **Spoke VNet**.
- Each workspace is associated with different environments.

| Databricks Workspace Name   | URL                                           |
| --------------------------- | --------------------------------------------- |
| `<Databricks-Workspace-1>`   | `https://<workspace1>.azuredatabricks.net`    |
| `<Databricks-Workspace-2>`   | `https://<workspace2>.azuredatabricks.net`    |
| `<Databricks-Workspace-3>`   | `https://<workspace3>.azuredatabricks.net`    |
| `<Databricks-Workspace-4>`   | `https://<workspace4>.azuredatabricks.net`    |

### Unity Catalog Storage

A single **Unity Catalog Storage Account** is created to manage data for Databricks Unity Catalogs. Each environment has its own storage container.

- **Storage Account Name**: `<Unity-Catalog-SA-Name>`

| Environment | Container Name       | External Location                 |
| ----------- | -------------------- | --------------------------------- |
| Sandbox     | `<sandbox-container>` | `<sandbox-external-location>`     |
| Dev         | `<dev-container>`     | `<dev-external-location>`         |
| Acceptance  | `<acceptance-container>`| `<acceptance-external-location>` |
| Prod        | `<prod-container>`    | `<prod-external-location>`        |

## CI/CD Pipeline

This repository leverages **GitHub Actions** for automated Terraform deployments. It includes workflows for validating, planning, and applying changes across different environments (Sandbox, Dev, Acceptance, Prod).

### GitHub Actions Workflows

- **GitHub Action Name**: `<GitHub-Action-Name>`
  - Runs the Terraform workflows for each environment.
  - Provides continuous integration and automated deployment pipelines for infrastructure changes.

### Terraform Workspaces

- Separate **Terraform workspaces** are used for each environment to isolate the state and manage infrastructure independently.
  
| Environment  | Terraform Workspace Name |
| ------------ | ------------------------ |
| Sandbox      | `<sandbox-workspace>`     |
| Dev          | `<dev-workspace>`         |
| Acceptance   | `<acceptance-workspace>`  |
| Prod         | `<prod-workspace>`        |

## Deployment Steps

1. **Clone the repository** to your local machine:
   ```bash
   git clone <repo-url>

	2.	Configure Azure Authentication:
	•	Ensure you have the required Azure credentials and access to the Resource Groups.
	3.	Run Terraform Init to initialize the backend:

terraform init


	4.	Run Terraform Plan to preview the infrastructure changes:

terraform plan -var-file=<env>.tfvars


	5.	Run Terraform Apply to deploy the infrastructure:

terraform apply -var-file=<env>.tfvars


	6.	Monitor the GitHub Actions pipeline for any deployments or changes triggered by commits to the repository.

Important Notes

	•	Ensure that you are using the correct Terraform workspace for each environment to avoid conflicts.
	•	The Firewall rules and VNet peering must be reviewed regularly for optimal performance and security.
	•	Unity Catalog storage should be managed carefully to maintain environment isolation.

Additional Repositories

This project is part of a broader platform that includes other related repositories for managing Databricks resources, permissions, and operational scripts. Please refer to the following repositories for more details:

	1.	Databricks Unity Catalog and Workspace Objects: This repository contains the Terraform configurations for creating Databricks Unity Catalog objects such as catalogs, schemas, and tables, as well as workspace-level objects like clusters, jobs, and notebooks.
	•	Databricks Unity Catalog Objects
	•	Databricks Workspace Objects
	2.	Databricks Permissions: This repository manages the permissions for Databricks workspaces, including adding users, defining cluster policies, setting up tags, and controlling access to clusters, Unity Catalogs, foreign catalogs, connections, external storage locations, and volume permissions.
	•	Databricks Permissions
	3.	Centralized Key Vault for Secrets Management: This repository contains the Terraform configurations for creating and managing a centralized Azure Key Vault to store and manage secrets related to the platform.
	•	Centralized Key Vault
	4.	Databricks Usage Alerts and Operational Scripts: This repository includes Terraform configurations and scripts for setting up Databricks usage alerts, monitoring dashboards, and other maintenance-related scripts such as usage tracking and cost optimization.
	•	Databricks Usage Alerts and Scripts

Resources

	•	Azure Virtual Networks: Azure VNet Documentation
	•	Azure Firewall: Azure Firewall Documentation
	•	Databricks: Azure Databricks Documentation
	•	Terraform Enterprise: Terraform Enterprise Documentation
	•	GitHub Actions: GitHub Actions Documentation

This README serves as an overview of the infrastructure design and automation process for deploying resources in Azure. Detailed code and configurations can be found within the respective Terraform files in this repository.

This markdown file provides an overview of your infrastructure setup, along with the links to the additional repositories for managing Databricks objects, permissions, Key Vault, and operational scripts. Replace the `<repo-url>` and other placeholder URLs with the actual repository URLs when using it in your project.

Let me know if you need further modifications!