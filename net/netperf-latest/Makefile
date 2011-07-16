#
# Copyright (C) 2006-2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=netperf-latest
PKG_REV:=432
PKG_VERSION:=2.5.0r$(PKG_REV)
PKG_RELEASE:=2

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=http://www.netperf.org/svn/netperf2/trunk
PKG_SOURCE_PROTO:=svn
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=$(PKG_REV)

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/netperf-latest
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Network performance measurement tool
  URL:=http://www.netperf.org/
endef

define Package/netperf-latest/install
	$(INSTALL_DIR) $(1)/etc/xinetd.d
	$(INSTALL_BIN) ./files/netserver $(1)/etc/xinetd.d/
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/net{perf,server} $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/lib/netperf
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/doc/examples/*_script $(1)/lib/netperf/
endef

$(eval $(call BuildPackage,netperf-latest))
