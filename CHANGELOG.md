### Change Log
*( 22/04/13 ) v0.9.10*
 - Nvidia-prime-select was untested on multi display. It appeared that actual xrandr detection and sets failed, also display.prime was needed more delay before lauching because of xramdr monitors.xml file sets conflict.
 - Above is fixed (hopefully), there's still a strange wallpaper behaviour diplayed in double on my laptop desktop. Please, report if you have the same issue.
 - Just realize, I forgot to update /etc/modprobe.d to blacklist nouveau driver. Fixed (thanks to Tim).
 - Note: laptop is not my default machine, and I can't figure out all possible issues by my self, or wait, like it actually the case, my PC's mother board to die to disover them.
 
*( 18/04/13 ) v0.9.9*
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
