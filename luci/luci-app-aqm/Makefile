#
# Copyright (C) 2010 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-aqm
PKG_VERSION:=2
PKG_RELEASE:=1
LUCI_DIR:=/usr/lib/lua/luci

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-aqm
  SECTION:=luci
  CATEGORY:=LuCI
  TITLE:=AQM script LuCI interface
  MAINTAINER:=Toke Høiland-Jørgensen <toke@toke.dk>
  PKGARCH:=all
  DEPENDS:= lua luci-lib-core aqm-scripts
  SUBMENU:=3. Applications
endef

define Package/luci-app-aqm/description
	Control the simple_qos AQM script
endef

define Build/Compile
endef

define Build/Configure
endef

define Package/luci-app-aqm/install
	$(INSTALL_DIR) $(1)$(LUCI_DIR)/controller $(1)$(LUCI_DIR)/model/cbi
	$(INSTALL_BIN) ./files/aqm-controller.lua $(1)$(LUCI_DIR)/controller/aqm.lua
	$(INSTALL_BIN) ./files/aqm-cbi.lua $(1)$(LUCI_DIR)/model/cbi/aqm.lua
endef

define Package/luci-app-aqm/postinst
#!/bin/sh
which uci > /dev/null || exit 0
uci -q get ucitrack.@aqm[0] > /dev/null || {
  uci add ucitrack aqm > /dev/null
  uci set ucitrack.@aqm[0].init=aqm
  uci add_list ucitrack.@firewall[0].affects=aqm
  uci commit
}
endef

define Package/luci-app-aqm/postrm
#!/bin/sh
which uci > /dev/null || exit 0
uci -q get ucitrack.@aqm[0] > /dev/null && {
  uci delete ucitrack.@aqm[0]
  uci del_list ucitrack.@firewall[0].affects=aqm
  uci commit
}
endef

$(eval $(call BuildPackage,luci-app-aqm))
