#
# Copyright (C) 2006-2011 OpenWrt.org
#
# Free software, licensed under the GNU Affero General Public License v3.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

PKG_NAME:=gnugol
PKG_VERSION:=1.0
PKG_REV:=0c060862559a8211a3718dc78b5f3b2960f0f7fa
PKG_RELEASE:=2

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=git@github.com:dtaht/Gnugol.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=$(PKG_REV)

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

define Package/gnugol
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=The GNU google/bing search utility
  URL:=http://gnugol.taht.net
  DEPENDS:=+libcurl $(ICONV_DEPENDS) +jansson
endef

define Package/gnugol/description
  Gnugol is a command line web search client, written in C, that can make
  searching and utilizing the web more efficient.
endef

MAKE_FLAGS += \
	LIBS="$(TARGET_LDFLAGS) -ljansson -lcurl -ldl -liconv \
		-Wl,-rpath-link=$(STAGING_DIR)/usr/lib" \
	BINDIR="/usr/bin" \
	DOCDIR="/usr/share/man/man1/" \
	SHAREDLIBDIR="/usr/lib/gnugol" \
	PLATFORM="Linux"

define Package/gnugol/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/gnugol $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/usr/lib/gnugol
	$(INSTALL_BIN) \
		$(PKG_INSTALL_DIR)/usr/lib/gnugol/*.so \
		$(1)/usr/lib/gnugol/
endef

$(eval $(call BuildPackage,gnugol))
