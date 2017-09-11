#!/bin/bash
# build.sh - create a docker swarmmode cluster then deploy a service stack
# Copyright (c)2017 Dwight Spencer <dwightaspencer@gmail.com>, All Rights Reserved.

ENVIRONMENT=${ENVIRONMENT:-"stage"}
MAXWORKERS=${MAXWORKERS:-"5"}
MAXMASTERS=${MAXMASTERS:-"3"}
SERVICES=${SERVICES:-"services.yml"}

alias swarm="docker swarm"
alias machine="docker-machine"
alias compose="docker stack deploy --docker-compose"

dmcreate() {
  machine create --engine-storage-driver overlay 2 -d generic $@
}

connect() {
  local max=$1
  local name=$2
  local command=$3
  local token=$4
  local master=${5:-""}

  for x in `seq 1 ${max}`; do
    eval $(machine env ${ENVIRONMENT}.${name}-${x})
    RHOST=$(machine ip active)
    swarm ${command} --advertise-addr $RHOST --listen-addr $RHOST --token ${token} ${master}
  done
}

#vpc=$(aws ec2 create-vpc --cidr-block 10.0.0.0/16 | jq -r ".[].VpcId")
#aws ec2 create-subnet --vpc-id $vpc --cidr-block 10.0.0.0/24
#aws ec2 create-subnet --vpc-id $vpc --cidr-block 10.0.1.0/24
#igateway=$(aws ec2 create-internet-gateway --vpc-id $vpc | jq -r ".[].InternetGatewayId")
#ngateway=$(aws ec2 create-nat-gateway --vpc-id $vpc | jq -r ".[].NatGatewayId")
#iroute=$(aws ec2 create-route-table --vpc-id $vpc | jq -r ".[].RouteTableId")
#aws ec2 create-route --route-table-id $iroute --destination-ipv4-cidr-block 0.0.0.0/0 --gateway-id $igateway
#aws ec2 security group ...

for x in `seq 1 ${MAXMASTERS}`; do dmcreate ${ENVIRONMENT}.master-$x; done
for x in `seq 1 ${MAXWORKERS}`; do dmcreate ${ENVIRONMENT}.worker-$x; done

eval $(docker-machine env ${ENVINONMENT}.master-1)

export master_ip=$(docker-machine ip active)
swarm join --advertise-addr ${master_ip} --listen-addr ${master_ip}

export manager_token=$(swarm join-token manager -q)
export worker_token=$(swarm join-token worker -q)

connect ${MAXMASTER} "master" "init" ${master_token} ""
connect ${MAXWORKER} "worker" "join" ${worker_token} "${master_ip}"

compose services.yml ${ENVIRONMENT}
