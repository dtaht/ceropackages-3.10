#
# Copyright (C) 2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=ccnx
PKG_VERSION:=0.4.0
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://www.ccnx.org/releases
PKG_MD5SUM:=84898c22c5ff7e6a6c12c50a2e60a35a

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/ccnx
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Content-Centric Networking
  URL:=http://www.ccnx.org/
  DEPENDS:=+libexpat +libopenssl +libpcap +openssl-util
endef

define Package/ccnx/description
  CCNx is an open source project in early stage development exploring the next
  step in networking, based on one fundamental architectural change: replacing
  named hosts with named content as the primary abstraction.
endef

MAKE_FLAGS += \
	CPREFLAGS="$(TARGET_CFLAGS) $(TARGET_CPPFLAGS) -I../include \
		-D_REENTRANT" \
	INSTALL_BASE="$(PKG_INSTALL_DIR)/usr" \
	MORE_LDLIBS="$(TARGET_LDFLAGS)"

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include/ccn
	$(CP) $(PKG_INSTALL_DIR)/usr/include/ccn/*.h $(1)/usr/include/ccn/
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libccn.a $(1)/usr/lib/
endef

define Package/ccnx/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/ccn* $(1)/usr/bin/
endef

$(eval $(call BuildPackage,ccnx))
