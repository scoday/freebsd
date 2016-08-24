#!/usr/local/bin/bash
#
# Used to fetch bsd release

LOCALE="de"
RELEASE="10.3-RELEASE"
URL="ftp.$LOCALE.freebsd.org/pub/FreeBSD/releases/amd64/$RELEASE/"
ART1="base.txz"
ART2="lib32.txz"
ART3="ports.txz"
ZONE="fravbox04"
FQDN="int.kumomon.com"
ZFSROOT="fraroot"
ZFSZONE="/usr/jails/$ZONE"
IP="172.16.1.7"
MASK="32"

create() {
    zfs create $ZFSROOT/jails/$ZONE
}

get() {
    fetch ftp://$URL$ART1 -o /tmp/$ART1
    fetch ftp://$URL$ART2 -o /tmp/$ART2
    fetch ftp://$URL$ART3 -o /tmp/$ART3
}

extract() {
    tar -xvf /tmp/$ART1 -C $ZFSZONE
    tar -xvf /tmp/$ART2 -C $ZFSZONE
    tar -xvf /tmp/$ART3 -C $ZFSZONE
}

update() {
    env UNAME_r=$RELEASE  freebsd-update -b $ZFSZONE fetch install
}

fix() {
    cp /etc/resolv.conf $ZFSZONE/etc/resolv.conf
    cp /etc/localtime $ZFSZONE/etc/localtime
    echo "hostname=$ZONE.$FQDN" > $ZFSZONE/etc/rc.conf
}

jailentry() {
    echo "$ZONE {" >> /etc/jail.conf
    echo "	    host.hostname = \"$ZONE.$FQDN\";" >> /etc/jail.conf
    echo "	    ip4.addr += \"$IP/$MASK\";" >> /etc/jail.conf
    echo "}" >> /etc/jail.conf
}

mkjail() {
    jail -c $ZONE
}

create
get
extract
update
fix
jailentry
mkjail

