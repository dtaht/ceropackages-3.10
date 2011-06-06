# 
# Copyright (C) 2006-2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=nanom5poe
PKG_VERSION:=.2
PKG_RELEASE:=1

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/nanom5poe
  SECTION:=utils
  CATEGORY:=Base system
  TITLE:=Passthrough POE enablement for the Nano-M5
  PKGARCH:=all
endef

define Package/nanom5poe/description
 Script for enabling POE passthrough (on the nano-m5 only at present)
 early in the boot.
endef

define Package/nanom5poe/conffiles
/etc/config/poe
endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/nanom5poe/install
	$(INSTALL_DIR) $(1)
	$(CP) ./files/* $(1)/
endef

$(eval $(call BuildPackage,nanom5poe))
