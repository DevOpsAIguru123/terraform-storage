# terraform-storage


# AI Platform Documentation

## Overview
Welcome to the AI Platform Documentation. This platform is built on a complex Azure Hub-and-Spoke network architecture, consisting of multiple interconnected Azure resources. The platform enables the deployment and management of multiple Databricks workspaces, unified through shared services such as centralized storage, secret management, monitoring, and workspace governance.

## Network Architecture

### Hub-and-Spoke Topology
The platform's network architecture follows the Azure Hub-and-Spoke model:

- **Hub VNet**: This central hub contains an **Azure Firewall** that manages and secures outbound and inbound traffic for all connected spoke virtual networks (VNets).
- **Spoke VNet**: The spoke VNet hosts multiple subnets that each serve a specific purpose within the AI platform. The spoke subnets are:
  1. **Databricks Control Plane Subnet**: This subnet handles the communication between the Databricks workspaces and Azure services.
  2. **Databricks Data Plane Subnet**: Dedicated to the execution of Databricks workloads, including running clusters.
  3. **Azure OpenAI Private Endpoints Subnet**: This subnet hosts private endpoints used for secure communication with the Azure OpenAI services.

## Databricks Environment Setup

### Workspaces and Metastore Configuration
After the network setup, four **Databricks Workspaces** were deployed. These workspaces are configured and governed centrally:

1. **Workspace Assignment to Metastore**: Each workspace is connected to a centralized Databricks **metastore** to ensure consistent management of metadata, including tables, views, and permissions across all environments.

2. **Storage Accounts**: A dedicated **Azure Data Lake Storage (ADLS)** account is created for each environment (Development, Test, Stage, and Production). These storage accounts store raw and processed data and are governed through catalogs in the metastore.

### Databricks Environments
- **Catalogs for Environments**: Separate **catalogs** are created in Databricks for each environment (Development, Test, Stage, and Production), allowing for isolation and permission management specific to each workspace.

## Cluster Management and Governance

- **Cluster and Cluster Policies**: Clusters in each workspace are governed by a set of pre-defined **cluster policies** that enforce security, scalability, and cost control. These policies are managed through a **dedicated repository** where updates and policy changes are versioned.
  
- **Tags**: All Databricks clusters are tagged to enable cost tracking and identification by environment, owner, and purpose.

- **Workspace Object Permissions**: Permissions for workspace objects such as notebooks, data tables, and jobs are also controlled and managed through repositories, ensuring consistent governance across environments.

## Resource Management Repositories

The platform’s resources are managed through different repositories to ensure a modular approach:

- **ADLS Resources**: All Azure Data Lake Storage resources, including storage account configurations, permissions, and lifecycle management, are handled in a dedicated repository.

- **Databricks Workspaces and Object Permissions**: A separate repository is used to manage the deployment and configuration of Databricks clusters, workspace object permissions, cluster policies, and any related configurations.

## Centralized Secret Management

- A central **Azure Key Vault** is used to manage and store sensitive information such as:
  - Secrets for **App Registrations**
  - **Terraform** authentication credentials
  - **Database connection strings** and secrets
  - Any other application secrets used by the platform

Access to the key vault is tightly controlled and restricted by role-based access control (RBAC) policies.

## Monitoring and Usage Insights

- **Databricks Monitoring Repository**: A separate repository is dedicated to monitoring the health and performance of Databricks workspaces. This repository handles the creation and deployment of monitoring dashboards, which provide **usage insights**, cluster performance metrics, and cost reporting across environments.

The monitoring system helps platform administrators track resource utilization, identify potential issues, and optimize the use of Databricks resources.

---

This documentation summarizes the core components and best practices used in building and maintaining the AI platform on Azure. By adhering to this structure, the platform ensures scalability, security, and centralized governance across its multiple environments and workspaces.