#
# Copyright (C) 2011-2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=web10g-userland
PKG_VERSION:=2.0.3
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://web10g-userland.googlecode.com/files
PKG_MD5SUM:=2047d97cafc43b4b7daeba46b3c650a7

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/tcpe/Default
  TITLE:=TCP Extended Statistics
  URL:=http://www.web10g.org/
endef

define Package/tcpe
  $(call Package/tcpe/Default)
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE+= utilities
  DEPENDS+= +libtcpe
endef

define Package/libtcpe
  $(call Package/tcpe/Default)
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE+= library
  DEPENDS:=+libmnl
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_INSTALL_DIR)/usr/include/tcpe $(1)/usr/include/
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libtcpe.{a,la,so*} $(1)/usr/lib/
endef

define Package/tcpe/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) \
		$(PKG_INSTALL_DIR)/usr/bin/{list,read,watch}conn* \
		$(1)/usr/bin/
endef

define Package/libtcpe/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libtcpe.so.* $(1)/usr/lib/
endef

$(eval $(call BuildPackage,tcpe))
$(eval $(call BuildPackage,libtcpe))
