#! /bin/bash

USER=$(/usr/bin/whoami)
echo "Configuring as: ${USER}"
echo

echo "============================================="
echo "Setting up Repositories"
echo "============================================="

echo "Installing EPEL as a prequiste for Nordugrid Repos"
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

echo "Adding Proxy for CVMFS"
echo "CVMFS_HTTP_PROXY='http://lawn.ppe.gla.ac.uk:3128'" >> /etc/cvmfs/default.local


echo "============================================="
echo "Adding Environment Variables to .bashrc"
echo "============================================="

echo "Adding X509 paths"
echo "export X509_USER_CERT=/vagrant/usercert.pem" >> /home/vagrant/.bashrc
echo "export X509_USER_KEY=/vagrant/userkey.pem" >> /home/vagrant/.bashrc


echo "============================================="
echo "Finished"
echo "============================================="
