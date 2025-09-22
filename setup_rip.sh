# Hosts
h1 ifconfig h1-eth0 10.0.1.2/24
h1 ip route add default via 10.0.1.1

h2 ifconfig h2-eth0 10.0.2.2/24
h2 ip route add default via 10.0.2.1

# Routers
r1 ifconfig r1-eth0 10.0.12.1/24
r1 ifconfig r1-eth1 10.0.13.1/24
r1 ifconfig r1-eth2 10.0.61.1/24
r1 ifconfig r1-eth3 10.0.1.1/24
r1 sysctl -w net.ipv4.ip_forward=1
r1 bash -c 'echo "
frr defaults datacenter
hostname r1
router rip
 version 2
 network 10.0.0.0/16
" > /etc/frr/frr.conf'
r1 /usr/lib/frr/frrinit.sh start

r2 ifconfig r2-eth0 10.0.12.2/24
r2 sysctl -w net.ipv4.ip_forward=1
r2 bash -c 'echo "
frr defaults datacenter
hostname r2
router rip
 version 2
 network 10.0.0.0/16
" > /etc/frr/frr.conf'
r2 /usr/lib/frr/frrinit.sh start

r3 ifconfig r3-eth0 10.0.13.3/24
r3 ifconfig r3-eth1 10.0.34.3/24
r3 sysctl -w net.ipv4.ip_forward=1
r3 bash -c 'echo "
frr defaults datacenter
hostname r3
router rip
 version 2
 network 10.0.0.0/16
" > /etc/frr/frr.conf'
r3 /usr/lib/frr/frrinit.sh start

r4 ifconfig r4-eth0 10.0.34.4/24
r4 ifconfig r4-eth1 10.0.45.4/24
r4 ifconfig r4-eth2 10.0.2.1/24
r4 sysctl -w net.ipv4.ip_forward=1
r4 bash -c 'echo "
frr defaults datacenter
hostname r4
router rip
 version 2
 network 10.0.0.0/16
" > /etc/frr/frr.conf'
r4 /usr/lib/frr/frrinit.sh start

r5 ifconfig r5-eth0 10.0.45.5/24
r5 ifconfig r5-eth1 10.0.56.5/24
r5 sysctl -w net.ipv4.ip_forward=1
r5 bash -c 'echo "
frr defaults datacenter
hostname r5
router rip
 version 2
 network 10.0.0.0/16
" > /etc/frr/frr.conf'
r5 /usr/lib/frr/frrinit.sh start

r6 ifconfig r6-eth0 10.0.56.6/24
r6 ifconfig r6-eth1 10.0.61.6/24
r6 sysctl -w net.ipv4.ip_forward=1
r6 bash -c 'echo "
frr defaults datacenter
hostname r6
router rip
 version 2
 network 10.0.0.0/16
" > /etc/frr/frr.conf'
r6 /usr/lib/frr/frrinit.sh start
