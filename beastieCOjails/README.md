# beastieCO: Jails
To powerfully serve in an organized, logical manner.
## Table of Contents
- [Synopsis](#synopsis)
- [Background](#background)
- [ZFS Creation](#zfs-create)
- [Install EZJail](#install-ezjail)

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
