#
# Copyright (C) 2010 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=debloat
PKG_VERSION:=1
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/debloat
  SECTION:=net
  CATEGORY:=Networking
  TITLE:=Debloating TX queue scripts
  MAINTAINER:=Dave Täht <d@taht.net>
  PKGARCH:=all
endef

define Package/debloat/description
  Reduce excessive TXQUEUELEN on devices (reduce bufferbloat)
endef

define Build/Compile
endef

define Build/Configure
endef

define Package/debloat/install
	$(INSTALL_DIR) $(1)/lib/network $(1)/etc/hotplug.d/iface $(1)/etc/config
	$(INSTALL_BIN) ./files/debloat.sh $(1)/lib/network/debloat.sh
	$(INSTALL_BIN) ./files/debloat.hotplug $(1)/etc/hotplug.d/iface/02-debloat
	$(INSTALL_BIN) ./files/ipv6fe80fix.hotplug $(1)/etc/hotplug.d/iface/01-fe80fix
	$(INSTALL_DATA) ./files/debloat.config $(1)/etc/config/debloat
endef

$(eval $(call BuildPackage,debloat))
