Vagrant - CVMFS
===============

A simple Vagrantfile that sets up a Centos7 VM with access to the CVMFS filesystem for ATLAS testing. In this setup CVMFS is configured to use Bind mounts as this is required for working with CVMFS within Docker container images. A more flexible solution can be achived by configuring AutoFS appropriately.

Usage
=====

Create your virtual machine:
```
 vagrant up
```
Log into your virtual machine:
```
 vagrant ssh
```
Configure ATLAS
```
 setupATLAS
```

