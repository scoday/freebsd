#!/usr/local/bin/bash
#
# Some core steps to be leveraged
# Create jail directory with kernel
# DEFINE VARS:
POOL="fraroot"

#mkdir /usr/jails/32bitjail
createZ() {
#    zpool create $POOL/jails
    zfs create -o mountpoint=/usr/jails $POOL/jails
}

makeroot() {
    mkdir /usr/jails/core
    cd /usr/jails/core
    fetch ftp://ftp2.de.freebsd.org/pub/FreeBSD/releases/amd64/amd64/10.3-RELEASE/base.txz
    tar xpf base.txz
      rm -rf boot
      rm base.txz
}

netconfig() {
    ifconfig vr0 172.16.1.1 netmask 255.255.255.255 alias
    echo 'ifconfig_vr0_alias0="inet 172.16.1.1 netmask 255.255.255.255"' >> /etc/rc.conf
}

enable_tl() {
    echo 'jail_enable="YES"'
    echo 'jail_list="fravbox01"'
}

enable_jl() {
    echo 'jail_fravbox01_rootdir="/usr/jail/fravbox01"'
    echo 'jail_fravbox01_hostname="fra-vbox01.int.kumomon.com"'
    echo 'jail_fravbox01_ip="172.16.1.2"'
    echo 'jail_fravbox01_devfs_enable="YES"'
}

fravbox01_start() {
    /etc/rc.d/jail start fravbox01
    jls
}

#createZ
#makeroot
netconfig
enable_tl
enable_jl
fravbox01_start

#jexec 1 sh # replace 1 with the jid given by jls
#passwd # to set root pw
