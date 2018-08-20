# Setting Up and Connecting to the Raspberry Pi from the IoT Hub

This is Part 2 to the full demonstratin of connecting to a raspberry pi using Virtual Kubelet and IoT Edge. For Part 1, navigate [Here](https://github.com/NFeingold/Virtual-Kubelet-Demonstration/tree/master/Guide/1)

## Part 1: Setting up the Raspberry Pi 

Follow [this tutorial](https://blog.jongallant.com/2017/11/raspberrypi-setup/) on setting up a raspberry pi. It is a somewhat lengthy process, however you only ever have to do it once. It teaches you how to install the operating system, prepare things for this example, set up SSH, and a remote desktop which are __extremely helpful__. It is succinct and the best tutorial I have found. It suggests numerous peripherals, however, many are unnecessary. You only need what I previously mentioned.

## Create a Device in your IoT Hub

- Click on the IoT Hub you created (if you can't find it, you can search for it in the search bar on top)

- In the left navigation bar, scroll down and go to IoT Edge, then Add IoT Edge Device. All you have to do is name it.

- Click on the device id, copy and save the Connection String Primary Key into a text document

## Install Azure IoT Edge on the Pi

I will be following [this tutorial](https://docs.microsoft.com/en-us/azure/iot-edge/how-to-install-iot-edge-linux-arm) on setting up the Pi with IoT Edge. Feel free to follow their tutorial instead of this section for more detail. 

- Install the container runtime: 
```sh
# Download and install the moby-engine
curl -L https://aka.ms/moby-engine-armhf-latest -o moby_engine.deb && sudo dpkg -i ./moby_engine.deb

# Download and install the moby-cli
curl -L https://aka.ms/moby-cli-armhf-latest -o moby_cli.deb && sudo dpkg -i ./moby_cli.deb

# Run apt-get fix
sudo apt-get install -f
```
- Install the Secuirity Daemon 
```sh
# Download and install the standard libiothsm implementation
curl -L https://aka.ms/libiothsm-std-linux-armhf-latest -o libiothsm-std.deb && sudo dpkg -i ./libiothsm-std.deb

# Download and install the IoT Edge Security Daemon
curl -L https://aka.ms/iotedged-linux-armhf-latest -o iotedge.deb && sudo dpkg -i ./iotedge.deb

# Run apt-get fix
sudo apt-get install -f
```
- Configure the Daemon 
```sh
sudo nano /etc/iotedge/config.yaml
```

Update the value of device_connection_string with the connection string from your IoT Edge device.
(IoT Hub -> IoT Edge -> Device Details -> Connection String Primary Key)<br/>
**Note: This is the __Device Connection String,__ NOT the IoT Hub Connection String**

To exit, press Ctrl+X, Y, Enter

- Restart the Daemon
```sh
sudo systemctl restart iotedge
```
If succesfull, when you navigate to the IoT Hub Edge Devices and click on your device, it should say 'connected' near the bottom
