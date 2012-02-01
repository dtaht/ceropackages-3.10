#
# Copyright (C) 2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=estats_userland
PKG_VERSION:=2.0.1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://estats-userland.googlecode.com/files
PKG_MD5SUM:=1ff41f864bdaec56c14770fd371d1a44

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/estats/Default
  TITLE:=TCP Extended Statistics
  URL:=http://www.web10g.org/
endef

define Package/estats
  $(call Package/estats/Default)
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE+= utilities
  DEPENDS:=+libestats
endef

define Package/libestats
  $(call Package/estats/Default)
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE+= library
endef

define Build/InstallDev
	$(INSTALL_DIR) $(2)/bin
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/estats-config $(2)/bin/
	$(SED) \
		's,^\(prefix\|exec_prefix\)=.*,\1=$(STAGING_DIR)/usr,g' \
		$(2)/bin/estats-config
	$(SED) \
		's,^includedir=\"/usr/include,includedir=\"$$$${prefix}/include,g' \
		$(2)/bin/estats-config
	$(SED) \
		's,^libdir=\"/usr/lib,libdir=\"$$$${exec_prefix}/lib,g' \
		$(2)/bin/estats-config
	$(INSTALL_DIR) $(1)/usr/include/estats
	$(CP) $(PKG_INSTALL_DIR)/usr/include/estats/*.h $(1)/usr/include/estats/
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libestats.{a,la,so*} $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/usr/share/aclocal
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/share/aclocal/estats.m4 \
		$(1)/usr/share/aclocal/
endef

define Package/estats/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) \
		$(PKG_INSTALL_DIR)/usr/bin/{delta*,list*,log*,read*,write*} \
		$(1)/usr/bin/
endef

define Package/libestats/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libestats.so.* $(1)/usr/lib/
endef

$(eval $(call BuildPackage,estats))
$(eval $(call BuildPackage,libestats))
