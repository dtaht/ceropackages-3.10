# 
# Copyright (C) 2006-2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME=bulk-update
PKG_VERSION:=1.2.1
PKG_RELEASE:=6

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/bulk-update
  SECTION:=utils
  CATEGORY:=Base system
  TITLE:=Bulk change ip addresses, dns names, and SSIDs
  PKGARCH:=all
endef

# I swear I finished this package

define Package/bulk-update/description
  A set of scripts that ease network renumbering and renaming
endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/bulk-update/install
	$(INSTALL_DIR) $(1)
	$(CP) ./files/* $(1)/
endef

$(eval $(call BuildPackage,bulk-update))
