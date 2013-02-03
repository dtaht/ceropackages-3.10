#
# Copyright (C) 2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=rup
PKG_VERSION:=1
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/rup
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Gather Minstrel and user statistics
  MAINTAINER:=Dave Täht <dave.taht@bufferbloat.net>
  PKGARCH:=all
endef

define Package/rup/description
	Some tools to gather remote statistics on users and their
	connection speeds over wifi. These reuse ports 79 and 78
	and aren't particular secure but handy.
endef

define Build/Compile
endef

define Build/Configure
endef

define Package/rup/install
	$(INSTALL_BIN) ./files/rup $(1)/usr/sbin/rup
	$(INSTALL_BIN) ./files/rstats $(1)/usr/sbin/rstats
	$(INSTALL_BIN) ./files/rup.xinetd $(1)/etc/xinetd.d/rup
	$(INSTALL_BIN) ./files/rstats.xinetd $(1)/etc/xinetd.d/rstats
endef

$(eval $(call BuildPackage,rup))
