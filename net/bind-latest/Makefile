#
# Copyright (C) 2006-2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=bind
PKG_VERSION:=9.9.0rc3
PKG_RELEASE:=19

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:= \
	ftp://ftp.isc.org/isc/bind9/$(PKG_VERSION)/ \
	http://www.mirrorservice.org/sites/ftp.isc.org/isc/bind9/$(PKG_VERSION)/
PKG_MD5SUM:=da766ec3adc87bc1fd576754cff40574

PKG_FIXUP:=libtool

include $(INCLUDE_DIR)/package.mk

define Package/bind-latest/Default
  SECTION:=net
  CATEGORY:=Network
  DEPENDS:=+bind-latest-libs +libopenssl +xinetd
  TITLE:=bind
  URL:=https://www.isc.org/software/bind
  SUBMENU:=IP Addresses and Names
endef

define Package/bind-latest-libs
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=bind shared libraries
  URL:=http://www.isc.org/sw/bind/
endef

define Package/bind-latest-server
  $(call Package/bind-latest/Default)
  TITLE+= DNS server
endef

define Package/bind-latest-client
  $(call Package/bind-latest/Default)
  TITLE+= dynamic DNS client (nsupdate)
endef

define Package/bind-latest-tools
  $(call Package/bind-latest/Default)
  TITLE+= administration tools (all)
endef

define Package/bind-latest-rndc
  $(call Package/bind-latest/Default)
  TITLE+= remote administration tools (rndc and rndc-confgen only)
endef

define Package/bind-latest-check
  $(call Package/bind-latest/Default)
  TITLE+= administration tools (named-checkconf and named-checkzone only)
endef

define Package/bind-latest-dnssec
  $(call Package/bind-latest/Default)
  TITLE+= DNSSEC administration tools
endef

define Package/bind-latest-host
  $(call Package/bind-latest/Default)
  TITLE+= simple DNS client
endef

define Package/bind-latest-dig
  $(call Package/bind-latest/Default)
  TITLE+= DNS excavation tool
endef

define Package/bind-latest-devtools
  $(call Package/bind-latest/Default)
  TITLE+= DNS developer tools
endef

define Package/bind-latest-config
  $(call Package/bind-latest/Default)
  TITLE+= Out of the box working chrooted onfiguration files for dnssec
endef

export BUILD_CC="$(TARGET_CC)"

CONFIGURE_ARGS += \
	--enable-shared \
	--disable-static \
	--with-randomdev="/dev/urandom" \
	--with-openssl="$(STAGING_DIR)/usr" \
	--disable-threads \
	--with-libtool \
	--with-libxml2=no \
	--enable-epoll=yes \
	--with-rlimtype="long int" \
	--with-gssapi=no \
	--with-gost=no 

CONFIGURE_VARS += \
	BUILD_CC="$(TARGET_CC)" \

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR)/lib/dns \
		BUILD_CC="$(HOSTCC)" \
		CC="$(HOSTCC)" \
		CFLAGS="-O2" \
		LIBS="" \
		gen
	$(MAKE) -C $(PKG_BUILD_DIR) \
		DESTDIR="$(PKG_INSTALL_DIR)" \
		all install

endef

define Package/bind-latest-libs/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/*.so* $(1)/usr/lib
endef

define Package/bind-latest-server/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/named $(1)/usr/sbin/
	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_DIR) $(1)/etc/xinetd.d
	$(CP) ./files/xinetd.d/named $(1)/etc/xinetd.d/
	$(CP) ./files/bind.perms $(1)/etc/
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) ./files/named.init $(1)/etc/init.d/named
	$(INSTALL_BIN) ./files/named.prep $(1)/etc/init.d/namedprep
	$(INSTALL_BIN) ./files/named.montime $(1)/usr/sbin/named.montime
	find $(1)/etc/bind/ -name ".svn" | xargs rm -rf
endef

define Package/bind-latest-client/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/nsupdate $(1)/usr/bin/
endef

define Package/bind-latest-tools/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/dig $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/host $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/dnssec-keygen $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/dnssec-signzone $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/dnssec-settime $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/dnssec-dsfromkey $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/dnssec-revoke $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/named-checkconf $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/named-checkzone $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/rndc $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/rndc-confgen $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/ddns-confgen $(1)/usr/sbin/
endef

define Package/bind-latest-rndc/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/rndc $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/rndc-confgen $(1)/usr/sbin/
endef

define Package/bind-latest-check/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/named-checkconf $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/named-checkzone $(1)/usr/sbin/
endef

define Package/bind-latest-dnssec/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/dnssec-keygen $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/dnssec-signzone $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/dnssec-settime $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/dnssec-dsfromkey $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/dnssec-revoke $(1)/usr/sbin/
endef

define Package/bind-latest-host/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/host $(1)/usr/bin/
endef

define Package/bind-latest-dig/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/dig $(1)/usr/bin/
endef

# FIXME:

define Package/bind-latest-config/install
	$(INSTALL_DIR) $(1)/etc/chroot/
	$(INSTALL_DIR) $(1)/etc/default/
	$(INSTALL_DIR) $(1)/usr/sbin/
	$(CP) -a ./files/chroot/* $(1)/etc/chroot/
	$(INSTALL_BIN) ./files/ddns6.sh $(1)/usr/sbin/
	$(CP) ./files/ddns6.config $(1)/etc/default/

endef

define Package/bind-latest-devtools/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/named-journalprint $(1)/usr/sbin/
endef

$(eval $(call BuildPackage,bind-latest-libs))
$(eval $(call BuildPackage,bind-latest-server))
$(eval $(call BuildPackage,bind-latest-client))
$(eval $(call BuildPackage,bind-latest-tools))
$(eval $(call BuildPackage,bind-latest-rndc))
$(eval $(call BuildPackage,bind-latest-check))
$(eval $(call BuildPackage,bind-latest-dnssec))
$(eval $(call BuildPackage,bind-latest-host))
$(eval $(call BuildPackage,bind-latest-dig))
$(eval $(call BuildPackage,bind-latest-devtools))
$(eval $(call BuildPackage,bind-latest-config))
