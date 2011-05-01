#
# Copyright (C) 2005-2010 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

PKG_NAME:=jansson
PKG_VERSION:=2.0.1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=http://http://www.digip.org/jansson/releases/$(PKG_SOURCE)
PKG_MD5SUM:=f7a62be6977ef465b45781b53e8365e7

PKG_FIXUP:=libtool
PKG_INSTALL:=1
PKG_LIBTOOL_PATHS:=. lib libextra

#include $(INCLUDE_DIR)/package.mk

define Package/libjansson/Default
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=Jansson JSON library
  URL:=http://www.digip.org/jansson/
endef

define Package/libjansson/Default/description
 jansson is a lightweight json library
endef



CONFIGURE_ARGS+= \
	--enable-shared \
	--disable-static 

# XXX: AM_CFLAGS duplicates with CFLAGS
MAKE_FLAGS:= \
	AM_CFLAGS="" \

TARGET_CFLAGS += $(FPIC)
TARGET_LDFLAGS += -Wl,-rpath-link=$(STAGING_DIR)/usr/lib

define Build/Configure
	$(SED) 's,-I$$$${includedir},,g' $(PKG_BUILD_DIR)/configure
	$(SED) 's,-L$$$${libdir},,g' $(PKG_BUILD_DIR)/configure
	$(call Build/Configure/Default)
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include $(1)/usr/lib/pkgconfig
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/include/libjansson \
		$(1)/usr/include/
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/lib/liblibjansson{,-extra,-openssl}.{a,so*} \
		$(1)/usr/lib/
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/lib/pkgconfig/libjansson{,-extra}.pc \
		$(1)/usr/lib/pkgconfig/
endef


define Package/libjansson/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libjansson.so.* $(1)/usr/lib/
endef


$(eval $(call BuildPackage,libjansson))
