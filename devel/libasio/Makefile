#
# Copyright (C) 2012 OpenWrt.org
# Copyright (C) 2012 Daniel Pocock <daniel@pocock.com.au>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=asio
PKG_VERSION:=1.4.8
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/asio-$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=@SF/asio
PKG_MD5SUM:=0e2ebaa1e5569e415908c8d0ede95044

#PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

#TARGET_CFLAGS += $(FPIC)

define Package/libasio
  SECTION:=libs
  CATEGORY:=Libraries
  DEFAULT:=n
  TITLE:=libasio
  URL:=http://think-async.com/
  DEPENDS:=+boost
endef

define Package/libasio/description
 Async IO library
endef

define Build/Configure
	$(call Build/Configure/Default, --enable-maintainer-mode )
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR)/include
endef

define Package/libasio/install
	$(MAKE) DESTDIR=$(PKG_INSTALL_DIR) -C $(PKG_BUILD_DIR)/include install
endef

define Build/InstallDev
	$(MAKE) DESTDIR=$(1) -C $(PKG_BUILD_DIR)/include install
#	$(INSTALL_DIR) $(1)/usr/include/asio
#	$(CP) $(PKG_INSTALL_DIR)/usr/include/asio.hpp $(1)/usr/include/
#	$(CP) $(PKG_BUILD_DIR)/usr/include/asio/* $(1)/usr/include/asio/
endef

$(eval $(call BuildPackage,libasio))

