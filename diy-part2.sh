#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

#1 Modify default IP
sed -i 's/192.168.1.1/192.168.1.5/g' package/base-files/files/bin/config_generate

#2. Clear the login password
sed -i 's/$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.//g' package/lean/default-settings/files/zzz-default-settings

#3. Replace with JerryKuKu’s Argon
rm feeds/luci/themes/luci-theme-argon -rf
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git feeds/luci/themes/luci-theme-argon
sed -i 's/luci-theme-bootstrap/luci-theme-argon/' feeds/luci/collections/luci/Makefile

# 修正lxc下使用连接数显示
sed -i 's/net.nf_conntrack_max/net.netfilter.nf_conntrack_max/' feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_status/index.htm

# 修正lxc下使用网络接口显示
sed -i '/^a=/ca=$(ip address | grep ^[0-9] | awk -F: '"'"'{print $2}'"'"' | sed "s/ //g" | grep '"'"'^eth'"'"' | awk -F"@" '"'"'{print $1}'"'"')' package/lean/autocore/files/x86/sbin/ethinfo

#sirpdboy
#git clone https://github.com/sirpdboy/luci-theme-opentopd.git package/luci-theme-opentopd
git clone https://github.com/sirpdboy/luci-app-advanced.git package/luci-app-advanced
git clone https://github.com/sirpdboy/netspeedtest.git package/netspeedtest
git clone https://github.com/sirpdboy/luci-app-netdata.git package/luci-app-netdata
git clone https://github.com/sirpdboy/luci-app-poweroffdevice.git package/luci-app-poweroffdevice
git clone https://github.com/sirpdboy/luci-app-autotimeset.git package/luci-app-autotimeset


#修正连接数（by ベ七秒鱼ベ）
sed -i '/customized in this file/a net.netfilter.nf_conntrack_max=165535' package/base-files/files/etc/sysctl.conf

# themes添加（svn co 命令意思：指定版本如https://github）
#git clone https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom package/luci-theme-infinityfreedom
#git clone https://github.com/Leo-Jo-My/luci-theme-opentomcat.git package/luci-theme-opentomcat
#git clone https://github.com/openwrt-develop/luci-theme-atmaterial.git package/luci-theme-atmaterial

git clone https://github.com/kiddin9/luci-app-dnsfilter.git package/luci-app-dnsfilter

#git clone https://github.com/garypang13/luci-app-bypass package/luci-app-bypass
#git clone https://github.com/kenzok8/openwrt-packages.git package/openwrt-packages

#添加额外非必须软件包
git clone https://github.com/rufengsuixing/luci-app-adguardhome.git package/luci-app-adguardhome

# istore
#echo >> feeds.conf.default
#echo 'src-git istore https://github.com/linkease/istore;main' >> feeds.conf.default
#./scripts/feeds update istore
#./scripts/feeds install -d y -p istore luci-app-store

