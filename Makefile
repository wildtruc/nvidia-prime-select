INSTALL_DIR = /etc/nvidia-prime

.PHONY: all install uninstall

all: install

install:
	mkdir -p $(INSTALL_DIR)
	cp ./xorg.nvidia.conf $(INSTALL_DIR)/
	cp ./xorg.intel.conf $(INSTALL_DIR)/
	cp ./rc.local $(INSTALL_DIR)/
	cp ./rc.nvidia $(INSTALL_DIR)/
	cp ./nvida-prime-select /usr/sbin/fedora-prime-select
	cp nvidia-prime.service /usr/lib/systemd/system/nvidia-prime.service
	systemctl enable nvidia-prime.service

uninstall:
	systemctl disable nvidia-prime.service
	rm -rf $(INSTALL_DIR)
	rm -f /usr/sbin/nvidia-prime-select
	rm -f /usr/lib/systemd/system/nvida-prime.service
	rm -f /etc/X11/xinit/xinitrc.d/nvidia
