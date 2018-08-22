# Editing Your Deployment with Kubernetes

Kubernetes gives us many tools to play with our deployments. We can do this two ways- by interacting with the deployment
through the command line, and editing and reapplying our sample-dpeloyment.yaml file. We will be covering the basic capabilites
that Kubernetes provides us, such as scaling and adding/removing images. 

## Scaling a Deployment

One of the biggest advantages in Kubernetes is to only use what you need. When paying for resources by second of use, a lot of money can be saved. This is especially the case when dealing with workloads that have varying demands. The only time you have to pay for a lot of resources is when you need them. Once the heavy workload has concluded, you can then stop paying for them. 

There are two ways to do this:

### Scaling through the Command Line

```sh
kubectl scale deployment <deployment name; tempsensor> --replicas <number of replicas>
```

You can test the results by typing ```kubectl get pods```. If succesful, you should now see multiple pods equivalent to the number
of replicas you specified. 

### Scaling through Updating the Deployment

Similar to earlier when we edited the deployment to specify the device ID, we can also edit the 'replicas' tag with a new number. This can be done by entering the following

```sh
vim <file location>
```

You can then edit the replicas to have a higher number, and the same effect as the previous command line entry.

Then hit escape, :, x, enter.

## Updating and Rolling back Deployments

Another advntage of kubernetes is the ability to update and rollback deployments no downtime using the rolling-update feature. You can do this by first updating your deployment, then entering:

```sh 
kubectl apply -f <file>
```

## Updating Container Image

You can also easily update the image inside the container you are running by executing the following command:
```sh
kubectl rolling-update <name> <new name> --image <image:tag>
```

## IoT Hub Advantages

There is much more that is achievable through Kubernetes. However, we are getting the best of both worlds between Kubernetes and Azure when using Virtual Kubelet. In addition to the previous uses, we can also take advantage of things such as device tags; a service provided by the IoT Hub.

In the deployment file, which we can edit in vim using the method showed earlier, we can changed the target condition to a device tag. A tag that can apply to multiple devices. The example in the deployment before we edited it was tag 'b43', or 'building 43'. Therefore, you can select batches of units to deploy to- rather than just the induvidual or all of them.

First, selet the device(s) you want to give the tag, and add a tag to them. Continuing from there, you can edit the deployment file to have targetcondition value be the tag you created. Then just use the same ```kubectl apply -f <file>``` and deploy out to the specified devices. 

##

We can also take advantage of device twins, device health monitoring, and much more that is standard in the IoT Hub Servies.
  
