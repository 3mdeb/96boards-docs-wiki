## General Tips

### Common

### Setting up a WIFI connection via command line on Debian/Ubuntu (Network Manager)

In case you don't have a HDMI monitor around and got UART access to the board (e.g. [UART adapter board](http://www.96boards.org/products/mezzanine/uarts/) or [Sensors Mezzanine
](http://www.96boards.org/products/mezzanine/sensors-mezzanine/)), there are quite a few easy ways for you to configure a wireless connection, so you can then remotely access your board without any extra cables (besides the power adapter).

To show the overall status of NetworkManager:

```shell
root@linaro-alip:~# nmcli general status
STATE         CONNECTIVITY  WIFI-HW  WIFI     WWAN-HW  WWAN    
disconnected  none          enabled  enabled  enabled  enabled 
```

To show all connections:

```shell
root@linaro-alip:~# nmcli connection show
NAME  UUID  TYPE  DEVICE 
```

To show the device status (for the devices recognized by Network Manager:

```shell
root@linaro-alip:~# nmcli device status
DEVICE  TYPE      STATE         CONNECTION 
wlan0   wifi      disconnected  --         
lo      loopback  unmanaged     --         
```

To view the list of available access points:

```shell
root@linaro-alip:~# nmcli dev wifi list
*  SSID        MODE   CHAN  RATE       SIGNAL  BARS  SECURITY  
   foonet      Infra  7     54 Mbit/s  70      ▂▄▆_  WPA2      
   96boards    Infra  4     54 Mbit/s  80      ▂▄▆_  WPA2      
   linaro-wifi Infra  52    54 Mbit/s  7       ▂___  WPA2      
   debian      Infra  11    54 Mbit/s  89      ▂▄▆█  WPA1 WPA2 
```

To connect to a WIFI access point, first create the connection:

```shell
root@linaro-alip:~# nmcli con add con-name WiFi ifname wlan0 type wifi ssid foonet 
Connection 'WiFi' (4b40221c-9af9-45ae-b5df-7d8bfe301ad5) successfully added.
```

Then set up the password for your access point (e.g. for a WPA2 AP):

```shell
root@linaro-alip:~# nmcli con modify WiFi wifi-sec.key-mgmt wpa-psk
root@linaro-alip:~# nmcli con modify WiFi wifi-sec.psk myownpassword
```

Then just enable the connection:

```shell
root@linaro-alip:~# nmcli con up WiFi
```

#### Disabling graphics interface (Debian)

When the graphics interface is not really needed (e.g. using as a server), it's just better to disable the entire X11 stack to reduce the amount of memory and cpu used by the system.

To disable X11 on boot:

```shell
root@linaro-alip:~# systemctl set-default multi-user.target
```

To enable X11 again:

```shell
root@linaro-alip:~# systemctl set-default graphical.target
```

### HiKey

#### Configuring the wireless TI module (Debian)

Using the right WiFi (TI wl1835mod) module config for HiKey (avoid bugs like https://bugs.96boards.org/show_bug.cgi?id=202)

```shell
root@linaro-alip:~# configure-device.sh 

Please provide the following information.

Are you using a TI module? [y/n] : y
What is the chip flavor? [1801/1805/1807/1831/1835/1837 or 0 for unknown] : 1835
How many 2.4GHz antennas are fitted? [1/2] : 1
Should SISO40 support be applied? [y/n] : n

The device has been successfully configured.
TI Module: y
Chip Flavor: 1835
Number of 2.4GHz antennas fitted: 1
Number of 5GHz antennas fitted: 0
Diversity Support: n
SISO40 Support: n
Japanese standards applied: n
```

Then just reboot and the wireless module should now use the right configuration.

### DragonBoard 410c