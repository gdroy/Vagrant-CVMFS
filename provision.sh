#! /bin/bash

USER=$(/usr/bin/whoami)
echo "Configuring as: ${USER}"
echo

echo "============================================="
echo "Setting up Repositories"
echo "============================================="

echo "Installing EPEL as a prequiste for CVMFS"
yum -y install epel-release

echo "Installing CVMFS Repository"

cat > /etc/yum.repos.d/cernvm.repo <<"EOF"
[cernvm]
name=CernVM packages
baseurl=http://cvmrepo.web.cern.ch/cvmrepo/yum/cvmfs/EL/$releasever/$basearch/
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CernVM
gpgcheck=0
enabled=1
protect=1
EOF

yum clean all

echo "============================================="
echo "Installing Packages"
echo "============================================="

echo "Install CVMFS config and clients"
yum -y install cvmfs cvmfs-config-default

echo "============================================="
echo "Configuring CVMFS"
echo "============================================="

CVMFS_PROXY=DIRECT
#Set a specific proxy for a site below
#CVMFS_PROXY='http://myproxylocation:3128'

echo "Adding Proxy for CVMFS ($CVMFS_PROXY)"
echo "CVMFS_HTTP_PROXY=$CVMFS_PROXY" >> /etc/cvmfs/default.local

echo "Setting up BIND mounts for CVMFS"
mkdir -p /cvmfs/atlas-condb.cern.ch
mkdir -p /cvmfs/atlas.cern.ch
mkdir -p /cvmfs/cernvm-prod.cern.ch
mkdir -p /cvmfs/grid.cern.ch
mkdir -p /cvmfs/sft.cern.ch

echo "Adding entries to FSTAB"
echo "atlas-condb.cern.ch   /cvmfs/atlas-condb.cern.ch      cvmfs       defaults    0 0" >> /etc/fstab
echo "atlas.cern.ch         /cvmfs/atlas.cern.ch            cvmfs       defaults    0 0" >> /etc/fstab
echo "cernvm-prod.cern.ch   /cvmfs/cernvm-prod.cern.ch      cvmfs       defaults    0 0" >> /etc/fstab
echo "grid.cern.ch          /cvmfs/grid.cern.ch             cvmfs       defaults    0 0" >> /etc/fstab
echo "sft.cern.ch           /cvmfs/sft.cern.ch              cvmfs       defaults    0 0" >> /etc/fstab
mount -a

echo "============================================="
echo "Adding Environment Variables to .bashrc"
echo "============================================="

echo "Adding X509 paths"
echo "export X509_USER_CERT=/vagrant/usercert.pem" >> /home/vagrant/.bashrc
echo "export X509_USER_KEY=/vagrant/userkey.pem" >> /home/vagrant/.bashrc

echo "Adding Atlas Paths"
echo "export ATLAS_LOCAL_ROOT_BASE=/cvmfs/atlas.cern.ch/repo/ATLASLocalRootBase" >> /home/vagrant/.bashrc
echo 'alias setupATLAS="source ${ATLAS_LOCAL_ROOT_BASE}/user/atlasLocalSetup.sh"' >> /home/vagrant/.bashrc


echo "============================================="
echo "Finished"
echo "============================================="
