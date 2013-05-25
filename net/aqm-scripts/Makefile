# 
# Copyright (C) 2006-2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=aqm-scripts
PKG_VERSION:=4
PKG_RELEASE:=2

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/aqm-scripts
  SECTION:=net
  CATEGORY:=Base system
  DEPENDS:=+tc +kmod-sched +kmod-ifb +iptables +iptables-mod-filter +iptables-mod-ipopt +iptables-mod-conntrack-extra
  TITLE:=AQM Scripts
  PKGARCH:=all
endef

define Package/aqm-scripts/description
 A set of scripts that does simple AQM configuration.
endef

define Package/aqm-scripts/conffiles
/etc/config/aqm
endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/aqm-scripts/install
	$(INSTALL_DIR) $(1)
	$(CP) ./files/* $(1)/
endef

$(eval $(call BuildPackage,aqm-scripts))
