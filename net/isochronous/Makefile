# 
# Copyright (C) 2007-2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=isochronous
PKG_VERSION:=1.0.5.3

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/dtaht/isochronous
PKG_REV:=3f82575816116e73443394b9175e8ef9f3f9ddee
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=$(PKG_REV)

include $(INCLUDE_DIR)/package.mk

define Package/isochronous
  SUBMENU:=Test
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Tools for testing bursty isochronous behaviors
  URL:=https://gfiber.googlesource.com/vendor/google/platform
  MAINTAINER:=Dave Taht <dave.taht@bufferbloat.net>
  DEPENDS+=+librt
endef

define Package/isochronous/description
	isoping and udpburst are two tools written by Avery Pennarun
	and Tim Shepard to analyze bursty network behavior
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
		CC="$(TARGET_CC)" \
		CFLAGS="$(TARGET_CFLAGS) -std=gnu99" all
endef

#define Package/isochronous/conffiles
#/etc/config/isoping
#/etc/config/udpburst
#endef

define Package/isochronous/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/isoping $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/udpburst $(1)/usr/sbin/
endef

$(eval $(call BuildPackage,isochronous))
