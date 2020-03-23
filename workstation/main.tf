provider "aws" {} # use default env for aws-cli

resource "aws_instance" "workstation" {
    name                   = "workstation"
    description            = "Windows workstation"
    ami                    = vars.ami_id
    instance_type          = vars.instance_type}"
    monitoring             = vars.monitoring
    vpc_security_group_ids = vars.security_groups
    key_name               = vars.keypair    
    tags                   = vars.aws_labels
    region                 = vars.region
    subnet_id              = vars.subnet_id
    root_block_device { 
      delete_on_termination = false
    }
}
