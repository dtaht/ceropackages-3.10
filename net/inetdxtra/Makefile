#
# Copyright (C) 2011-2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=inetdxtra
PKG_VERSION:=20130516
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)_src.tar.gz
PKG_SOURCE_URL:=@SF/inetdxtra
PKG_MD5SUM:=ffe46f5f8ea260a30d71611020971930

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/inetdxtra/Default
  TITLE:=inetd
  URL:=http://inetdxtra.sourceforge.net/
  DEPENDS:=+xinetd
endef

define Package/in-ctcs
  $(call Package/inetdxtra/Default)
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=BitTorrent
  TITLE+= CTorrent Control Server
endef

define Package/in-ctcs/description
  in.ctcs is a tiny CTCS server that is designed to run through inetd.
endef

define Package/in-dhcp
  $(call Package/inetdxtra/Default)
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=IP Addresses and Names
  TITLE+= DHCP server
endef

define Package/in-dhcp/description
  in.dhcp is a tiny DHCP server that is designed to run through inetd.
endef

define Package/in-dns
  $(call Package/inetdxtra/Default)
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=IP Addresses and Names
  TITLE+= DNS server
endef

define Package/in-dns/description
  in.dns is a tiny DNS server that is designed to run through inetd.
endef

define Package/in-jabberd
  $(call Package/inetdxtra/Default)
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Instant Messaging
  TITLE+= Jabber server
endef

define Package/in-jabberd/description
  in.jabberd is a tiny Jabber server that is designed to run through inetd.
endef

define Package/in-mvp
  $(call Package/inetdxtra/Default)
  SECTION:=net
  CATEGORY:=Network
  TITLE+= MVP relay server
endef

define Package/in-mvp/description
  in.mvp is a tiny MVP relay server that is designed to run through inetd.
endef

define Package/in-proxy
  $(call Package/inetdxtra/Default)
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Web Servers/Proxies
  TITLE+= HTTP proxy server
endef

define Package/in-proxy/description
  in.proxy is a tiny HTTP proxy server that is designed to run through inetd.
endef

define Package/in-smtp
  $(call Package/inetdxtra/Default)
  SECTION:=mail
  CATEGORY:=Mail
  TITLE+= SMTP relay server
endef

define Package/in-smtp/description
  in.smtp is a tiny SMTP relay server that is designed to run through inetd.
endef

define Package/in-www
  $(call Package/inetdxtra/Default)
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Web Servers/Proxies
  TITLE+= web server
endef

define Package/in-www/description
  in.www is a tiny web server that is designed to run through inetd.
endef

MAKE_FLAGS += \
	CFLAGS="$(TARGET_CFLAGS) $(TARGET_CPPFLAGS) -DONELOG -DNORELATIVE \
		-DCGI -DUPDATEPS" \

define Package/in-ctcs/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/in.ctcs $(1)/usr/sbin/
endef

define Package/in-dhcp/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/in.dhcp $(1)/usr/sbin/
endef

define Package/in-dns/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/in.dns $(1)/usr/sbin/
endef

define Package/in-jabberd/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/in.jabberd $(1)/usr/sbin/
endef

define Package/in-mvp/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/in.mvp $(1)/usr/sbin/
endef

define Package/in-proxy/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/in.proxy $(1)/usr/sbin/
endef

define Package/in-smtp/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/in.smtp $(1)/usr/sbin/
endef

define Package/in-www/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/in.www $(1)/usr/sbin/
endef

$(eval $(call BuildPackage,in-ctcs))
$(eval $(call BuildPackage,in-dhcp))
$(eval $(call BuildPackage,in-dns))
$(eval $(call BuildPackage,in-jabberd))
$(eval $(call BuildPackage,in-mvp))
$(eval $(call BuildPackage,in-proxy))
$(eval $(call BuildPackage,in-smtp))
$(eval $(call BuildPackage,in-www))
