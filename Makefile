INSTALL_DIR = /etc/nvidia-prime

.PHONY: all install uninstall

all: install

install:
	mkdir -p $(INSTALL_DIR)
	cp -f ./xorg.nvidia.conf $(INSTALL_DIR)/
	cp -f ./xorg.intel.conf $(INSTALL_DIR)/
	cp -f ./rc.local $(INSTALL_DIR)/
	cp -f ./rc.nvidia $(INSTALL_DIR)/
	cp -f ./nvidia-prime-select /usr/sbin/
	cp -f ./nvidia-prime-ui /usr/bin/
	cp -f ./nvidia-prime.png /usr/share/pixmaps/
	cp -f ./nvidia-prime-ui.desktop /usr/share/applications/
	cp -f ./nvidia-prime.service /usr/lib/systemd/system/
	systemctl enable nvidia-prime.service

uninstall:
	systemctl disable nvidia-prime.service
	rm -rf $(INSTALL_DIR)
	rm -f /usr/sbin/nvidia-prime-select
	rm -f /usr/bin/nvidia-prime-ui
	rm -f /usr/share/pixmaps/nvidia-prime.png
	rm -f /usr/share/applications/nvidia-prime-ui.desktop
	rm -f /usr/lib/systemd/system/nvidia-prime.service
	rm -f /etc/X11/xinit/xinitrc.d/nvidia
