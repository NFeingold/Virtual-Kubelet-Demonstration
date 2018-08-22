# Testing Sample Deployments

This is Part 3 to the full demonstration of a sample deployment to a raspberry pi using Virtual Kubelet and IoT Edge.

At this point, you should have set up your AKS cluster, and your raspberry pi should be connected to our IoT Hub.

## Deploying to the Raspberry Pi

First, test to make sure the connector is still running, by typing into the Azure Portal command line

```sh
kubectl get nodes
kubectl get pods
```
If its not running, such as it has a CrashLoopBackOff error, refer to folder 5.

If they are running, we will now prepare to deploy our simulated temperature sensor

### Edit the Deployment File to Deploy to the Pi

Open the file to edit (either Vim or Nano work fine- I will use Vim)

```sh
cd
vim iot-edge-virtual-kubelet-provider/src/Microsoft.Azure.VirtualKubelet.Edge.Provider/sample-deployment.yaml
```
If you are in vim, hit "i" or "insert" to edit the file. Scroll down until you find "targetCondition." 
Change the value of targetCondition to "deviceID='&lt;device id>'"

Now hit escape, :, x, then enter, to save and exit the file.



### Send out the Deployment

```sh
cd
kubectl apply -f \
iot-edge-virtual-kubelet-provider/src/Microsoft.Azure.VirtualKubelet.Edge.Provider/sample-deployment.yaml
```

Give it a couple minutes, then check to see if the deployment was succesful. This can be done multiple ways. 

 - Navigate to the IoT Edge (in the IoT Hub), and click on your device ID. You should see a tempsensor deployment.  
 - In the Raspberry Pi terminal, type ```docker ps``` and you should see tempsensor deployed
 - Type ```kubectl get pods``` into the azure portal command line, and you should see a tempsensor deployment
 
### Read the Telemetry Data from the Pi

 - Open up Visual Studio Code, and sign into your account. 
 - Click on the 'Explorer Buton' (The one that looks like stacked papers in the top left)
 - On the bottom, there is a section that says 'AZURE IOT HUB DEVICES'
  - Hover over this bar, and left click and HOLD on the 3 dots on the far right
 - Click on 'Select IoT Hub'. This should move you to the bar along the top
 - Click on your subscription, then on your IoT Hub
 
 Your device should now appear in the bottom left. Right click on it and select  'Monitor D2C Messages' (D2C meaning Device to Cloud).
 Afte a few moments you should start seeing simulated temperature data being sent from the pi. 
 
 Congrats! If you made it here, you have been succesful. Now to see what Kubernetes has to offer us
