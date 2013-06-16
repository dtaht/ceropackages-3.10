#
# Copyright (C) 2007-2010 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=cerowrt-interfaces
PKG_VERSION:=1
PKG_RELEASE:=1
#PKG_REV:=2693afcf4c08c41067ac11177a1da3a033d6c6c0
# PKG_VERSION:=20110517

#PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
#PKG_SOURCE_URL:=git://github.com/dtaht/$(PKG_NAME).git
#PKG_SOURCE_PROTO:=git
#PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
#PKG_SOURCE_VERSION:=$(PKG_REV)

include $(INCLUDE_DIR)/package.mk

define Package/cerowrt-interfaces
   SECTION:=utils
   CATEGORY:=Utilities
   TITLE:=Interface rename script for cerowrt
   URL:=http://www.bufferbloat.net/projects/cerowrt/
   MAINTAINER:=Bufferbloat Development List <bloat-devel@lists.bufferbloat.net>
   DEPENDS:=+busybox
endef

define Package/cerowrt-interfaces/description
	The cerowrt-interfaces package provides the script and configuration files
	to rename network interfaces to the cerowrt names.
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) -pr ./files/* $(PKG_BUILD_DIR)
endef

define Build/Compile
endef

define Package/cerowrt-interfaces/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/nameif.init $(1)/etc/init.d/nameif
	$(INSTALL_DATA) ./files/mactab $(1)/etc/mactab
endef

$(eval $(call BuildPackage,cerowrt-interfaces))
