#!/bin/bash
cd /var/lib/libvirt/images/
cp .node_base.qcow2 nsd07.qcow2
cd /etc/libvirt/qemu/
url=/etc/libvirt/qemu/nsd07.xml
virsh dumpxml server > $url
sed -i '2s/server/nsd07/' $url &> /dev/null
sed -i '3d;51d' $url &> /dev/null
sed -i '32s/.node_tedu.qcow2/nsd07.qcow2/' $url &> /dev/null
virsh  define $url
cd ~
