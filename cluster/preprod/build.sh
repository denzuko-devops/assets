#!/bin/bash
ENVIRONMENT=${ENVIRONMENT:-"stage"}
MAXWORKERS=${MAXWORKERS:-"3"}

alias swarm="docker swarm"
alias machine="docker-machine"
alias compose="docker service deploy --docker-compose"

dmcreate() {
  machine create --engine-storage-driver overlay 2 -d generic $@
}

#vpc=$(aws ec2 create-vpc --cidr-block 10.0.0.0/16 | jq -r ".[].VpcId")
#aws ec2 create-subnet --vpc-id $vpc --cidr-block 10.0.0.0/24
#aws ec2 create-subnet --vpc-id $vpc --cidr-block 10.0.1.0/24
#igateway=$(aws ec2 create-internet-gateway --vpc-id $vpc | jq -r ".[].InternetGatewayId")
#ngateway=$(aws ec2 create-nat-gateway --vpc-id $vpc | jq -r ".[].NatGatewayId")
#iroute=$(aws ec2 create-route-table --vpc-id $vpc | jq -r ".[].RouteTableId")
#aws ec2 create-route --route-table-id $iroute --destination-ipv4-cidr-block 0.0.0.0/0 --gateway-id $igateway
#aws ec2 security group ...

dmcreate ${ENVIRONMENT}.master

for x in `seq 1 ${MAXWORKERS}`; do
  dmcreate ${ENVIRONMENT}.worker-$x
done

eval $(docker-machine env ${ENVIRONMENT}.master)
MASTER=$(docker-machine ip active)

swarm init --advertise-addr $MASTER --listen-addr $MASTER
worker_token=$(swarm join-token worker -q)

for x in `seq 1 ${MAXWORKERS}`; do
  eval $(machine env ${ENVIRONMENT}.worker-$x)
  RHOST=$(machine ip active)
  swarm join --advertise-addr $RHOST --listen-addr $RHOST --token ${worker_token} $MASTER
done

compose services.yml
