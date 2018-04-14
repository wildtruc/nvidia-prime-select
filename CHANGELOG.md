### Change Log
*( 18/04/13 ) v0.9.9*
 - Importante change done. look's like more a complete rewrite.
 - NEW USER: nothing special, just type as superuser or admin : (sudo) make install.
 - OLD USER:
  - uninstall previous version first: (sudo) make unisntall.
  - then reinstall as usualy: (sudo) make install.
 - BOTH:
  - If your display settings are not done, do it first with your desktop display tool.
  - execute nvidia-prime-select UI and select your display card
  - or by command line: nvidia-prime-select 'your_option'.
  - Restart your session.
  - An issue makes that session manager could take 30s to display correctly passmword field.
  - You could also just reboot.
  - After reboot/restart you may reconfigure your display setting and check if the xorg.conf fit your needs.
 - POSSIBLE ISSUES:
  - Session restart on gdm (gnome3) may vause result in a blank screen. In previous nvidia-prime-select, this issues was fix by inserting a delay waiting for full gdm start before insert xrandr command line. Try to uncomment 'sleep' function in /etc/nvidia-prime/xinitrc.prime and different delay. If it doesn't fix, think to change session manager to lightdm.
  - In some case, xrandr display config (~.config/monitors.xml) could conflict with nvidia-prime-select xrandr auto conf function. First, remove ~.config/monitors.xml, and restart your session. If it doesn't fix, set your dispal again and disable nvidia-prime.desktop autostart (menu > system > pref > personal > autostart), then restart your session.
  - At session restart login has a strange behaviour and could take 30/40s to display correctly. It maybe a polkit issue, but nt sure. 
  - Do not hesitate to send issue reports on Github page.

