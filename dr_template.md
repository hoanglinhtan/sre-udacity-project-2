# Infrastructure

## AWS Zones
AWS us-east-2: us-east-2a, us-east-2b, us-east-2c
AWS us-wesst-1: us-west-1b, us-west-1c

## Servers and Clusters

### Table 1.1 Summary
| Asset      | Purpose           | Size                                                                   | Qty                                                             | DR                                                                                                           |
|------------|-------------------|------------------------------------------------------------------------|-----------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------|
| Web server | Running Flask applications | t3.micro | 3 instances | Deployed to 2 regions |
| Load balancer | Balance request to given web server | | 2 instance | Deployed to 2 regions |
| K8s cluster | Running Prometheus stack for monitoring | t3.medium | 1 cluster (2 instances) | Deployed to 2 regions |
| VPC | Host cloud infastructure | | 1 VPC | Deployed to 2 regions |
| RDS | Application database | db.t3.micro | 1 cluster (2 instances) | Deployed replication to 2 regions |


### Descriptions
- Web servers (EC2 instances) host 'Ubuntu-Web' which is an HTTP web server. There are 3 instances in each AWS region for HA purposes.
- K8s cluster (EKS Kubernetes cluster) which hosts the kube-prometheus-stack for monitoring. Blackbox exporter is used to probe endpoints. There are 2 nodes per cluster in each AWS region for HA purposes.
- VPC: One virtual network is available in each AWS region, with additional redundancy being provided by multiple availability zones.
- Load balancer (ALB): Application load balancer listening on port 80 (HTTP) for the 3 backend EC2 instances. This allows traffic to be distributed across the instances for HA purposes and better performance. A single ALB is available in each AWS region.
- RDS: Managed relational database cluster deployed across both AWS regions, with additional redundancy being provided by availability zones. Backups are set to 5 days and replication is enabled between the primary and secondary region clusters.

## DR Plan
### Pre-Steps:
- Check IaC to confirm that the terraform code is available.
- Confirm that aws_ami is available in the secondary region.
- Prepare a backend DR S3 bucket in the secondary region.
- Check that aws_ami and S3 bucket have been defined.
- From your secondary region directory ./zone2 run terraform apply and follow the prompts to deploy your secondary region resources.
- Check health of RDS cluster and resources in AWS portal.

## Steps:
- ### Manual failover of RDS cluster
    + Login to AWS portal
    + Open RDS Management Console (RDS)
    + Click 'Databases'
    + Choose correct region
    + Select 'Writer Instance'
    + Select 'Actions/Failover' 
    + Click 'Failover'
    + Refresh databases page until reader/writer instances change
- ### Failover of application to secondary region.
    + Configure the AWS Route 53 DNS service to provide a DNS name which can point to the load balancers within both regions.
    + Point your DNS to the secondary region.
    + Manually failover the RDS cluster as above.
    + Automatically failover the RDS cluster by health checks.