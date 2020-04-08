Synopsis: Deploys the needed infrastructure for an ECS solution via AWS ECS CLI v2. This includes the VPC, 2 public and 2 private subnets split over 2 AZ, an ELB, ECR and an ECS deployment of a loadbalanced webapp (see https://github.com/aws/amazon-ecs-cli-v2)

How To Use:
    -   Link CircleCI pipeline to repo (https://circleci.com/docs/2.0/getting-started/)
    -   The pipeline requires 3 environment variables to be set manually: (https://circleci.com/docs/2.0/ecs-ecr/)
        . AWS_ACCESS_KEY_ID
        . AWS_SECRET_ACCESS_KEY
        . AWS_DEFAULT_REGION
    -   The pipeline has just one workflow, to deploy the needed infrastructure.

Limitations:
    -   The name of the ECS deployment is hardcoaded as 'superawesome_helloworld'. So if the pipeline has already run before and built this already, an error will be thrown. To clear the deployment do the following locally (with the relevent env vars set as mentioned above):
        .   'ecs-preview project init'
        .   Select the existing project ('superawesome_helloworld') from the list of named projects.
        .   Continue with the local project creation process (this won't impact the depolyment in AWS).
        .   'ecs-preview project delete'
    -   The URL to reach the deployment is the final line of the pipeline's logs, however the $AWS_DEFAULT_REGION has been masked in the URL (a default feature of CircleCI due to the fact it is an env var). Simply replace the missing characters with the region code and the URL should work fine.
    -   Currently only HTTP (insecure).