from centos/systemd

arg repo=http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.2.2.0/ambari.repo
arg ambari_user=root

volume /build

run yum update -y
run yum install -y wget openssh-clients krb5-workstation
run cp /etc/krb5.conf /etc/krb5.conf.original
run wget $repo -O /etc/yum.repos.d/ambari.repo
run yum clean all

run yum install -y ambari-server

add setup.sh /root/
run chmod +x /root/setup.sh
run /root/setup.sh $ambari_user

add start.sh /root/start.sh
run chmod +x /root/start.sh

expose 8080
entrypoint  ["/root/start.sh"]
