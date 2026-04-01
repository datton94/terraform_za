
data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"] # Canonical
}


resource "aws_instance" "web" {
  connection {
    host        = self.public_ip
    user        = var.EC2_USER
    private_key = file(var.PRIVATE_KEY_PATH)
  }

  instance_type = var.instance_type

  # Specific AMI
  ami = data.aws_ami.amazon_linux.id

  # VPC
  subnet_id = aws_subnet.prod_subnet_public_1.id

  # Security Group
  vpc_security_group_ids = [aws_security_group.ssh_http_allowed.id]

  # the Public SSH key
  key_name = aws_key_pair.ap_southeast_1_key_pair.id

  iam_instance_profile = aws_iam_instance_profile.test_profile.name

  ebs_block_device {
    device_name           = "/dev/xvda"
    volume_size           = 16
    delete_on_termination = true
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir ~/app",
      "sudo yum -y update",
      "sudo yum -y install python3 python3-pip python-pip gcc",
      "sudo pip install docker && sudo pip install PyYAML && sudo pip install docker-compose && sudo pip install pexpect && pip3 install awscli --upgrade --user"
    ]
  }

  provisioner "local-exec" {
    command = "cd ../../ansible_playbooks/ && ansible-playbook -i ${self.public_ip}, --private-key ../terraform/ap_southeast_1_key_pair --extra-vars 'user=${var.EC2_USER} aws_access_key=${var.aws_access_key} aws_secret_key=${var.aws_secret_key} aws_ssm_db_password_name=${aws_ssm_parameter.mydb_password.name} db_name=${var.db_name} db_username=${var.db_username} db_connection=5432 db_address=${aws_db_instance.postgre.address}' web_proxy_setup.yml"
  }

  provisioner "remote-exec" {
    inline = [
      "cd ~/app/docker-compose && docker-compose up -d"
    ]
  }
}


resource "aws_key_pair" "ap_southeast_1_key_pair" {
  key_name   = "ap_southeast_1_key_pair"
  public_key = file(var.PUBLIC_KEY_PATH)
}


