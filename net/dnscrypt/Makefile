#
# Copyright (C) 2012-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=dnscrypt-proxy
PKG_VERSION:=1.3.3
PKG_RELEASE:=2

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=http://download.dnscrypt.org/dnscrypt-proxy \
	http://download.dnscrypt.org/dnscrypt-proxy/old
PKG_MD5SUM:=407d8ef08506233575683546359789a8

PKG_INSTALL:=1
PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk

define Package/dnscrypt-proxy/Default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=IP Addresses and Names
  URL:=https://github.com/opendns/dnscrypt-proxy
  MAINTAINER:=Black Roland https://forum.openwrt.org/profile.php?id=82621
  DEPENDS:=+libsodium
endef

define Package/dnscrypt-proxy
  $(call Package/dnscrypt-proxy/Default)
  TITLE:=A tool for securing communications between a client and a DNS resolver
endef

define Package/dnscrypt-proxy/description
    The DNSCrypt protocol is very similar to DNSCurve, but focuses on
    securing communications between a client and its first-level resolver.
    While not providing end-to-end security, it protects the local network
    (which is often the weakest link in the chain) against
    man-in-the-middle attacks. It also provides some confidentiality to
    DNS queries.
endef

define Package/hostip
  $(call Package/dnscrypt-proxy/Default)
  TITLE:=A tool for resolving a name to IPv4 or IPv6 addresses
endef

define Package/hostip/description
    Sends a DNS query to a resolver, and prints the IP addresses for the given host name.
endef

TARGET_CFLAGS += \
    -std=gnu99 \
    -fPIC

MAKE_FLAGS += \
    CFLAGS="$(TARGET_CFLAGS)"

define Package/dnscrypt-proxy/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(CP) $(PKG_INSTALL_DIR)/usr/sbin/dnscrypt-proxy $(1)/usr/sbin/
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/dnscrypt-proxy.init $(1)/etc/init.d/dnscrypt-proxy
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/dnscrypt-proxy.config $(1)/etc/config/dnscrypt-proxy
endef

define Package/dnscrypt-proxy/conffiles
/etc/config/dnscrypt-proxy
endef

define Package/hostip/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/hostip $(1)/usr/bin/
endef

$(eval $(call BuildPackage,dnscrypt-proxy))
$(eval $(call BuildPackage,hostip))
