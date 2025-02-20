# S3 Bucket Lifecycle Configuration for Specific Folders

## Overview

This Terraform configuration defines an S3 bucket lifecycle policy that applies different rules to specific folders within the bucket.

The configuration creates rules for managing the lifecycle of objects in the **Backup Folder** and **Logs Folder**.

## Rules Implemented

### 1. **Backup Folder (`backup/`)**

- Objects are stored in the **STANDARD** storage class for **30 days**.
- After **30 days**, objects transition to **STANDARD_IA**.
- After moving to **STANDARD_IA** it gets deleted after **30 days**, objects are **deleted**.

### 2. **Logs Folder (`logs/`)**

- Objects are **deleted** after **30 days**.
- No transition to a different storage class for objects in the Logs folder.

## Modify the rules

You can modify the lifecycle policies to fit your specific requirements by adjusting the configuration values.

### 1. **Modify Prefix**

To apply lifecycle policies to different folders within the S3 bucket, change the `prefix` in the rule block. For example, if you want to target the `archive/` folder instead of `backup/`, change the `prefix` to `archive/`
