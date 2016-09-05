#! /bin/bash

./bin/start --master 10.103.0.125:5050 --zk zk://10.103.0.125:2181/marathon --enable_features gpu_resources
