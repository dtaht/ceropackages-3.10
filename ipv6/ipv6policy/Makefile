#
# Copyright (C) 2010 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=ipv6policy
PKG_VERSION:=1
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/ipv6policy
  SECTION:=ipv6
  CATEGORY:=IPv6
  DEPENDS:=+ip +kmod-ipv6 +openssl-util
  TITLE:=IPv6 configuration and policy routing for ipv6 tunnels and interfaces
  MAINTAINER:=Dave Täht <d@teklibre.org>
  PKGARCH:=all
endef

define Package/ipv6policy/description
Provides support for enabling ipv6 addressing via various means, and
policy routing of various types of ipv6 tunnels
endef

define Build/Compile
endef

define Build/Configure
endef

define Package/ipv6policy/install
	$(INSTALL_DIR) $(1)/lib/network
	$(INSTALL_DATA) ./files/ipv6policy.sh $(1)/lib/network/ipv6policy.sh
	$(INSTALL_DIR) $(1)/etc/hotplug.d/iface
	$(INSTALL_DATA) ./files/ipv6policy.hotplug $(1)/etc/hotplug.d/iface/90-ipv6policy
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_BIN ./files/ipv6policy.config $(1)/etc/config/ipv6policy
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN ./files/generate-rfc4193-addr $(1)/usr/sbin
endef

$(eval $(call BuildPackage,ipv6policy))
