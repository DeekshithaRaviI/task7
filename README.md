## Deployment Details

This project deploys a **Strapi application** on **AWS ECS Fargate** using **Terraform**.

- **Infrastructure:** Terraform manages ECS Cluster, Service, ALB, RDS PostgreSQL, and IAM roles.
- **Container:** Docker image is built and pushed to AWS ECR.
- **CI/CD:** GitHub Actions workflow automates image build, ECR push, and ECS task definition update.

**Terraform Outputs:**
- ALB DNS: deek-strapi-ecs-alb-1766048261.ap-south-1.elb.amazonaws.com
- Strapi Admin: http://deek-strapi-ecs-alb-1766048261.ap-south-1.elb.amazonaws.com/admin
- ECS Cluster: deek-strapi-ecs-cluster
- ECS Service: deek-strapi-service

**Deployment Steps:**
1. `terraform init`
2. `terraform apply`
3. Docker image is pushed via GitHub Actions.
4. ECS service is updated automatically using the new image.
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/74f0f948-7601-4956-84e5-63d085fb187b" />
