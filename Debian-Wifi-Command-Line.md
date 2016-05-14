## Setting up a WIFI connection via command line on Debian/Ubuntu

In case you don't have a HDMI monitor around and got UART access to the board (e.g. [UART adapter board](http://www.96boards.org/products/mezzanine/uarts/) or [Sensors Mezzanine
](http://www.96boards.org/products/mezzanine/sensors-mezzanine/)), there are quite a few easy ways for you to configure a wireless connection, so you can then remotely access your board without any extra cables (besides the power adapter).

There are basically two easy ways to configure your network via command line, one is via Network Manager and the other is simply using _/etc/network/interfaces_ with the right arguments.

This tutorial assumes you are running either Debian (e.g. CE RPB) or Ubuntu, and it is not specific to a board.

### Using Network Manager

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

Then just change the wifi state, or reboot:

```shell
root@linaro-alip:~# nmcli radio wifi off
root@linaro-alip:~# nmcli radio wifi on
```

### Using /etc/network/interfaces

Using _/etc/network/interfaces_ is quite easy, but the consequence is that Network Manager will not manage your wireless device anymore, simply because it is already managed by the OS itself (and will not show up in your graphics session).

Simply create a file at _/etc/network/interfaces.d/wireless_, containing:

```shell
root@linaro-alip:~# cat /etc/network/interfaces.d/wireless
auto wlan0
iface wlan0 inet dhcp
  wpa-ssid domonet
  wpa-psk rsalvetinet
```

And reboot.