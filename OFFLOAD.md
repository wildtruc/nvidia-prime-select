# Introduction to incomming OFFLOAD feature  
Since beta version 435.17, nvidia drivers have been providing Prime with the ability to support Offload technology. It is a test method that only works with a patched version of Xorg. However, after a few training exercises on a test machine, it appears that xorg's configuration to manage this feature works without any particular problems even if it does not offer Offload over the Nvidia GPU.

The test machine is old and only works with the recently updated 390.129 driver and is therefore unable to support Offload in the desired way.


More useful informations about OFFLOAD execution are still missing (no hardware to properly test, etc), the below tests may simply not work.

We will continue to edit this document as progresses are reported.

## Tested xorg file
If you wish to test this new feature yourself, here is the xorg file with which the tests were done.

### xorg.intel.conf
```
Section "Files" # <- this section is optional for the moment and can be safely removed.
    ModulePath	"/usr/lib64/xorg/modules"
    ModulePath	"/opt/nvidia/xorg/modules"
EndSection

Section "ServerLayout"
	Identifier	"layout"
	Screen	0	"intel_screen"
	Option		"AllowNVIDIAGPUScreens"
EndSection

Section "Module"
	Load		"glamoregl"
EndSection

## nvidia xorg connf
Section "Device"
	Identifier	"nvidia"
	Driver		"nvidia"
	BusID		"PCI:1:0:0"
EndSection

Section "Screen"
	Identifier	"nvidia_screen"
	Device	"nvidia"
EndSection

## intel xorg conf
Section "Device"
	Identifier	"intel"
	Driver		"modesetting"
	BusID		"PCI:0:2:0"
EndSection

Section "Screen"
	Identifier	"intel_screen"
	Device	"intel"
EndSection
```

The "Files" section is added there but not mandatory if you only do a xorg file compatibility test on a machine that anyway will not be able to support Offload. It could become the default intel xorg file of nvidia-prime-select for using the Intel integrated card.

Don't forget to change the BusID lines by your PCI IDs that are already saved in the file ```/etc/nvidia-prime/xorg.intel.conf```.

The use of DRI3 by the Intel chip is mandatory. However, it should not be defined in the Xorg configuration, as the use of the "modesetting" driver apparently does not understand the options dedicated to the Intel driver. Also note that most of the nvidia driver options are not recognized either. The "Screen" sections must therefore remain free of all options.

## Test on machine that is able to use the beta 435.17 driver.
IMPORTANT: Make a full backup of the /etc/nvidia-prime file before doing anything!


This section implies that you already have a sufficiently advanced knowledge of the GNU Linux tree structure and the various command lines needed to copy and move files and folders.

I strongly recommend that you install and use Midnight Commander (mc) for your terminal operations. It will be much easier to use and will avoid you from countless command lines

### Basics and attention
As already noted, Offload is only supported by the beta 435.17 driver and a patched version of Xorg.

This version is located on the Xorg main branch on GitHub. Only the Ubuntu PPA version of this test version of Xorg is provided by Nvidia's [README](https://download.nvidia.com/XFree86/Linux-x86_64/435.17/README/primerenderoffload.html), but it can be assumed that the testing branches of the other distributions have also included it (to be checked before doing anything). You must therefore activate the "testing" repositories of your distribution and install Xorg packages. 


Warning: installing Xorg packages can result in a serious update of many other dependent packages and strange things can happen afterwards. Be careful.


Compared to the original file by nvidia-prime-select, the "Files" lines in the configuration section above have been inverted so that the xorg modules of the distribution are first managed. The test with the initial order having failed, my laptop being out of date.

It is possible for the test to have to reverse the order, however, we will do things step by step.

## Test
Once all the packages have been installed and the xorg file configured, you can restart your machine.


VERY IMPORTANT: If something goes wrong and the X server does not start, switch to console mode [ctrl+alt+F'x'] (from F2 to F6), enter your 'root' or 'user' credentials as administrator, and restore /etc/nvidia-prime to its original state. the X server should restart normally.

## First operational tests
Offload currently allows the use of GLX OpenGL and Vulkan. EGL is not yet supported.

If everything went well, your X server started and your manager session opened your favorite interface.

The first thing to do from your interface from a terminal is to enter the following'xrandr' command line:

```xrandr --listproviders```

If the xorg testing version is patched the terminal should return a list with the supplier "NVIDIA-G0". In this case you can proceed to the next step.


### Control the OpenGL / vulkan provider
```__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia glxinfo | grep vendor```

This must return the NVIDIA vendor.

### Vulkan 3D test
The GLVND library must be active for the NVIDIA driver and the VULKAN library correctly installed.

```__NV_PRIME_RENDER_OFFLOAD=1 vkcube```

or :

```__NV_PRIME_RENDER_OFFLOAD=1 __VK_LAYER_NV_optimus=NVIDIA_only vkcube```

or  test the correct integrated intel gpu behavoiur :

```__NV_PRIME_RENDER_OFFLOAD=1 __VK_LAYER_NV_optimus=non_NVIDIA_only vkcube```


### Test GLX/OpenGL :
```__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia glxgears```

You can define the order more precisely by adding the name of the seller obtained with ``xrandr```.

```__NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0 __GLX_VENDOR_LIBRARY_NAME=nvidia glxgears```


# Direct test on application and environment variable.
If all previous tests have returned the expected results. You can now test your applications.

The easiest way would be to try to edit the profiles in **nvidia-settings** by adding the variable **__NV_PRIME_RENDER_OFFLOAD=1** for all applications running on the Nvidia GPU. This is not a guaranteed solution, it is not meant that the profile system accepts this variable since it is not an official part of the pre-formatted list of **nvidia-settings**.

The second is to edit the desktop file of the application or create a copy by adding the environment variable as a prefix to the executable.

# Future update of nvidia-prime-select.
As my laptop is already 7 years old, I have no way to test the new Prime requirements live. And I don't have the material means to invest in an optimus new laptop computer.
The solution lies either in interactive support with the most motivated users, or in investing in a second-hand laptop less than 2 years old with the help of the community, a budget of 500€ should be enough.

If this solution is suitable for you, the donation of 1€ to 5€ per motivated user with reference 'prime' to the following paypal address should be appropriate (noneltd[at]gmail[dot]com).

I have no particular idea for the choice of an optimus laptop that will have to be able to stand the test over a long period of time, you can suggest one in the subject opened for this purpose in the tab "issues".

(Translation enhanced with the help of www.DeepL.com/Translator)

