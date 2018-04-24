INSTALL_DIR = /etc/nvidia-prime
#C_USER = $(shell ls -l "$(shell pwd)"| cut -d' ' -f3 | sed -n "2p")
#USER_DIR = /home/$(C_USER)

.PHONY: all install update uninstall

all: install

install:
	mkdir -p $(INSTALL_DIR)
	install -Dm755 -t /usr/bin/ nvidia-prime-ui
	install -Dm755 -t /usr/sbin/ nvidia-prime-select
	install -Dm644 -t $(INSTALL_DIR)/ xorg.nvidia.conf
	install -Dm644 -t $(INSTALL_DIR)/ xorg.intel.conf
	install -Dm644 -t $(INSTALL_DIR)/ library.conf
	install -Dm644 -t $(INSTALL_DIR)/ options.conf
	install -Dm644 -t $(INSTALL_DIR)/ report.sample
	install -Dm644 -t $(INSTALL_DIR)/ nvidia-prime.desktop
	install -Dm644 -t $(INSTALL_DIR)/ nvidia-session.desktop
	install -Dm644 -t /usr/share/pixmaps/ nvidia-prime.png
	install -Dm644 -t /usr/share/applications/ nvidia-prime-ui.desktop
	install -Dm644 -t /usr/share/polkit-1/actions/ com.github.pkexec.nvidia-prime-select.policy
	install -Dm644 -t /usr/share/polkit-1/actions/ com.github.pkexec.nvidia-prime-editor.policy
	sh ./changelog.sh

update:
#	sh ./changelog.sh
	install -C -Dm755 -t /usr/bin/ nvidia-prime-ui
	install -C -Dm755 -t /usr/sbin/ nvidia-prime-select
	install -C -Dm644 -t $(INSTALL_DIR)/ xorg.nvidia.conf
	install -C -Dm644 -t $(INSTALL_DIR)/ xorg.intel.conf
	install -Dm644 -t $(INSTALL_DIR)/ options.conf
	install -Dm644 -t $(INSTALL_DIR)/ report.sample
	install -C -Dm644 -t $(INSTALL_DIR)/ nvidia-prime.desktop
	install -C -Dm644 -t $(INSTALL_DIR)/ nvidia-session.desktop
	install -Dm644 -t /usr/share/pixmaps/ nvidia-prime.png
	install -Dm644 -t /usr/share/applications/ nvidia-prime-ui.desktop
	install -C -Dm644 -t /usr/share/polkit-1/actions/ com.github.pkexec.nvidia-prime-select.policy
	install -C -Dm644 -t /usr/share/polkit-1/actions/ com.github.pkexec.nvidia-prime-editor.policy
	sh ./changelog.sh

uninstall:
	rm -rf $(INSTALL_DIR)
	rm -f /usr/sbin/nvidia-prime-select
	rm -f /usr/bin/nvidia-prime-ui
	rm -f /usr/share/pixmaps/nvidia-prime.png
	rm -f /usr/share/applications/nvidia-prime-ui.desktop
	rm -f /usr/share/polkit-1/actions/com.github.pkexec.nvidia-prime-*
#	rm -f /etc/X11/xorg.conf
