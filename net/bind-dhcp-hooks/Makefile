#
# Copyright (C) 2006-2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

define Package/bind-dhcp-hooks/Default
  SECTION:=net
  CATEGORY:=Network
  DEPENDS:=+bind-latest +dhcp-latest
  TITLE:=bind-dhcp-hooks
  URL:=http://www.bufferbloat.net/projects/uberwrt
  SUBMENU:=Hooks for dynamic DNS for ipv4 and ipv6
endef

define Package/bind-dhcp-hooks/install
	$(INSTALL_DIR) $(1)/usr/bin
endef

$(eval $(call BuildPackage,bind-dhcp-hooks))
