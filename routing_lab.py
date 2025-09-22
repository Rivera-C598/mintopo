#!/usr/bin/env python3
from ipmininet.iptopo import IPTopo
from ipmininet.ipnet import IPNet
from ipmininet.cli import IPCLI
from ipmininet.router.config import RouterConfig, OSPF, RIP
import argparse


class RoutingLabTopo(IPTopo):
    def __init__(self, protocol="ospf", *args, **kwargs):
        self.protocol = protocol.lower()
        super().__init__(*args, **kwargs)

    def build(self, *args, **kwargs):
        # Choose routing protocol (OSPF or RIP)
        if self.protocol == "ospf":
            rconf = OSPF
        elif self.protocol == "rip":
            rconf = RIP
        else:
            raise Exception("Unknown protocol: choose ospf or rip")

        # Routers
        r1, r2, r3, r4, r5, r6 = self.addRouters(
            "r1", "r2", "r3", "r4", "r5", "r6",
            config=rconf
        )

        # Hosts
        h1 = self.addHost("h1")
        h2 = self.addHost("h2")

        # Inter-router links (with igp_cost for OSPF)
        self.addLink(r1, r2, igp_cost=2)
        self.addLink(r1, r3, igp_cost=5)
        self.addLink(r3, r4, igp_cost=1)
        self.addLink(r4, r5, igp_cost=2)
        self.addLink(r5, r6, igp_cost=3)
        self.addLink(r6, r1, igp_cost=4)

        # Host links (passive for OSPF/RIP)
        self.addLink(r1, h1, igp_passive=True)
        self.addLink(r4, h2, igp_passive=True)

        super().build(*args, **kwargs)


def main():
    parser = argparse.ArgumentParser(description="Routing Lab Topology")
    parser.add_argument(
        "--protocol", choices=["ospf", "rip"], default="ospf",
        help="Choose the routing protocol (ospf or rip). Default: ospf"
    )
    args = parser.parse_args()

    net = IPNet(topo=RoutingLabTopo(protocol=args.protocol))
    try:
        net.start()
        IPCLI(net)
    finally:
        net.stop()


if __name__ == "__main__":
    main()
