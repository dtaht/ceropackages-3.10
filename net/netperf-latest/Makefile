#
# Copyright (C) 2006-2009 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=netperf-latest
PKG_VERSION:=2.4.5-r431
PKG_RELEASE:=3

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=http://people.csail.mit.edu/woodrow/netperf-latest/
PKG_MD5SUM:=0516bdbf3b161c991c650b613e25082c

include $(INCLUDE_DIR)/package.mk

define Package/netperf-latest
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Network performance measurement tool
  URL:=http://www.netperf.org/
endef

define Package/netperf-latest/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/netserver.init $(1)/etc/init.d/netserver
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/netperf $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/netserver $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/lib/netperf
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/doc/examples/arr_script $(1)/lib/netperf
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/doc/examples/packet_byte_script $(1)/lib/netperf
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/doc/examples/sctp_stream_script $(1)/lib/netperf
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/doc/examples/snapshot_script $(1)/lib/netperf
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/doc/examples/tcp_range_script $(1)/lib/netperf
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/doc/examples/tcp_rr_script $(1)/lib/netperf
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/doc/examples/tcp_stream_script $(1)/lib/netperf
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/doc/examples/udp_rr_script $(1)/lib/netperf
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/doc/examples/udp_stream_script $(1)/lib/netperf
endef

$(eval $(call BuildPackage,netperf-latest))
