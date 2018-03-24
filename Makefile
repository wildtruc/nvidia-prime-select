INSTALL_DIR = /etc/nvidia-prime

.PHONY: all install update uninstall

all: install

install:
	mkdir -p $(INSTALL_DIR)
	install -Dm755 -t /usr/bin/ nvidia-prime-ui
	install -Dm755 -t /usr/sbin/ nvidia-prime-select
	install -Dm644 -t $(INSTALL_DIR)/ xorg.nvidia.conf
	install -Dm644 -t $(INSTALL_DIR)/ xorg.intel.conf
	install -Dm644 -t $(INSTALL_DIR)/ rc.local
	install -Dm644 -t $(INSTALL_DIR)/ rc.nvidia
	install -Dm644 -t $(INSTALL_DIR)/ library.conf
	install -Dm644 -t /usr/share/pixmaps/ nvidia-prime.png
	install -Dm644 -t /usr/share/applications/ nvidia-prime-ui.desktop
	install -Dm644 -t /usr/lib/systemd/system/ nvidia-prime.service
	install -Dm644 -t /usr/share/polkit-1/actions/ com.github.pkexec.nvidia-prime-select.policy
	install -Dm644 -t /usr/share/polkit-1/actions/ com.github.pkexec.nvidia-prime-editor.policy
	systemctl enable nvidia-prime.service

update:
	install -C -Dm755 -t /usr/bin/ nvidia-prime-ui
	install -C -Dm755 -t /usr/sbin/ nvidia-prime-select
	install -Dm644 -t /usr/share/pixmaps/ nvidia-prime.png
	install -Dm644 -t /usr/share/applications/ nvidia-prime-ui.desktop
	install -C -Dm644 -t /usr/lib/systemd/system/ nvidia-prime.service
	install -C -Dm644 -t /usr/share/polkit-1/actions/ com.github.pkexec.nvidia-prime-select.policy
	install -C -Dm644 -t /usr/share/polkit-1/actions/ com.github.pkexec.nvidia-prime-editor.policy
	systemctl restart nvidia-prime.service


uninstall:
	systemctl disable nvidia-prime.service
	rm -rf $(INSTALL_DIR)
	rm -f /usr/sbin/nvidia-prime-select
	rm -f /usr/bin/nvidia-prime-ui
	rm -f /usr/share/pixmaps/nvidia-prime.png
	rm -f /usr/share/applications/nvidia-prime-ui.desktop
	rm -f /usr/lib/systemd/system/nvidia-prime.service
	rm -f /usr/share/polkit-1/actions/com.github.pkexec.nvidia-prime-*
	rm -f /etc/X11/xinit/xinitrc.d/nvidia
