#
# Copyright (C) 2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=nettle
PKG_VERSION:=2.7.1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://www.lysator.liu.se/~nisse/archive
PKG_MD5SUM:=003d5147911317931dd453520eb234a5

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/libnettle/Default
  SUBMENU:=SSL
  TITLE:=A low-level cryptographic library
  URL:=http://www.lysator.liu.se/~nisse/nettle/
endef

define Package/libnettle/Default/description
  Nettle is a cryptographic library that is designed to fit easily in more or
  less any context: In crypto toolkits for object-oriented languages (C++,
  Python, Pike, ...), in applications like LSH or GNUPG, or even in kernel
  space.
endef

define Package/libnettle
  $(call Package/libnettle/Default)
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE+= (symmetric and one-way algorithms)
endef

define Package/libnettle/description
  $(call Package/libnettle/Default/description)
  This package contains the symmetric and one-way cryptographic algorithms.
endef

define Package/libhogweed
  $(call Package/libnettle/Default)
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE+= (asymmetric algorithms)
  DEPENDS:=+libnettle +libgmp
endef

define Package/libhogweed/description
  $(call Package/libnettle/Default/description)
  This package contains the asymmetric cryptographic algorithms, which, require
  the GNU multiple precision arithmetic library (libgmp) for their large integer
  computations.
endef

define Package/nettle-bin
  $(call Package/libnettle/Default)
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE+= (binary utilities)
  DEPENDS:=+libhogweed
endef

define Package/nettle-bin/description
  $(call Package/libnettle/Default/description)
  This package contains binary utilities that accompany the library.
endef

CONFIGURE_ARGS += \
	--disable-openssl

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_INSTALL_DIR)/usr/include/nettle $(1)/usr/include/
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/lib/lib{nettle,hogweed}.{a,so*} \
		$(1)/usr/lib/
	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/lib/pkgconfig/{nettle,hogweed}.pc \
		$(1)/usr/lib/pkgconfig/
endef

define Package/libnettle/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libnettle.so.* $(1)/usr/lib/
endef

define Package/libhogweed/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libhogweed.so.* $(1)/usr/lib/
endef

define Package/nettle-bin/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/* $(1)/usr/bin/
endef

$(eval $(call BuildPackage,libnettle))
$(eval $(call BuildPackage,libhogweed))
$(eval $(call BuildPackage,nettle-bin))
