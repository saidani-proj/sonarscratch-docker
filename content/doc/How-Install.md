# How install SONARSCRATCH

You can follow theses steps to install *SONARSCRATCH* :

1. Install [**docker**](https://www.docker.com). Docker is available for Windows, MacOS and Linux. You can install it following this [link](https://docs.docker.com/install).

1. Check your docker installation using this command `docker --version`. If docker correctly installed, you should see the version, like this `Docker version 18.06.1-ce, build e68fc7a`.

1. Install *SONARSCRATCH*. Actually available only for Linux as [debian package](../dist/debian/packages/sn-scratch_1.0.0_all.deb). Download the debian package (**sn-scratch_1.0.0_all.deb**) and execute
this command in same directory `sudo dpkg -i sn-scratch_1.0.0_all.deb`.

1. To check your installation, run this command `sn-scratch --version`, you should see the version, like
this `1.0.0`.
