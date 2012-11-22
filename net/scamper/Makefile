#
# Copyright (C) 2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=scamper
PKG_VERSION:=20111202c
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-cvs-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://www.wand.net.nz/scamper
PKG_MD5SUM:=7cac731d7ecda6ec0e434ea8bbf4c7ac

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-cvs-$(PKG_VERSION)
PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/scamper/Default
  TITLE:=Parallel Internet measurement
  URL:=http://www.wand.net.nz/scamper/
endef

define Package/scamper/Default/description
  scamper is a program that is able to conduct Internet measurement tasks to
  large numbers of IPv4 and IPv6 addresses, in parallel, to fill a specified
  packets-per-second rate. Currently, it supports the well-known ping and
  traceroute techniques, as well as MDA traceroute, alias resolution, some parts
  of tbit, sting, and neighbour discovery.

  scamper can do ICMP-based Path MTU discovery. scamper starts with the outgoing
  interface's MTU and discovers the location of Path MTU bottlenecks. scamper
  performs a PMTUD search when an ICMP fragmentation required message is not
  returned to establish the PMTU to the next point in the network, followed by a
  TTL limited search to infer where the failure appears to occur.
endef

define Package/scamper
  $(call Package/scamper/Default)
  SECTION:=net
  CATEGORY:=Network
  TITLE+= utility
  DEPENDS:=+libscamperfile
endef

define Package/scamper/description
  $(call Package/scamper/Default/description)
endef

define Package/libscamperfile
  $(call Package/scamper/Default)
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE+= library
endef

define Package/libscamperfile/description
  $(call Package/scamper/Default/description)

  This package contains the libscamperfile shared library.
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_INSTALL_DIR)/usr/include/scamper_*.h $(1)/usr/include/
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libscamperfile.{a,so*} $(1)/usr/lib/
endef

define Package/scamper/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) \
		$(PKG_INSTALL_DIR)/usr/bin/scamper \
		$(PKG_INSTALL_DIR)/usr/bin/sc_* \
		$(1)/usr/bin/
endef

define Package/libscamperfile/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libscamperfile.so.* $(1)/usr/lib/
endef

$(eval $(call BuildPackage,scamper))
$(eval $(call BuildPackage,libscamperfile))
