# beastieCO: Jails
To powerfully serve in an organized, logical manner.
## Synopsis
The aim of this document is to somewhat streamline and bring sense to creating jails. Code
samples are include when and where it makes sense.
## Background
Some things and stuff..

- [ZFS Creation](#zfs-create)


## ZFS Create
The way I have found most useful to create zfs for ezjail is something like this.

    $ zfs create -o mountpoint=/beastienas/local/jails ScoMachine/beastiejails
    $ chmod 700 /beastienas/local/jails/ && chown root:wheel /beastienas/local/jails/

This will actually 'add' the jails to an existing zpool (ScoMachine). 
