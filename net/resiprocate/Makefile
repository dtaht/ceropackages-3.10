#
# Copyright (C) 2012 OpenWrt.org
# Copyright (C) 2012 Daniel Pocock <daniel@pocock.com.au>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=resiprocate
PKG_VERSION:=1.8.5
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/resiprocate-$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://www.resiprocate.org/files/pub/reSIProcate/releases/
PKG_MD5SUM:=70754747edf22cfd752a39eb81f0d2a1

PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1
PKG_BUILD_DEPENDS:=+libasio

include $(INCLUDE_DIR)/package.mk

#TARGET_CFLAGS += $(FPIC)
TARGET_LDFLAGS += -lcrypto

define Package/resiprocate/Default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Telephony
  DEFAULT:=m
  TITLE:=reSIProcate
  URL:=http://www.resiprocate.org/
  DEPENDS:=+libopenssl +libdb47 +libcares +boost +libstdcpp
endef

define Package/libresiprocate
$(call Package/resiprocate/Default)
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE+= libraries
endef

define Package/repro
$(call Package/resiprocate/Default)
  TITLE+= repro SIP proxy
  DEPENDS+= +libresiprocate
endef

define Package/resiprocate-turn-server
$(call Package/resiprocate/Default)
  TITLE+= repro TURN server (reTurn)
  DEPENDS+= +libresiprocate
endef

define Package/resiprocate/description
 SIP stack, proxy, ICE/STUN/TURN implementation
endef

define Package/repro/conffiles
/etc/repro/repro.config
endef

define Package/resiprocate-turn-server/conffiles
/etc/reTurnServer.config
endef

define Build/Configure
	$(call Build/Configure/Default, --enable-shared --disable-static --with-ssl --with-c-ares )
endef

define Build/Compile
        $(MAKE) $(PKG_JOBS) -C $(PKG_BUILD_DIR)
endef

define Package/libresiprocate/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/librutil*.so* $(1)/usr/lib/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libresip*.so* $(1)/usr/lib/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libdum*.so* $(1)/usr/lib/
endef

define Package/repro/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/repro/repro $(1)/usr/sbin/
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/librepro*.so* $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/etc/repro/ssl
	$(INSTALL_CONF) ./files/repro.config $(1)/etc/repro/
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/repro.init $(1)/etc/init.d/repro
endef

define Package/resiprocate-turn-server/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/reTurn/reTurnServer $(1)/usr/sbin/
	$(INSTALL_CONF) ./files/reTurnServer.config $(1)/etc/
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/reTurnServer.init $(1)/etc/init.d/reTurnServer
endef

$(eval $(call BuildPackage,libresiprocate))
$(eval $(call BuildPackage,repro))
$(eval $(call BuildPackage,resiprocate-turn-server))


