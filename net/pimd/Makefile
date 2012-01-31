#
# Copyright (C) 2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=pimd
PKG_VERSION:=2.1.8
PKG_RELEASE:=2

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=https://github.com/downloads/troglobit/pimd/$(PKG_SOURCE)
PKG_MD5SUM:=a12448bc7c9bfcebf51a13ebf1ffa962

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/pimd
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Routing and Redirection
  TITLE:=a PIMv2 compliant routing daemon
  URL:=http://github.com/troglobit/pimd
endef

define Package/pimd/description
 Pimd is implementation of Protocol Independent Multicast routing daemon.
 It supports PIMv2-SM on FreeBSD, NetBSD, OpenBSD, Linux. Enable PIM support
 in kernel is needed.
endef

define Package/pimd/conffiles
/etc/pimd.conf
endef

MAKE_FLAGS += \
	prefix="/usr"

define Package/pimd/install
	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_CONF) $(PKG_INSTALL_DIR)/etc/pimd.conf $(1)/etc/
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/pimd.init $(1)/etc/init.d/pimd
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/pimd $(1)/usr/sbin/
endef

$(eval $(call BuildPackage,pimd))
