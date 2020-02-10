#!/bin/bash
# LICENSE UPL 1.0
#
# Copyright (c) 1982-2016 Oracle and/or its affiliates. All rights reserved.
#
# Since: December, 2016
# Author: gerald.venzl@oracle.com
# Description: Sets up the unix environment for DB installation.
# 
# DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS HEADER.
# 

# Setup filesystem and oracle user
# Adjust file permissions, go to /opt/oracle as user 'oracle' to proceed with Oracle installation
# ------------------------------------------------------------
mkdir -p $ORACLE_BASE/oradata && \
chmod ug+x $ORACLE_BASE/*.sh && \
yum install -y openssl binutils compat-libcap1 compat-libstdc++-33 gcc-c++ gcc glibc glibc-devel elfutils-libelf-devel elfutils-libelf-devel-static ksh libaio libaio-devel libgcc libstdc++ libstdc++-devel libXi libXtst make sysstat unixODBC unixODBC-devel glibc.i686 unzip sudo && \
rm -rf /var/cache/yum && \
groupadd oinstall && \
groupadd dba && \
useradd -g oinstall -G dba -d /home/oracle oracle && \
echo "oracle ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
mkdir -p $ORACLE_HOME && \
mkdir -p $ORACLE_BASE/oradata && \
mkdir -p $ORACLE_BASE/oraInventory && \
chown -R oracle:oinstall $ORACLE_BASE/product && \
chown -R oracle:oinstall $ORACLE_BASE/oraInventory && \
chown -R oracle:oinstall $ORACLE_BASE/oradata && \
chmod -R 775 $ORACLE_BASE/product && \
chmod -R 775 $ORACLE_BASE/oradata && \
chmod -R 775 $ORACLE_BASE/oraInventory && \
echo oracle:oracle | chpasswd &&\
chown -R oracle:oinstall $ORACLE_BASE && \
echo "oracle      soft  stack      10240">> /etc/security/limits.conf
