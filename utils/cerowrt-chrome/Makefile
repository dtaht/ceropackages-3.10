#
# Copyright (C) 2007-2010 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=cerowrt-chrome
PKG_VERSION:=1
PKG_RELEASE:=3
#PKG_REV:=2693afcf4c08c41067ac11177a1da3a033d6c6c0
# PKG_VERSION:=20110517

#PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
#PKG_SOURCE_URL:=git://github.com/dtaht/$(PKG_NAME).git
#PKG_SOURCE_PROTO:=git
#PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
#PKG_SOURCE_VERSION:=$(PKG_REV)

include $(INCLUDE_DIR)/package.mk

define Package/cerowrt-chrome
   SECTION:=utils
   CATEGORY:=Utilities
   TITLE:=Web server files for cerowrt
   URL:=http://www.bufferbloat.net/projects/cerowrt/
   MAINTAINER:=Bufferbloat Development List <bloat-devel@lists.bufferbloat.net>
   DEPENDS:=+lighttpd
endef

define Package/cerowrt-chrome/description
	The cerowrt-chrome package provides a reference web page
	for local and remote network resources dedicated to cerowrt.
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) -pr ./files/* $(PKG_BUILD_DIR)
endef

define Build/Compile
	
endef

define Package/cerowrt-chrome/install
	$(INSTALL_DIR) $(1)/etc/uberwrt
	$(INSTALL_DIR) $(1)/etc/lighttpd
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_DIR) $(1)/etc/default
	$(INSTALL_DIR) $(1)/etc/www
	$(INSTALL_DIR) $(1)/etc/bgi-bin
	$(INSTALL_DIR) $(1)/mnt/disk1/www
	$(INSTALL_DIR) $(1)/mnt/disk1/cgi-bin
	$(CP) -rp $(PKG_BUILD_DIR)/etc/init.d/* $(1)/etc/init.d/
	$(CP) -rp $(PKG_BUILD_DIR)/etc/lighttpd/* $(1)/etc/lighttpd/
	$(CP) -rp $(PKG_BUILD_DIR)/etc/www/* $(1)/etc/www/
	$(CP) -rp $(PKG_BUILD_DIR)/etc/bgi-bin/* $(1)/etc/bgi-bin/
endef

$(eval $(call BuildPackage,cerowrt-chrome))
