# nvidia-prime-select
This is a fork of **[FedoraPrime](https://github.com/bosim/FedoraPrime)** enhanced for all linux distributions.

# Introduction
Seeking for a tools to swicht entirely from default **Intel®** GPU to the discret **Nvidia®** graphic card, I discover **[FedoraPrime](https://github.com/bosim/FedoraPrime)**.

It comes really useful for my default distro, **Fedora**, but not so cool for my custom **Nvidia®** driver install, **[FedoraPrime](https://github.com/bosim/FedoraPrime)** is **Fedora** only with a default driver config.

Thus, I discided to go deeper to solve that particular issue and a few others as well.
 - Choose for a custom driver install
 - Automatically configure xrandr for multi screens (or not)
 - Start **Nvidia®** GPU instead the default one whatever the end user desktop you choose.

--------------
# Update message
### 2018-04-01
Dev test was running on Fedora 24, since upgraded to Fedora 27 it appears that xrandr on modesettings is broken and dosn't work anymore for discret nvidia.

### 2018-04-13
Finally, the script needed a complete rewrite. For user, basics are still the same, but they work differently than the previous version.

Read Changelog display before install/uninstall/update.

Thanks to the **[Nvidia Devtalk](https://devtalk.nvidia.com/default/topic/1024318/linux/-solved-nvidia-prime-on-dual-gpu-configuration-giving-a-blank-screen/2)** thread and to **nospam_** that giving me the necessary base to understand what changed. 

Also added a libraries and xorg config editor.

Library.conf is install by default and checked if configured.

There stil some issue with some session managers, see **Known Issues** at page bottom.

Hope you'll like those changes and don't forget to send any bug you get. :)

--------------

# Usage

## Default usage :
  ```sh
  nvidia-prime-select option
  ```

## Options
 - *intel* : use the default GPU
 - *nvidia* : use the **Nvidia®** GPU
 
## Before all
The first thing to do is to set correctly your screens with the default desktop tool in the config menu. This is not mandatory but useful.

Gnome and Cinnamon use a *monitors.xml*(~/.config/monitors.xml) file to keep your screen config and overide any other setup if it doesn't match the xml file.

Gdm Gnome3 may cause issue in some case. See **Issue** chapter in bottom ofthe page and send report if you can fix it this way.

**nvidia-prime-select** comes with a *library.conf* file to set custom installation directories up (same case if you come from an other distro). If you're in this case, edit it first before launching/installing anything.

Example of my custom driver install in Fedora 23:
```sh
  nv_drv_32='/opt/nvidia/lib'
  nv_drv_64='/opt/nvidia/lib64'
  nv_xorg_path='/opt/nvidia/xorg/modules'
  rc_dir='/etc/rc.d'
```

Or use the simpliest way and launch **nvidia-prime-ui** from settings menu.

**nvidia-prime-select** come also with 2 default xorg configs for **Intel®** and **Nvidia®**. Edit them as you wish before or after luanching command (edit function is available in nvidia-prime-ui).

## Install
**nvidia-prime-select** use the same install process as **[FedoraPrime](https://github.com/bosim/FedoraPrime)** :
  ```sh
  git clone https://github.com/wildtruc/nvidia-prime-select.git
  cd nvidia-prime-select
  sudo make install
  ```

To update, run :
  ```sh
  sudo make update
  ```
To uninstall, run :
  ```sh
  sudo make uninstall
  ```

When done, launch the commandline, your superuser or admin password will be ask. Then logout and restart your session.

The script will setup your actual *xrandr* configuration automatically.

## Notes
*Option "DPI" "96 x 96"* is set by default in the *xorg.nvidia.conf* because *xrandr* set it at *75* by default. If you have a weaker **Nvidia®** GPU, it's maybe a good thing to let it at *75* if you want to play some games smoother.

Usually when the Nvidia® GPU starts the screen display some wierd black lines at first, if it is, it means that Nvidia® GPU is started.

## Known issues
The script has been test on Gnome Shell, Gnome Classic, Cinnamon, LXQT, Kodi (for previous version, lightdm only for new one).

 - The only issue comes with Gnome Classic, desktop crash on final start. I'm not sure it comes from Gnome Classic itself.
 - For **Fedora** users upgrading from **Fedora 23** to **24** using the **dnf** tools, don't forget to re-enable the service after the first reboot. You have to probably reset your display *xrandr* config too.
 - Since **Fedora 24**, *rc.nivia* schedule time set is not enough to let *GDM* fully start. Need to extend from 5 to 10 secondes (update 10/08/16).
 - Session restart on gdm (gnome3) may vause result in a blank screen. In previous nvidia-prime-select, this issues was fix by inserting a delay waiting for full gdm start before insert xrandr command line. Try to uncomment 'sleep' function in /etc/nvidia-prime/xinitrc.prime and different delay. If it doesn't fix, think to change session manager to lightdm.
 - In some case, xrandr display config (~.config/monitors.xml) could conflict with nvidia-prime-select xrandr auto conf function. First, remove ~.config/monitors.xml, and restart your session. If it doesn't fix, set your dispal again and disable nvidia-prime.desktop autostart (menu > system > pref > personal > autostart), then restart your session.
 - At session restart login has a strange behaviour and could take 30/40s to display correctly. It maybe a polkit issue, but nt sure.
 - Do not hesitate to send issue reports on Github page.
