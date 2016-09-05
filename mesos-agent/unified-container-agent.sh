#! /bin/bash

# In ../mesos/build/
# --isolation 
#			'cgroups/devices,gpu/nvidia'	Support GPUs, 
#			'disk/du' enable the Posix Disk isolator.
#			'docker/runtime'	Used to provide support for runtime configurations 
#												specified in Docker images.
#			'filesystem/linux'	This is needed because supporting container
#													images involves changing filesystem root. Note 
#													this isolator requires root permission.
# --containerizers
#			Comma-separated list of containerizer implementations to compose in 
#			order to provide containerization.
#			Available options are 'mesos', 'external', 'docker'.
#
# --image_providers
#			Comma-separated list of supported image provider, e.g., APPC, DOCKER
#
# --[no-]enforce_container_disk_quota
#			Whether to enable disk quota enforcement for containers. This flag is
#			used for the 'disk/du' isolator. (default: false)
#
# --default_container_info
#			Enable Shared Filesystem isolator.
#			Used when starting Framework or Agent.

MESOS_MASTER_IP="10.103.0.125"
MESOS_WORK_DIR="/var/lib/mesos"
ACHIEVE_DOCKER_IMAGES_DIR="/home/sunzhe/workspace/docker-images"

GLOG_v=1 ./bin/mesos-agent.sh \
										 --master=zk://${MESOS_MASTER_IP}:2181/mesos	\
										 --ip=10.103.0.125	\
										 --work_dir=${MESOS_WORK_DIR}	\
										 --isolation=cgroups/devices,disk/du,docker/runtime,filesystem/linux	\
										 --enforce_container_disk_quota	\
										 --containerizers=mesos	\
										 --image_providers=docker \
									   --executor_environment_variables="{}"
#										 --docker_registry=${ACHIEVE_DOCKER_IMAGES_DIR} \





