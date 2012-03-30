#
# Copyright (C) 2010 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=alttcp
PKG_VERSION:=1
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/alttcp
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Enable Alternate TCP Algos at run time
  MAINTAINER:=Dave Täht <dave.taht@bufferbloat.net>
  PKGARCH:=all
endef

define Package/alttcp/description
	Enable Alternate TCP congestion control algorithms
	that can be selected at run time by various applications.
endef

define Build/Compile
endef

define Build/Configure
endef

define Package/alttcp/install
	$(INSTALL_DIR) $(1)/etc/config $(1)/etc/init.d
	$(INSTALL_BIN) ./files/alttcp.init $(1)/etc/init.d/alttcp
	$(INSTALL_DATA) ./files/alttcp.conf $(1)/etc/config/alttcp
endef

$(eval $(call BuildPackage,alttcp))
