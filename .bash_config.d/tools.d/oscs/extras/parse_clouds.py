import yaml
import os
import sys

# Determine the correct clouds.yaml path
clouds_yaml_path = os.getenv("OS_CLIENT_CONFIG_FILE")

if clouds_yaml_path is None:
    home_path = os.path.expanduser("~/.config/openstack/clouds.yaml")
    if os.path.exists(home_path):
        clouds_yaml_path = home_path
    else:
        system_path = "/etc/openstack/clouds.yaml"
        if os.path.exists(system_path):
            clouds_yaml_path = system_path

if clouds_yaml_path is None or not os.path.exists(clouds_yaml_path):
    sys.stderr.write("Error: clouds.yaml file not found.\n")
    sys.exit(1)

# Load the clouds.yaml file
with open(clouds_yaml_path, "r") as file:
    data = yaml.safe_load(file)

# Extract and print the cloud names
clouds = data.get("clouds", {})
for cloud_name in clouds:
    print(cloud_name)
