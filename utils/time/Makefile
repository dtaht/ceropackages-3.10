#
# Copyright (C) 2006-2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=time
PKG_VERSION:=1.7
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://ftp.gnu.org/gnu/time/
PKG_MD5SUM:=e38d2b8b34b1ca259cf7b053caac32b3

PKG_INSTALL:=1
#PKG_FIXUP:=libtool
PKG_REMOVE_FILES:=aclocal.m4 ltmain.sh

PKG_BUILD_DEPENDS:=

include $(INCLUDE_DIR)/package.mk

define Package/time
  SECTION:=utils
  CATEGORY:=utils
  TITLE:=The GNU time utility
  URL:=http://ftp.gnu.org/gnu/time/
endef

define Build/InstallDev
endef

define Package/time/install
	$(INSTALL_DIR) $(DESTDIR)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/time $(1)/usr/bin/
endef

$(eval $(call BuildPackage,time))
