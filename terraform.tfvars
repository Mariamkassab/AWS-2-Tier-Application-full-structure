#aws region
aws-region = "us-east-1" #eu-west-1

# vpc & internet gatway
vpc_cidr = "10.0.0.0/16"
vpc_name = "terraform vpc"
gw_name  = "terraform internet gateway"

# subnets
subnet_cidr    = ["10.0.0.0/24", "10.0.2.0/24", "10.0.1.0/24", "10.0.3.0/24"]
az             = ["us-east-1a", "us-east-1a", "us-east-1b", "us-east-1b"] #["eu-west-1a", "eu-west-1a", "eu-west-1b", "eu-west-1b"]
subnet_name    = ["pub_sub1_az1", "private_sub1_az1", "private_sub2_az2", "pub_sub2_az2"]

# nat
nat_name         = "nat_gateway"

# ec2 security group
ec2-ssh-cidr = ["10.0.2.0/24", "10.0.1.0/24"] 
ec2-rds-cidr = ["10.0.1.0/24", "10.0.2.0/24"]

#lb ce\security group
lb-ec2-cidr = ["10.0.2.0/24" , "10.0.1.0/24"]

# route tables 
pub-wanted-cidr = "0.0.0.0/0"
pub-table-name = "public_rt"

pri-wanted-cidr = "0.0.0.0/0"
pri-table-name = "private_rt"

# loadbalancer
lb_name = "public-lb"
internal_or = false
lb_type = "application"
lb_env = "dev_pub_lb"
tg_name = "public-tg"
tg_port = 80
tg_protocol = "HTTP"
default_action_type = "forward" 

#auto scaling group
lanch-temp-name = "lanch-temp"
name-prefix = "AXIR-group"
image-id = "ami-053b0d53c279acc90"
ec2-type = "t2.micro"
key-name = "ec2-key"
user-data = "./modules/userdata.tpl" 
asg-name = "ASG"
max-size = 3
min-size = 1
grace-period = 300
desired-no = 1
ec2-name = "axir-project"

#mysql-rds
engine-name = "mysql"
db-name = "my-rds"
storage = 5
max_allocated_storage-autoscalling = 10
engine-v = "5.7" # the new verion 
instance-type = "db.t2.micro"
user = "myrdsuser"
pass = "myrdspassword"
skip-final-db-snapshot = true  #should be false
monitoring_interval = 30
maintenance_window = "Mon:00:00-Mon:03:00"
backup_window = "03:00-06:00"
backup_retention_period = 0

