#
# Copyright (C) 2006-2011 OpenWrt.org
#
# Free software, licensed under the GNU Affero General Public License v3.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

PKG_NAME:=gnugol
PKG_VERSION:=1.0-rc3
PKG_REV:=b8bf784155b35faf8a8df46b47db98b30c6a7fe0
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=git@github.com:dtaht/Gnugol.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=$(PKG_REV)

PKG_INSTALL:=1

PKG_BUILD_DEPENDS:=libjansson libiconv

include $(INCLUDE_DIR)/package.mk

define Package/gnugol
  SECTION:=utils
  CATEGORY:=utils
  TITLE:=The GNU google/bing search utility
  URL:=http://gnugol.taht.net
endef

MAKE_FLAGS += \
	CC="$(TARGETCC)" \
        DESTDIR="$(PKG_INSTALL_DIR)" \
        BUILDDIR="$(PKG_BUILD_DIR)" \
        LDLIBS+="$(LIBGCC_S)" \
        WITHOUT_XATTR=1

EXTRA_CFLAGS:=

EXTRA_LDFLAGS:=

define Build/InstallDev
endef

define Package/gnugol/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/gnugol $(1)/usr/bin/
endef

$(eval $(call BuildPackage,gnugol))
