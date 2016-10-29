dnf download --resolve broadcom-wl "kernel-devel-uname-r == $(uname -r)" -y && rm kmod*.rpm
