***# Strapi ECS Fargate Deployment***



***Automated deployment of Strapi CMS on AWS ECS Fargate using Terraform and GitHub Actions.***



***## Architecture***



***- \*\*Compute\*\*: AWS ECS Fargate***

***- \*\*Database\*\*: Amazon RDS PostgreSQL***  

***- \*\*Load Balancer\*\*: Application Load Balancer***

***- \*\*Container Registry\*\*: Amazon ECR***

***- \*\*IaC\*\*: Terraform***

***- \*\*CI/CD\*\*: GitHub Actions***



***## Prerequisites***



***- AWS Account with IAM credentials***

***- Terraform >= 1.0***

***- Docker Desktop***

***- AWS CLI configured***

***- GitHub account***



***## Setup Instructions***



***### 1. Clone and Setup***

***```bash***

***git clone <your-repo-url>***

***cd strapi-ecs-fargate***

***```***



***### 2. Configure AWS Credentials in GitHub***

***Go to: Repository → Settings → Secrets → Actions***

***Add:***

***- `AWS\_ACCESS\_KEY\_ID`***

***- `AWS\_SECRET\_ACCESS\_KEY`***



***### 3. Update Terraform Variables***

***Edit `terraform/terraform.tfvars` and change the database password.***



***### 4. Deploy Infrastructure***

***```bash***

***cd terraform***

***terraform init***

***terraform plan***

***terraform apply***

***```***



***### 5. Build and Push Initial Image***

***```bash***

***# Get ECR URL***

***ECR\_REPO=$(cd terraform \&\& terraform output -raw ecr\_repository\_url)***



***# Login to ECR***

***aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $ECR\_REPO***



***# Build and push***

***docker build -t strapi-app .***

***docker tag strapi-app:latest $ECR\_REPO:latest***

***docker push $ECR\_REPO:latest***

***```***



***### 6. Access Application***

***```bash***

***cd terraform***

***terraform output alb\_dns\_name***

***```***



***Access Strapi at: `http://<ALB-DNS>/admin`***



***## CI/CD Pipeline***



***Every push to `main` branch triggers:***

***1. Docker image build with tagging (latest, SHA)***

***2. Push to Amazon ECR***

***3. Update ECS task definition***

***4. Deploy new revision to ECS Fargate***



***## Project Structure***

***```***

***strapi-ecs-fargate/***

***├── .github/***

***│   └── workflows/***

***│       └── deploy.yml       # GitHub Actions workflow***

***├── terraform/***

***│   ├── main.tf             # Main Terraform config***

***│   ├── variables.tf        # Variable definitions***

***│   ├── terraform.tfvars    # Variable values (gitignored)***

***│   ├── network.tf          # VPC, subnets, networking***

***│   ├── security.tf         # Security groups***

***│   ├── ecs.tf              # ECS cluster, service, tasks***

***│   └── outputs.tf          # Terraform outputs***

***├── Dockerfile              # Container definition***

***├── package.json            # Node.js dependencies***

***└── README.md              # This file***

***```***



***## Monitoring***



***View logs:***

***```bash***

***aws logs tail /ecs/strapi-ecs --follow --region us-east-1***

***```***



***## Cleanup***

***```bash***

***cd terraform***

***terraform destroy***

***```***



***## Cost Estimate***

***- ECS Fargate: ~$15/month***

***- RDS t3.micro: ~$15/month***  

***- ALB: ~$20/month***

***- \*\*Total\*\*: ~$50/month (with light usage)***

