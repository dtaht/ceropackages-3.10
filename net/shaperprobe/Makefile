#
# Copyright (C) 2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=shaperprobe
PKG_VERSION:=1.0
PKG_RELEASE:=1


PKG_SOURCE:=$(PKG_NAME).tgz
PKG_SOURCE_URL:=http://netinfer.com/diffprobe
PKG_MD5SUM:=d555ace1f2e8d86ce2975457b09b17b7

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/shaperprobe
	SECTION:=net
	CATEGORY:=Network
	TITLE:=DiffProbe Shaper Module used to detect traffic shaping
	URL:=http://www.cc.gatech.edu/~partha/diffprobe/shaperprobe.html
endef

define Package/shaperprobe/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/prober $(1)/usr/bin/prober
endef

$(eval $(call BuildPackage,shaperprobe))
