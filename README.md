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
# Update message 2018-03-24
Nivdia-prime-ui has been updated to policy-kit auth instead old 'su/sudo' one.
Nvidia-prime-select is still a pure supoeruser script.


Also added a librairies config editor, an 'update' option to makefile and fix some code syntax.
Librairy.conf is now install by default and checked if configured.

Hope you'll like those changes and don't forget to send any bug you get. :)

Don't forget to update your config after update (nvidia-prime-select will be reset to default **intel**)

--------------

# Usage

## Default usage :
  ```sh
  nvidia-prime-select option
  ```

## Options
 - *intel* : use the default GPU
 - *nvidia* : use the **Nvidia®** GPU
 - *nvidiaonly* : use the **Nvidia®** GPU permanently
 - *remove* : go back to intel/nvidia options chooser

## Before all
The first thing to do is to set correctly your screens with the default desktop tool in the config menu. This is mandatory.

Gnome and Cinnamon use a *monitors.xml*(~/.config/monitors.xml) file to keep your screen config and overide any other setup if it doesn't match the xml file.

**nvidia-prime-select** comes with a *library.conf* file to set custom installation directories up (same case if you come from an other distro). If you're in this case, edit it first before launching/installing anything.

Example of my custom driver install in Fedora 23:
```sh
  nv_drv_32='/opt/nvidia/lib'
  nv_drv_64='/opt/nvidia/lib64'
  nv_xorg_path='/opt/nvidia/xorg/modules'
  rc_dir='/etc/rc.d'
```

Or use the simpliest way and launch **nvidia-prime-ui** from settings menu.

**nvidia-prime-select** come also with 2 default xorg configs for **Intel®** and **Nvidia®**. Edit them as you wish before launching install command.

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

The script will setup your actual *xrandr* configuration automatically and will use a custom *rc.local* file if you choose *nvidiaonly* option.

To set permanent *nvidiaonly* option. Use first the *nvidia* option if you haven't already set it and then the *nvidiaonly* option.
  ```sh
  nvidia-prime-select nvidia
  nvidia-prime-select nvidiaonly
  ```
At the next boot the laptop will start with the Nvidia® GPU.

To stop using this feature, type :
  ```sh 
  nvidia-prime-select remove
  ```
It will remove the *rc.nvidia* and restore *rc.local* at its previous state.

## Notes
*Option "NoLogo" "true"* in *xorg.nvidia.conf* is aparently useless, I only put it here by habits.

*Option "DPI" "96 x 96"* is set by default in the *xorg.nvidia.conf* because *xrandr* set it at *75* by default. If you have a weaker **Nvidia®** GPU, it's maybe a good thing to let it at *75* if you want to play some games smoother.

Usually when the Nvidia® GPU starts the screen become black at first, if it is, this is all good.

## Known issues
The script has been test on Gnome Shell, Gnome Classic, Cinnamon, LXQT, Kodi.

The only issue comes with Gnome Classic, desktop crash on final start. I'm not sure it comes from Gnome Classic itself.

For **Fedora** users upgrading from **Fedora 23** to **24** using the **dnf** tools, don't forget to re-enable the service after the first reboot. You have to probably reset your display *xrandr* config too.

Since **Fedora 24**, *rc.nivia* schedule time set is not enough to let *GDM* fully start. Need to extend from 5 to 10 secondes (update 10/08/16).

## What won't be done
I try to set *nvidiaonly* as a desktop entry, sadly process crash each time. So a *.desktop* point entry is probably not a good idea.

Who cares ! *rc.local* custom file rocks! 
