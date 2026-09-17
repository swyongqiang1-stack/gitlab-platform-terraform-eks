## Project Goal

This project builds a GitLab platform on AWS EKS using Terraform and Helm.

The goal is not only to deploy GitLab, but to explore how a real DevOps platform can be designed around:

- Kubernetes workload architecture
- AWS managed services
- Infrastructure as Code
- Identity and access management
- CI/CD workloads
- Observability
- Reliability engineering
- Backup and disaster recovery
- Cloud cost optimization


## Architecture

```text
                           Internet
                              │
                           Route53
                              │
                             ALB
                              │
                  AWS Load Balancer Controller
                              │
                  ┌───────────┴───────────┐
                  │                       │
          GitLab Webservice         GitLab Registry
                  │
          ┌───────┴────────┐
          │                │
       Sidekiq        GitLab Runner
                          │
                    Kubernetes Executor
                          │
                    Dynamic CI Job Pods

          ┌───────────────────────────────┐
          │                               │
   RDS PostgreSQL                 ElastiCache Redis
          │
          │
          └───────────────┐
                          │
               GitLab Object Storage
                          │
                          ▼
                          S3
```

## AWS Infrastructure

```text
AWS
│
├── VPC
│   ├── Public Subnets
│   └── Private Subnets
│
├── EKS
│   ├── GitLab
│   ├── GitLab Runner
│   ├── Monitoring
│   └── Controllers
│
├── RDS PostgreSQL
├── ElastiCache Redis
├── S3
├── ALB
├── Route53
├── Secrets Manager
├── IAM / IRSA
└── CloudWatch
```
