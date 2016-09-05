#!/bin/bash


MESOS_MASTER_IP="10.103.0.125"
./bin/mesos-master.sh --zk=zk://${MESOS_MASTER_IP}:2181/mesos	\
											--ip=10.103.0.125	\
											--work_dir=/var/lib/mesos	\
											--quorum=0


