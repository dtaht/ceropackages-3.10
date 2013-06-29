#
# Copyright (C) 2007-2009 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# Please note this is not an officially released version of babeld

include $(TOPDIR)/rules.mk

PKG_NAME:=babeld
PKG_VERSION:=20130629-git-1
PKG_RELEASE:=1

#PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
#PKG_SOURCE_URL:=http://www.pps.jussieu.fr/~jch/software/files/
#PKG_MD5SUM:=c3d2a632d5ad1944d4767960109c867f04e09d5d

PKG_REV:=6134ce59d3e35232c923f0b11a23315a3954fe20

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=git://github.com/jech/babeld.git
PKG_SOURCE_SUBDIR:=babeld-$(PKG_VERSION)
PKG_SOURCE_VERSION:=$(PKG_REV)
PKG_SOURCE_PROTO:=git


include $(INCLUDE_DIR)/package.mk

define Package/babeld
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Routing and Redirection
  TITLE:=Experimental convergence algo for babel, the distance-vector routing protocol
  URL:=http://www.pps.jussieu.fr/~jch/software/babel/
  MAINTAINER:=Dave Taht <d+babel@taht.net>
  DEPENDS:=+kmod-ipv6 +librt
endef

define Package/babeld/description
 Babel is a loop-avoiding distance-vector routing protocol roughly based
 on DSDV and AODV, but with provisions for link cost estimation and
 redistribution of routes from other routing protocols.
 While it is optimised for wireless mesh networks, Babel will also work
 efficiently on wired networks. It will generate between 1.2 and 2.4 times
 the amount of routing traffic that RIPng would generate, while
 never counting to infinity.
 This experimental package contains a newer smoothed convergence algo.
endef

define Package/babeld/conffiles
/etc/babeld.conf
/etc/config/babeld
endef

MAKE_FLAGS+= \
	CFLAGS="$(TARGET_CFLAGS)" \

define Package/babeld/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/babeld $(1)/usr/sbin/
	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_CONF) ./files/babeld.conf $(1)/etc/
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/babeld.config $(1)/etc/config/babeld
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/babeld.init $(1)/etc/init.d/babeld
endef

$(eval $(call BuildPackage,babeld))
