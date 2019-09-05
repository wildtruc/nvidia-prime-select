### Change Log
*( 2019/09/05 ) v0.9.20*
 - add more filter to current config used and readapted xorg config editor for customized xorg.conf.
 - reviewed xrandr config system and fixed it to be lighter.
 - options in xorg file are useless and removed by default because with modesetting they are not reconize by the driver.
 - introducing first modifications for next 'offload' setting. Read inside the script at 'go_offload' function if you want to help.
 - default options conf file nvidia-drm set is by default set to 'none' (looks useless in most cases).
 - WARNING: Do a 'sudo make install' this time and don't forget to make a backup of /etc/nvidia-prime.
 
*( 2019/08/20 ) v0.9.19*
 - grub configuration tool updated, finally.
 - many mistakes discovered and fixed. Including on previous update. (dev brain is not so well :s)
 - check and test on my old laptop 610M with update 390.xx driver series, 390.129.
 - HOW-TO : perform a new 'make install' if necessary.
 - Save your libconfig file and custom xorg file if any.
 - Exec 'nvidia-prime-select nvidia' by cmdline or GUI, reboot.
 - if the creepy VGA-0 ghost display come back, don't forget to disable it with xrandr GUI and then restart your session.
 - don't forget to report in github issues section if anything goes wrong.
 
*( 2019/08/03 ) v0.9.18*
 - Due to lspci graphic controller name as "3D controller", after a few tests, regex to get bus id list was wrong. Modified for a more appropriate.
 - please, test and report.  
 
*( 2019/08/02 ) v0.9.17*
 - As reported, new nvidia discret card bus ID has changed. Script wasn't prevent those kind of changes. This is hopefuly fixed.
 - Modified code is a bit ugly, please report on any issue.

*( 2019/07/28 ) v0.9.16*
 - Efi grub mkconfig test, please report.
 
*( 2019/03/6 ) v0.9.15*
 - fixed bad bracket in conditioal form (line 157).

*( 2019/03/4 ) v0.9.14*
 - info: My laptop is too old now and it's no more support by nvidia drivers. I can't no longer test on it.
 - message: I've severe health issues and don't know if I'll can still continue to maintain my projects. Fork is strongly recommand.
 - thanks to ekultails and joeg1484 to wake me up.
 - Add fix for EFI boot (unted on hardware, need probably improvement).
 - remove set -e env set, too strict.
 
*( 2018/10/29 ) v0.9.13*
 - fix changelog.sh to display changelog message regardless zenity dependency installed.

*( 2018/06/27 ) v0.9.12*
 - Makefile: changed 'sh' to 'bash' prefix in command line on user clever comment.
 
*( 2018/04/24 ) v0.9.11*
 - Add a options config file editable by nvidia-prime-ui because some users seems to have big trouble with grub config. Options file default sample is send with comment.
 - options are :
  - delay: allow to add a user's session delay before launching xrandr command (default 5).
  - intel_nodelay: start intel user's session without the configured delay (intel usually doesn't need it).
  - cfg_grub: enable/disable check and config (default 1).
  - cfg_modeset: enable/disable modeset config (if cfg_grub is set to 1) (default 1).
  - nv_modeset: set nvidia modeset (grub section) to set (1) or unset (0) (default 1).
  - font_style: nvidia-prime-ui brighness (dark/bright background.) (default 0)
 - Rewrote grub config section to be more intuitive. It separatly add modeset and 'nouveau' blacklist. Modeset could be change to 0 or 1 thruough options config file (default is 1).
 - Review xrandr auto config section to add offline displays at session manager start when nvidia option is set.
 - Add a report.sample in markdown to fill in issue reports.
 
*( 2018/04/22 ) v0.9.10*
 - Nvidia-prime-select was untested on multi display. It appeared that actual xrandr detection and sets failed, also display.prime was needed more delay before lauching because of xramdr monitors.xml file sets conflict.
 - Above is fixed (hopefully), there's still a strange wallpaper behaviour diplayed in double on my laptop desktop. Please, report if you have the same issue.
 - Just realize, I forgot to update /etc/modprobe.d to blacklist nouveau driver. Fixed (thanks to Tim).
 - Note: laptop is not my default machine, and I can't figure out all possible issues by my self, or wait, like it actually the case, my PC's mother board to die to discover them.
 
*( 2018/04/13 ) v0.9.9*
 - Importante change done. Look's more like a complete rewrite.
 - NEW USER: nothing special, just type as superuser or admin : (sudo) make install.
 - OLD USER:
  - uninstall previous version first: (sudo) make unisntall.
  - then reinstall as usualy: (sudo) make install.
 - BOTH:
  - If your display settings are not done, do it first with your desktop display tool.
  - execute nvidia-prime-select UI and select your display card.
  - or by command line: nvidia-prime-select 'your_option'.
  - Restart your session.
  - An issue makes that session manager could take 30s to display correctly password field.
  - You could also just reboot.
  - After reboot/restart you may reconfigure your display setting and check if the xorg.conf fit your needs.
 - POSSIBLE ISSUES:
  - Session restart on gdm (gnome3) may cause result in a blank screen. In previous nvidia-prime-select, this issue was fix by inserting a delay waiting for full gdm start before insert xrandr command line. Try to uncomment 'sleep' function in /etc/nvidia-prime/xinitrc.prime and different delay. If it doesn't fix, think to change session manager to lightdm.
  - In some case, xrandr display config (~.config/monitors.xml) could conflict with nvidia-prime-select xrandr auto conf function. First, remove ~.config/monitors.xml, and restart your session. If it doesn't fix, set your display again and disable nvidia-prime.desktop autostart (menu > system > pref > personal > autostart), then restart your session.
  - At session restart login has a strange behaviour and could take 30/40s to display correctly. It maybe a polkit issue, but nt sure. 
  - Do not hesitate to send issue reports on Github page.

