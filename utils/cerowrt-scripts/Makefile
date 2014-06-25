#
# Copyright (C) 2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
PKG_NAME:=cerowrt-scripts
PKG_REV:=40b57768657c4880e3afb98f55612f2995921763
PKG_VERSION:=20140509
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=git://github.com/richb-hanover/CeroWrtScripts.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=$(PKG_REV)

include $(INCLUDE_DIR)/package.mk

define Package/cerowrt-scripts
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=Scripts that we use to measure (and improve) latency
  URL:=https://github.com/richb-hanover/CeroWrtScripts
  DEPENDS:=+netperf
endef

define Package/cerowrt-scripts/description
  This is a set of scripts that we use to measure (and improve) latency in home
  routers (and everywhere else!)
endef

define Build/Compile
endef

define Package/cerowrt-scripts/install
	$(INSTALL_DIR) $(1)/usr/lib/CeroWrtScripts
	$(CP) $(PKG_BUILD_DIR)/*.sh $(1)/usr/lib/CeroWrtScripts/
endef

$(eval $(call BuildPackage,cerowrt-scripts))
