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

Just as easisly done, in the Pi Terminal, enter:

```sh
sudo apt-get --purge remove iotedge
```
