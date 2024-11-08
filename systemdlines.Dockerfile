CMD ["/sbin/init"]

STOPSIGNAL SIGRTMIN+3

#mask systemd-machine-id-commit.service - partial fix for https://bugzilla.redhat.com/show_bug.cgi?id=1472439
RUN systemctl mask systemd-remount-fs.service dev-hugepages.mount sys-fs-fuse-connections.mount systemd-logind.service getty.target console-getty.service systemd-udev-trigger.service systemd-udevd.service systemd-random-seed.service systemd-machine-id-commit.service

RUN dnf -y install procps-ng && dnf clean all; rm -rf /var/cache/* /var/log/dnf* /var/log/yum.*


# Potential ubuntu version
# Use an official Ubuntu base image
FROM ubuntu:latest

# Update and install systemd and other necessary packages
RUN apt-get update && apt-get install -y systemd

# Mask unnecessary or problematic systemd services
RUN systemctl mask \
    systemd-remount-fs.service \
    sys-fs-fuse-connections.mount \
    getty.target \
    console-getty.service \
    systemd-udevd.service \
    systemd-udev-trigger.service \
    systemd-random-seed.service

# Install additional utilities
RUN apt-get install -y procps && apt-get clean && \
    rm -rf /var/lib/apt/lists/* /var/cache/* /var/log/dpkg.log /var/log/apt/*

# Use /sbin/init as the entry point, which should be systemd
CMD ["/sbin/init"]

# Set stop signal for systemd
STOPSIGNAL SIGRTMIN+3
