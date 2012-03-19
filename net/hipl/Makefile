include $(TOPDIR)/rules.mk

PKG_NAME:=hipl
PKG_VERSION:=1.0.6
PKG_RELEASE:=7

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://hipl.hiit.fi/hipl/
PKG_CAT:=zcat

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
PKG_INSTALL_DIR:=$(PKG_BUILD_DIR)/ipkg-install

include $(INCLUDE_DIR)/package.mk

#TODO: check the module dependencies on all packages

define Package/hipl/Default
    SECTION:=net
    CATEGORY:=Network
    DEPENDS:=+kmod-crypto-aes +kmod-crypto-hmac +kmod-crypto-null +kmod-crypto-sha1 +kmod-ipv6 +libgcc +libopenssl
    URL:=http://hipl.hiit.fi/
endef

define Package/hipl-daemon
    $(call Package/hipl/Default)
    DEPENDS:=+genl +ip +kmod-ipsec +kmod-ipsec4 +kmod-ipsec6 +kmod-loop +kmod-nbd +kmod-tun +libpthread +losetup +kmod-dummy +kmod-ipip +kmod-crypto-authenc +kmod-ip6-tunnel
    TITLE:=HIPL daemon
endef

define Package/hipl-daemon/description
 The daemon for HIPL.
endef

define Package/hipl-firewall
    $(call Package/hipl/Default)
    DEPENDS:=+libconfig +iptables +ip6tables +kmod-ipt-queue
    TITLE:=HIPL firewall
endef

define Package/hipl-firewall/description
 The firewall for HIPL.
endef

define Build/Configure
	$(call Build/Configure/Default,--disable-debug);
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) DESTDIR="$(PKG_INSTALL_DIR)" all install
endef

define Package/hipl-daemon/install
	$(INSTALL_DIR) $(1)/etc/hip/
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_DIR) $(1)/usr/sbin/

	$(INSTALL_BIN) ./files/hipd.init $(1)/etc/init.d/hipd
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/hipd $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/hipconf $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/hipdnsproxy $(1)/usr/sbin/
#	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/etc/hip/hipd.conf $(1)/etc/hip/
#	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/etc/hip/hosts $(1)/etc/hip/
#	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/etc/hip/nsupdate.conf $(1)/etc/hip/
#	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/etc/hip/relay.conf $(1)/etc/hip/
endef

define Package/hipl-daemon/conffiles
#/etc/hip/hipd.conf
#/etc/hip/nsupdate.conf
#/etc/hip/relay.conf
endef

define Package/hipl-firewall/install
	$(INSTALL_DIR) $(1)/etc/hip/
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_DIR) $(1)/usr/sbin/

	$(INSTALL_BIN) ./files/hipfw.init $(1)/etc/init.d/hipfw
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/hipfw $(1)/usr/sbin/
#	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/etc/hip/esp_prot.conf $(1)/etc/hip/
#	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/etc/hip/hipfw.conf $(1)/etc/hip/
endef

define Package/hipl-firewall/conffiles
#/etc/hip/esp_prot.conf
#/etc/hip/hipfw.conf
endef

$(eval $(call BuildPackage,hipl-daemon))
$(eval $(call BuildPackage,hipl-firewall))
