#
# Copyright (C) 2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=jansson
PKG_VERSION:=2.1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=http://www.digip.org/jansson/releases
PKG_MD5SUM:=a7830e5b104fe6d95643516a625436f9

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/libjansson
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=Library for encoding, decoding and manipulating JSON data
  URL:=http://www.digip.org/jansson/
endef

define Package/libjansson/description
  Jansson is a C library for encoding, decoding and manipulating JSON data.
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_INSTALL_DIR)/usr/include/*.h $(1)/usr/include/
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libjansson.{a,la,so*} $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/lib/pkgconfig/jansson.pc \
		$(1)/usr/lib/pkgconfig/
endef

define Package/libjansson/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libjansson.so.* $(1)/usr/lib/
endef

$(eval $(call BuildPackage,libjansson))
