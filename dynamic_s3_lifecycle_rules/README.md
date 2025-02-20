# S3 Bucket Lifecycle Configuration for Specific directories

## Overview

This Terraform configuration defines an S3 bucket lifecycle policy that applies different rules to specific directories within the bucket.

The configuration creates rules for managing the lifecycle of objects in the **Backup dir** and **Logs dir**.

## Rules Implemented

### 1. **Backup dir (`backup/`)**

- Objects are stored in the **STANDARD** storage class for **30 days**.
- After **30 days**, objects transition to **STANDARD_IA**.
- After moving to **STANDARD_IA** it gets deleted after **30 days**, objects are **deleted**.

### 2. **Logs dir (`logs/`)**

- Objects are **deleted** after **30 days**.
- No transition to a different storage class for objects in the Logs dir.

## Modify the rules

You can modify the lifecycle policies to fit your specific requirements by adjusting the configuration values.

### 1. **Modify Prefix**

To apply lifecycle policies to different dir within the S3 bucket, change the `prefix` in the rule block. For example, if you want to target the `archive/` dir instead of `backup/`, change the `prefix` to `archive/`
