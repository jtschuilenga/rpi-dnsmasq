# rpi-dnsmasq
DNSMASQ, DHCP and DNS server for Raspberry

# dnsmasq

The DHCP/DNS functionality is provided by  [dnsmasq](http://www.thekelleys.org.uk/dnsmasq/doc.html).

Provided here is a minimal [docker](https://www.docker.com/) image for raspberry designed to configure itself from a mapped directory of `.conf` files.

## How to use

Starting a container from this image is simple. We run it directly on the host's network stack so the host can act as a DNS for other services in the network.

```
docker run --name dnsmasq --cap-add=NET_ADMIN --net=host -restart:always -v /etc/dnsmasq:/etc/dnsmasq jtschuilenga/rpi-dnsmasq
```

We can then add multiple `.conf` files to the `/etc/dnsmasq` folder to provide layered configuration. This layering is useful to allow multiple services to add their own configuration files.
```
# 0.base.conf

domain-needed
bogus-priv
no-hosts
keep-in-foreground
no-resolv
expand-hosts
server=8.8.8.8
server=8.8.4.4
```
```
#dhcphosts.conf
# static dhcp entries
#dnsmasq will also add the devicenames/adresses to DNS
dhcp-host=aa:bb:cc:dd:ee:f1,192.168.1.1,router,12h
dhcp-host=aa:bb:cc:dd:ee:f2,192.168.1.2,NAS1,12h
dhcp-host=aa:bb:cc:dd:ee:f3,192.168.1.3,NAS2,12h
dhcp-host=aa:bb:cc:dd:ee:f4,192.168.1.4,printer,12h
dhcp-host=aa:bb:cc:dd:ee:f5,192.168.1.5,raspberry, 12h
