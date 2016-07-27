# beastieCO: Jails
To powerfully serve in an organized, logical manner.
## Table of Contents
- [Synopsis](#synopsis)
- [Background](#background)
- [ZFS Creation](#zfs-create)
- [Install EZJail](#install-ezjail)
- [Modify ezjail.conf](#modify-ezjail-config)
- [Install Base Jail](#install-base-jail)
- [Flavor or Profile](#flavor-or-profile)

## Synopsis
The aim of this document is to somewhat streamline and bring sense to creating jails. Code
samples are include when and where it makes sense.
## Background
Some things and stuff..

## ZFS Create
The way I have found most useful to create zfs for ezjail is something like this.

    $ zfs create -o mountpoint=/beastienas/local/jails ScoMachine/beastiejails
    $ chmod 700 /beastienas/local/jails/ && chown root:wheel /beastienas/local/jails/

This will actually 'add' the jails to an existing zpool (ScoMachine). 

## Install Ezjail
Basically either use ports or do a pkg install and get the ezjail on there.

    $ pkg install ezjail
    Updating FreeBSD repository catalogue...
    FreeBSD repository is up-to-date.
    All repositories are up-to-date.
    The following 1 package(s) will be affected (of 0 checked):
    
    New packages to be INSTALLED:
    	ezjail: 3.4.2
    
    Number of packages to be installed: 1
    
    43 KiB to be downloaded.
    
    Proceed with this action? [y/N]: y
    Fetching ezjail-3.4.2.txz: 100%   43 KiB  43.8kB/s    00:01    
    Checking integrity... done (0 conflicting)
    [1/1] Installing ezjail-3.4.2...
    [1/1] Extracting ezjail-3.4.2: 100%

## Modify Ezjail Config
It is probably best to just copy /usr/local/etc/ezjail.conf to /usr/local/etc/ezjail.conf.bak
then create a new file. For this use case there are only four lines, outside comments.

    mv /usr/local/etc/ezjail.conf /usr/local/etc/ezjail.conf.bak
    vi /usr/local/etc/ezjail.conf
    ezjail_jaildir=/beastienas/local/jails
    ezjail_use_zfs="YES"
    ezjail_jailzfs="ScoMachine/beastiejails"
    ezjail_ftphost=ftp2.jp.freebsd.org

The last one is important so that you can use the closest repo based on your location. The 
example file in the repo has a URL or you can just google for FreeBSD mirrors.

## Install Base Jail
Get ready for your coffee break, this make take some time depending on your setup. Basically
follow these steps and let it run.

    $ ezjail-admin install

Once you run this the host should ask you which release you want to use. There are cases
where you might want to run legacy BSDs. Select your release (or hit enter for the same
version that you are runing).


    Your system is 11.0-BETA1. Normally FTP-servers don't provide non-RELEASE-builds.
    Querying your ftp-server... The ftp server you specified (ftp2.jp.freebsd.org) seems to provide the following builds:
    drwxr-xr-x    2 ftp      ftp           165 Nov 12  2014 10.1-RELEASE
    drwxr-xr-x    2 ftp      ftp           165 Aug 12  2015 10.2-RELEASE
    drwxr-xr-x    2 ftp      ftp           165 Mar 25 03:25 10.3-RELEASE
    drwxr-xr-x    2 ftp      ftp           237 Jul 09 20:44 11.0-BETA1
    drwxr-xr-x    2 ftp      ftp           237 Jul 22 03:10 11.0-BETA2
    drwxr-xr-x    2 ftp      ftp           165 Jul 11  2014 9.3-RELEASE
    drwxr-xr-x    7 ftp      ftp            84 Jul 08 22:38 ISO-IMAGES
    Release to fetch [ 11.0-BETA1 ]: 
    base.txz                                      100% of   94 MB 2240 kBps 00m43s
    lib32.txz                                     100% of   18 MB 2316 kBps 00m08s
    Looking up update.FreeBSD.org mirrors... none found.
    Fetching public key from update.FreeBSD.org... done.
    Fetching metadata signature for 11.0-BETA1 from update.FreeBSD.org... done.
    Fetching metadata index... done.
    Fetching 2 metadata files... done.

This will list a bunch of things and stuff being installed and then should finish cleanly. If
you are so inclined you can checkout your zfs pool to see how much space was taken by this 
command. 

    $ zfs list
    ScoMachine/beastiejails            569M   334G   116K  /beastienas/local/jails
    ScoMachine/beastiejails/basejail   560M   334G   560M  /beastienas/local/jails/basejail
    ScoMachine/beastiejails/newjail   8.76M   334G  8.76M  /beastienas/local/jails/newjail

It should be pretty clear that the update created some new jail things and stuff.

## Flavor or Profile
Since FreeBSD uses flavour I decided to rebrand this a "profile." It seems logical does it not?
Something about falvour that has the British thing going on. In any case pay attention 
there will be two version here one, the original, two the neu (see that, a play on incorrect
spelling of words). 

This should be performed no matter what your choice is again I selected profiles in lieu
of flavours because it seems more standardized:

    $ mkdir -p /beastienas/local/jails/profiles/tokyo/etc/rc.d
    $ cd /beastienas/local/jails/profiles/tokyo/etc
    $ vi rc.conf
    sshd_enable="YES"
    syslogd_flags="-ss"
    $ cp -p /beastienas/local/jails/flavours/example/etc/rc.d/ezjail.flavour.example rc.d/ezjail.flavour.happycamper

Copy your resolv.conf into the zone so it can resolve dns things and stuff.

    $ cp /etc/resolv.conf .

Then copy a flavour into your profile:

    $ cp -p /beastienas/local/jails/flavours/example/etc/rc.d/ezjail.flavour.example rc.d/ezjail.profile.tokyo

Keep in mind, flavour to profile migration. It is more important than it seems. For some background
on this and why I changed it look here. Flavors are stored under $jailroot/flavours directory ($jailroot = /beastienas/local/jails). 
We went ahead and added both rc.conf and resolv.conf they will be copied to the new container with the TOKYO profile. 


