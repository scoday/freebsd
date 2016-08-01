# beastieCO: ELK in Jails
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
## Background


## Install The ELK
These sections can clearly all be done with a one liner, but just so you see each piece of the elk stack I broke them out. 

One liner:
    pkg install -y elasticsearch logstash kibana45

### Process
    pkg install -y elasticsearch
    Please see /usr/local/etc/elasticsearch for sample versions of
    elasticsearch.yml and logging.yml.

### Install Logstash
    pkg install -y logstash

### Install Kibana
    pkg install -y kibana45

## Post installation steps
Enable the various pieces with the requisite rc.conf entries:
    sysrc elasticsearch_enable=YES
    sysrc logstash_enable=YES
