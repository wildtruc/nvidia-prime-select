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

# Usage

## Default usage :
  ```sh
  nvidia-prime-select option
  ```

## Options
 - **intel** : use the default GPU
 - **nvidia** : use the **Nvidia®** GPU
 - **nvidiaonly** : use the **Nvidia®** GPU permanently
 - **remove** : go back to intel/nvidia options chooser

## Before all
The first thing to do is to set correctly your screens with the default desktop tool in the config menu. This is mandatory.

Gnome and Cinnamon use a **monitors.xml**(~/.config/monitors.xml) file to keep your screen config and overide any other setup if it doesn't match the xml file.

**nvidia-prime-select** comes with a **library.conf** file to set custom installation directories up (same case if you come from an other distro). If you're in this case, edit it first before launching/installing anything.

Example of my custom driver install in Fedora 23:
```sh
  nv_drv_32='/opt/nvidia/lib'
  nv_drv_64='/opt/nvidia/lib64'
  nv_xorg_path='/opt/nvidia/xorg/modules'
  rc_dir='/etc/rc.d'
```

**nvidia-prime-select** come also with 2 default xorg configs for **Intel®** and **Nvidia®**. Edit them as you wish before launching install command.

## Install
**nvidia-prime-select** use the same install process as **[FedoraPrime](https://github.com/bosim/FedoraPrime)** :
  ```sh
  git clone https://github.com/wildtruc/nvidia-prime-select.git
  cd nvidia-prime-select
  sudo make install
  ```

To uninstall, run :
  ```sh
  sudo make uninstall
  ```
  
Copy/paste the library.conf file manually if you intend to use it :
  ```sh
  cp -f library.conf /etc/nvidia-prime-select/
  ``` 

When done, launch the commandline, your superuser or admin password will be ask. Then logout and restart your session.

The script will setup your actual **xrandr** configuration automatically and will use a custom **rc.local** file if you choose **nvidiaonly** option.

To stop it, use :
  ```sh 
  nvidia-prime-select remove
  ```
## Notes
**Option "NoLogo" "true"** in **xorg.nvidia.conf** is aparently useless, I only put it here by habits.

**Option "DPI" "96 x 96"** is set by default in the **xorg.nvidia.conf** because **xrandr** set it at **75** by default. If you have a weaker **Nvidia®** GPU, it's maybe a good thing to let it at **75** if you want to play some games smoother.

Usually when the Nvidia® GPU starts the screen become black at first, if it is, this is all good.

## Know issue
The script has been test on Gnome Shell, Gnome Classic, Cinnamon, LXQT, Kodi.

The only issue comes with Gnome Classic, desktop crash on final start.

## What won't be done
I try to set **nvidiaonly** as a desktop entry, sadly process crash each time. So a **.desktop** point entry is probably not a good idea.

Who cares ! **rc.local** custom file rocks! 
