#
# Copyright (C) 2007-2009 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# Please note this is not an officially released version of babelz

include $(TOPDIR)/rules.mk

PKG_NAME:=babeld
PKG_VERSION:=20111009
PKG_RELEASE:=6

#PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
#PKG_SOURCE_URL:=http://www.pps.jussieu.fr/~jch/software/files/
#PKG_MD5SUM:=e1a801aa48fe26401c29d2152c1a1887

PKG_REV:=856bb8326b3707ea4ca04ac901204f4c299f75ec

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=git://git.wifi.pps.jussieu.fr/babeld
PKG_SOURCE_SUBDIR:=babeld-$(PKG_VERSION)
PKG_SOURCE_VERSION:=$(PKG_REV)
PKG_SOURCE_PROTO:=git


include $(INCLUDE_DIR)/package.mk

define Package/babelz
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Routing and Redirection
  TITLE:=A loop-free distance-vector routing protocol
  URL:=http://www.pps.jussieu.fr/~jch/software/babel/
  MAINTAINER:=Dave Taht <d+babel@taht.net>
  DEPENDS:=+kmod-ipv6 +librt
endef

define Package/babelz/description
 Babel is a loop-avoiding distance-vector routing protocol roughly based
 on DSDV and AODV, but with provisions for link cost estimation and
 redistribution of routes from other routing protocols.
 While it is optimised for wireless mesh networks, Babel will also work
 efficiently on wired networks. It will generate between 1.2 and 2.4 times
 the amount of routing traffic that RIPng would generate, while
 never counting to infinity.
endef

define Package/babelz/conffiles
/etc/babel.conf
/etc/config/babeld
endef

MAKE_FLAGS+= \
	CFLAGS="$(TARGET_CFLAGS)" \

define Package/babelz/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/babeld $(1)/usr/sbin/
	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_CONF) ./files/babeld.conf $(1)/etc/
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/babeld.config $(1)/etc/config/babeld
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/babeld.init $(1)/etc/init.d/babeld
endef

$(eval $(call BuildPackage,babelz))
