# PiCloud

This folder contains scripts to run the PiCloud LED demo from a Windows PC.
Just copy this folder to your laptop, connect it to the PiCloud datacenter
and use the cmd scripts to run the demo.

## Rainbow demo

After turning on the PiCloud it should start three replicas of the rainbow service.

Now use the scripts to scale up, unplug cables to see how Docker swarm
restarts missing replicas and so on.

## Whoami demo

The whoami service is a simple web server that shows its computer name in the response. A user is simulated with another script accessing this service every second.

After scaling up to more than one replica you see how the load balancer
redirects the requests to different containers. The response always shows
a different computer name.
