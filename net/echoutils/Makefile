#
# Copyright (C) 2006-2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

#If we need to go back to tracking svn versions in the future
#This is what we would do
PKG_NAME:=echoutils
PKG_VERSION:=1.0.0
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tgz
PKG_RELEASE:=1

# Checksum

# Or track the SVN version
PKG_SOURCE_URL:=http://snapon.lab.bufferbloat.net/~cero2/pkg
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/echoutils
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Network performance measurement tool
  URL:=http://www.iwl.com/
endef

define Package/echoutils/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/echoserver $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/tcpechoserver $(1)/usr/bin/
endef

$(eval $(call BuildPackage,echoutils))
