provider "aws" {
  region = var.aws_region
}

resource "aws_launch_template" "web_lt" {
  name_prefix   = "scheduled-web-lt"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_autoscaling_group" "web_asg" {
  name                      = "scheduled-web-asg"
  max_size                  = 6
  min_size                  = 1
  desired_capacity          = 1
  vpc_zone_identifier       = var.subnet_ids
  launch_template {
    id      = aws_launch_template.web_lt.id
    version = "$Latest"
  }
  health_check_type         = "EC2"
  force_delete              = true
  wait_for_capacity_timeout = "0"
  tag {
    key                 = "Name"
    value               = "scheduled-web-instance"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_schedule" "scale_up" {
  scheduled_action_name  = "scale-up-morning"
  autoscaling_group_name = aws_autoscaling_group.web_asg.name
  desired_capacity       = 4
  recurrence             = "0 8 * * *"
}

resource "aws_autoscaling_schedule" "scale_down" {
  scheduled_action_name  = "scale-down-evening"
  autoscaling_group_name = aws_autoscaling_group.web_asg.name
  desired_capacity       = 1
  recurrence             = "0 20 * * *"
}
