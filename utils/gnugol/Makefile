#
# Copyright (C) 2006-2011 OpenWrt.org
#
# Free software, licensed under the GNU Affero General Public License v3.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

PKG_NAME:=gnugol
PKG_VERSION:=1.0-rc3
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://ftp.gnu.org/gnu/gnugol/
PKG_MD5SUM:=e38d2b8b34b1ca259cf7b053caac32b3

PKG_INSTALL:=1

PKG_BUILD_DEPENDS:=libjansson

include $(INCLUDE_DIR)/package.mk

define Package/gnugol
  SECTION:=utils
  CATEGORY:=utils
  TITLE:=The GNU google/bing search utility
  URL:=http://gnugol.taht.net
endef

EXTRA_CFLAGS:=

EXTRA_LDFLAGS:=

define Build/InstallDev
endef

define Package/gnugol/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/gnugol $(1)/usr/bin/
endef

$(eval $(call BuildPackage,gnugol))
