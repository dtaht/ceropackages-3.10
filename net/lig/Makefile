#
# Copyright (C) 2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=lig
PKG_REV:=d05e2629b59feb796fa7ca37765ee4fedceb049c
PKG_VERSION:=20101215
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=git://github.com/davidmeyer/lig.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=$(PKG_REV)

include $(INCLUDE_DIR)/package.mk

define Package/lig
  SECTION:=net
  CATEGORY:=Network
  TITLE:=LISP Internet Groper
  URL:=https://github.com/davidmeyer/lig
endef

define Package/lig/description
  lig is a tool that can be used to query the LISP mapping database
endef

define Package/lig/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/lig $(1)/usr/bin/
endef

$(eval $(call BuildPackage,lig))
