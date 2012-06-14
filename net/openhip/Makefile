include $(TOPDIR)/rules.mk

PKG_NAME:=openhip
PKG_VERSION:=0.9
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://downloads.sourceforge.net/project/openhip/hip/openhip-0.9/

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
PKG_INSTALL_DIR:=$(PKG_BUILD_DIR)/ipkg-install

include $(INCLUDE_DIR)/package.mk

define Package/openhip/Default
    SECTION:=net
    CATEGORY:=Network
    DEPENDS:=+libopenssl +libcrypto
    URL:=http://www.openhip.org/
endef

define Package/openhip-daemon
    $(call Package/openhip/Default)
    DEPENDS+=+ip +kmod-tun +libpthread +libxml2
    TITLE:=openhip hip daemon
endef

define Package/openhip-daemon/description
 The daemon for openhip.
endef

define Package/openhip-firewall
    $(call Package/openhip/Default)
    DEPENDS+=+libconfig +iptables +ip6tables +kmod-ipt-queue
    TITLE:=openhip firewall
endef

define Package/openhip-firewall/description
 The firewall for openhip.
endef

define Build/Configure
	$(call Build/Configure/Default,--disable-debug);
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) DESTDIR="$(PKG_INSTALL_DIR)" all install
endef

define Package/openhip-daemon/install
	$(INSTALL_DIR) $(1)/etc/hip/
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_DIR) $(1)/usr/sbin/

	$(INSTALL_BIN) ./files/hip.init $(1)/etc/init.d/hip
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/hip $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/hitgen $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/hipstatus $(1)/usr/sbin/
	$(INSTALL_DATA) ./files/hip.conf $(1)/etc/hip/
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/etc/hip/known_host_identities.xml $(1)/etc/hip/
#	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/etc/hip/nsupdate.conf $(1)/etc/hip/
#	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/etc/hip/relay.conf $(1)/etc/hip/
endef

define Package/openhip-daemon/conffiles
/etc/hip/known_host_identities.xml
/etc/hip/hip.conf
# my_host_identities.xml somehow need to generate this at install time with suitable randomness
#/etc/hip/nsupdate.conf
#/etc/hip/relay.conf
endef

define Package/openhip-firewall/install
	$(INSTALL_DIR) $(1)/etc/hip/
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_DIR) $(1)/usr/sbin/

	$(INSTALL_BIN) ./files/hipfw.init $(1)/etc/init.d/hipfw
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/hipfw $(1)/usr/sbin/
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/etc/hip/.conf $(1)/etc/hip/
#	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/etc/hip/hipfw.conf $(1)/etc/hip/
endef

define Package/openhip-firewall/conffiles
#/etc/hip/esp_prot.conf
#/etc/hip/hipfw.conf
endef

$(eval $(call BuildPackage,openhip-daemon))
$(eval $(call BuildPackage,openhip-firewall))
