#! /bin/bash

# Define 
# software_name (depends on git_dir_name in build)
# soft_runtime_repo (depends on installation git in build)
# service_name (depends on service_name in install.sh)
dir_postfix=_r
tar_postfix=.tar.gz
software_name=RouletteDecision
software_dir=$software_name$dir_postfix
software_tar=$software_name$tar_postfix
soft_runtime_repo=https://github.com/s31b18/decision_runtime.git
service_name=cd_node
current_dir="$PWD"

echo "update $software_name "

# Check software's old version exists
# If exists, move the old version config file out and remove the old version software
if [ -d "$software_dir" ] ; then
    echo "old version exists"
    mv $software_dir/conf.json $current_dir
    sudo rm -r $software_dir
fi

echo $software_tar
# Remove the old version tar
if [ -f "$software_tar" ] ; then
    echo "old tar exists"
    sudo rm -r $software_tar
fi

# Get the new version software
wget $soft_runtime_repo
tar -xzf $software_tar

# Put the configs file to the new version software
if [ -f "conf.json" ]; then
    echo "replacing with old configs"
    mv conf.json $software_dir
fi

# Restart the service

# Restart the service
service $service_name restart

echo "Update Finish"
