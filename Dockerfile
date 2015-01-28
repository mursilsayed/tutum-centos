FROM centos:centos7
MAINTAINER Mursil Sayed <mursilsayed@gmail.com>
#Custom centos7 image with SSH support and a startup script that launches sshd



# Install packages and set up sshd
RUN yum -y install openssh-server telnet openssh-clients python-meld3 python-setuptools passwd hostname net-tools && easy_install supervisor && yum clean all
RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key && ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key && sed -i "s/#UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config && echo "root:root"|chpasswd


# Supervisord Install
 
ADD supervisord.conf /etc/supervisord.conf

RUN mkdir -p /var/log/supervisor && sed -i -e 's/nodaemon=false/nodaemon=true/' /etc/supervisord.conf

EXPOSE 22

CMD supervisord -c /etc/supervisord.conf




