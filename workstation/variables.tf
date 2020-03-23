
variable "keypair"        { default = "${env.AWS_KEYPAIR_NAME}"
variable "instance_type"   { default = "t2.micro" }
variable "security_groups" { default = "${env.AWS_SECURITY_GROUPS}" }
variable "monitoring"      { default = true }
variable "ami_id"          { default = "ami-fa05b392" }
variable "subnet_id"       { default = "${env.AWS_SUBNET}" }
variable "region"          { default = "${env.AWS_DEFAULT_REGION}" }
variable "aws_labels"      { default = {
      net.matrix.orgunit = "Matrix NOC",
      net.matrix.organization = "Private Ops",
      net.matrix.commonname = "cloud",
      net.matrix.locality = "Dallas",
      net.matrix.state = "Texas",
      net.matrix.country = "USA",
      net.matrix.environment = "${env.ENVIRONMENT}", # <nonprod|production|staging>
      net.matrix.application = "infrastructure",
      net.matrix.role = "application services",
      net.matrix.owner = "FC13F74B@matrix.net",
      net.matrix.customer = "PVT-01",
      net.matrix.costcenter = "INT-01"
  }
}
