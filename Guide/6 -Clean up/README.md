# Clean up


## Azure

The cleanup is *very easy* for Azure. Simply enter the following:

```ssh
kubectl delete group <resource-group> --no-wait -y
```

And like that, everything in Azure will be removed (after about 10 minutes).

To delete induvidual files, just enter:

```ssh
rm -rf <file>
```

## Raspberry Pi

Just as easisly done, in the Pi Terminal:

### Remove IoT Edge Provider
```sh
sudo apt-get --purge remove iotedge
```

Courtesy of [The Humble Developer](http://blog.baudson.de/blog/stop-and-remove-all-docker-containers-and-images),


### Stop all running containers
```sh
docker stop $(docker ps -aq)
```

### Remove all containers
```sh
docker rm $(docker ps -aq)
```

### Remove all images
```sh
docker rmi $(docker images -q)
```
