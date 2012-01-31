#
# Copyright (C) 2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=dnsval
PKG_VERSION:=1.12
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://www.dnssec-tools.org/download
PKG_MD5SUM:=61ea8957c8ec5117713b3fbd339d81db

PKG_BUILD_DEPENDS:=libopenssl
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/dnsval/Default
  TITLE:=DNSSEC-Tools
  URL:=https://www.dnssec-tools.org/
endef

define Package/dnsval
  $(call Package/dnsval/Default)
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=IP Addresses and Names
  TITLE+= utilities
  DEPENDS:=+libopenssl +libpthread +libsres +libval
endef

define Package/libsres
  $(call Package/dnsval/Default)
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE+= resolver library
endef

define Package/libval-shim
  $(call Package/dnsval/Default)
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE+= validator shim library
  DEPENDS:=+libopenssl +libpthread +libsres +libval
endef

define Package/libval
  $(call Package/dnsval/Default)
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE+= validator library
endef

define Package/libval/conffiles
/etc/dnssec-tools/dnssec.conf
/etc/dnssec-tools/resolv.conf
endef

CONFIGURE_ARGS += \
	--with-openssl="$(STAGING_DIR)/usr"

define Build/InstallDev
	$(INSTALL_DIR) $(2)/bin
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/libval-config $(2)/bin/
	$(SED) \
		's,^\(prefix\|exec_prefix\)=.*,\1=$(STAGING_DIR)/usr,g' \
		$(2)/bin/libval-config
	$(INSTALL_DIR) $(1)/usr/include/validator
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/include/validator/*.h \
		$(1)/usr/include/validator/
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/lib/lib{sres,val{_shim,-threads}}.{a,la,so*} \
		$(1)/usr/lib/
endef

define Package/dnsval/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) \
		$(PKG_INSTALL_DIR)/usr/bin/{get*,libval_check_conf,validate} \
		$(1)/usr/bin/
endef

define Package/libsres/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libsres.so.* $(1)/usr/lib/
endef

define Package/libval-shim/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libval_shim.so.* $(1)/usr/lib/
endef

define Package/libval/install
	$(INSTALL_DIR) $(1)/etc/dnssec-tools
	$(INSTALL_CONF) \
		$(PKG_BUILD_DIR)/etc/{dnsval,resolv}.conf \
		$(1)/etc/dnssec-tools/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/etc/root.hints	$(1)/etc/dnssec-tools/
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libval-threads.so.* $(1)/usr/lib/
endef

$(eval $(call BuildPackage,dnsval))
$(eval $(call BuildPackage,libsres))
$(eval $(call BuildPackage,libval-shim))
$(eval $(call BuildPackage,libval))
