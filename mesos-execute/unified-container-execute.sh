#!/bin/bash

MESOS_MASTER_IP="10.103.0.125"
./src/mesos-execute --master=${MESOS_MASTER_IP}:5050	\
										--framework_capabilities="GPU_RESOURCES"	\
										--resources="cpus:4;mem:1024;gpus:2"	\
										--name=test	\
										--docker_image="redis"	\
										--shell=false
