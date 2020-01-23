<h3>Requirement:</h3>

 Your local host: Terraform, Ansible


<b>To run this Terraform please go to terraform/dev/</b>

Enter the aws_access_key and aws_secret_key in main.tf

Run these commands:

export ANSIBLE_HOST_KEY_CHECKING=False

sudo chmod 600 ../ap_southeast_1_key_pair

terraform init

terraform plan -out terraform

terraform apply terraform

-----------------------------------------------------------
Then you access to the public ip of EC2 instance by port 80

Run this command to get the public ip: terraform show | grep public_ip | sed -n 2p | awk '{gsub("\\"","");print $3}'


You can access to EC2 instance with username: ec2-user

I used docker to deploy the environment to run my source code. So I have included the python_docker_image directory, there is Dockerfile and CMD script for docker image.

In the EC2 instance, I have mount ~/app/logs to /var/log/app, as you can see in the docker-compose.yml file. So you can read the log file in ~/app/logs to view the logging. 

