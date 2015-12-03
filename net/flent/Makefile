# 
# Copyright (C) 2007-2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=flent
PKG_VERSION:=0.13.1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/tohojo/flent
PKG_REV:=0bee8abbd68f42e11b875834faaa6738f9342094
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=$(PKG_REV)

include $(INCLUDE_DIR)/package.mk

define Package/flent-tc_iterate
  SUBMENU:=Test
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Poll network queue depth with minimal cpu impact
  URL:=https://flent.org
  MAINTAINER:=Dave Taht <dave.taht@bufferbloat.net>
  DEPENDS+=+librt
endef

define Package/flent-tc_iterate/description
	Poll network queue depth with minimal cpu impact
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR)/misc \
		CC="$(TARGET_CC)" \
		CFLAGS="$(TARGET_CFLAGS) -std=gnu99"
endef

define Package/flent-tc_iterate/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/misc/tc_iterate $(1)/usr/sbin/
endef

$(eval $(call BuildPackage,flent-tc_iterate))
