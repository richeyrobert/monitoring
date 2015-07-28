# jul/28/2015 17:49:51 by RouterOS 6.30
# software id = RADC-BEI5
#
/interface ethernet
set [ find default-name=ether1 ] arp=proxy-arp name=ether1-WAN
set [ find default-name=ether2 ] name=ether2-local-mgmt
set [ find default-name=ether3 ] arp=proxy-arp name=ether3-MGMT
set [ find default-name=ether4 ] arp=proxy-arp name=ether4-LAN
set [ find default-name=ether5 ] master-port=ether4-LAN name=ether5-LAN-slave
/ip neighbor discovery
set ether1-WAN discover=false
/interface vlan
add interface=ether4-LAN l2mtu=1516 name=vlan220 vlan-id=220
add interface=ether1-WAN l2mtu=1516 name=vlan300 vlan-id=300
/ip pool
add name=default-dhcp ranges=192.168.88.10-192.168.88.254
add name=filtered ranges=10.150.6.51-10.150.6.254
add name=unfiltered ranges=10.150.7.51-10.150.7.254
/ip dhcp-server
add address-pool=default-dhcp disabled=false interface=ether2-local-mgmt \
    name=default
/ppp profile
add local-address=10.150.6.2 name=pppoe-profile use-encryption=yes use-mpls=\
    no
/routing ospf instance
set [ find default=true ] router-id=10.8.0.10
/snmp community
set [ find default=true ] name=gU5ewe7RuKUs
/interface pppoe-server server
add default-profile=pppoe-profile disabled=false interface=ether4-LAN \
    max-mru=1480 max-mtu=1480 mrru=1600 one-session-per-host=true \
    service-name=pppoe-server
/ip address
add address=192.168.88.1/24 comment="default configuration" interface=\
    ether2-local-mgmt network=192.168.88.0
add address=10.8.0.10/23 interface=vlan300 network=10.8.0.0
add address=10.8.10.1/24 interface=vlan220 network=10.8.10.0
add address=172.16.18.21/23 interface=ether3-MGMT network=172.16.18.0
add address=10.150.6.2/23 interface=ether1-WAN network=10.150.6.0
/ip dhcp-relay
add dhcp-server=199.21.205.250 disabled=false interface=vlan220 name=relay1
/ip dhcp-server network
add address=192.168.88.0/24 comment="default configuration" gateway=\
    192.168.88.1
/ip dns
set servers=199.21.205.250
/ip dns static
add address=192.168.88.1 name=router
/ip firewall filter
add chain=input comment="default configuration" protocol=icmp
add chain=input comment="default configuration" connection-state=\
    established,related
add action=drop chain=input comment="default configuration" in-interface=\
    ether1-WAN
add action=fasttrack-connection chain=forward comment="default configuration" \
    connection-state=established,related
add chain=forward comment="default configuration" connection-state=\
    established,related
add action=drop chain=forward comment="default configuration" \
    connection-state=invalid
add action=drop chain=forward comment="default configuration" \
    connection-nat-state=!dstnat connection-state=new in-interface=ether1-WAN
/ip firewall nat
add action=masquerade chain=srcnat comment="default configuration" \
    out-interface=ether1-WAN
/ip route
add distance=1 gateway=10.150.6.1
add distance=120 dst-address=10.10.90.0/24 gateway=172.16.18.1
add distance=1 dst-address=10.11.0.0/24 gateway=10.8.0.1
/ppp aaa
set use-radius=true
/radius
add address=10.8.0.8 secret=T0naqu1nt service=ppp
/routing ospf network
add area=backbone network=10.8.10.0/24
add area=backbone network=10.8.0.0/23
/snmp
set contact="Tonaquint Networks" enabled=true location=DXATC
/system clock
set time-zone-name=America/Denver
/system identity
set name="DXATC MikroTik"
/tool mac-server
set [ find default=true ] disabled=true
add interface=ether2-local-mgmt
add interface=ether3-MGMT
add interface=ether4-LAN
add interface=ether5-LAN-slave
/tool mac-server mac-winbox
set [ find default=true ] disabled=true
add interface=ether2-local-mgmt
add interface=ether3-MGMT
add interface=ether4-LAN
add interface=ether5-LAN-slave
/tool romon port
add
