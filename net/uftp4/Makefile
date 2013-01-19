#
# Copyright (C) 2011-2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

# orig http://173.71.68.52:22000/uftp/uftp-4.0a4.tar
PKG_NAME:=uftp4
PKG_VERSION:=4.0a4
PKG_RELEASE:=1

PKG_SOURCE:=uftp-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://snapon.lab.bufferbloat.net/~cero2/uftp4/
PKG_MD5SUM:=e122c41c2e1db8b7819bbda5bcc4c280

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(BUILD_VARIANT)/$(PKG_NAME)-$(PKG_VERSION)

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/uftp4/Default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=File Transfer
  TITLE:=Multicast UDP FTP version 4 with ipv6 support
  URL:=https://www.tcnj.edu/~bush/uftp.html
endef

define Package/uftp4/Default/description
  UFTP is an encrypted multicast file transfer program, designed to securely,
  reliably, and efficiently transfer files to multiple receivers
  simultaneously.
endef

define Package/uftp4
  $(call Package/uftp4/Default)
  TITLE+= server with TLS support
  VARIANT:=tls
  DEPENDS:=+libopenssl
endef

define Package/uftp4/description
  $(call Package/uftp4/Default/description)
  This package contains the server built with TLS support.
endef

define Package/uftp4-notls
  $(call Package/uftp/Default)
  TITLE+= server without TLS support
  VARIANT:=notls
endef

define Package/uftp4-notls/description
  $(call Package/uftp/Default/description)
  This package contains the server built without TLS support.
endef

define Package/uftpd4
  $(call Package/uftp4/Default)
  TITLE+= client daemon with TLS support
  VARIANT:=tls
  DEPENDS:=+libopenssl
endef

define Package/uftpd4/description
  $(call Package/uftp4/Default/description)
  This package contains the client daemon built with TLS support.
endef

define Package/uftpd4-notls
  $(call Package/uftp/Default)
  TITLE+= client daemon without TLS support
  VARIANT:=notls
endef

define Package/uftpd4-notls/description
  $(call Package/uftp4/Default/description)
  This package contains the client daemon built without TLS support.
endef

define Package/uftpproxyd4
  $(call Package/uftp4/Default)
  TITLE+= proxy daemon with TLS support
  VARIANT:=tls
  DEPENDS:=+libopenssl
endef

define Package/uftpproxyd4/description
  $(call Package/uftp4/Default/description)
  This package contains the proxy daemon built with TLS support.
endef

define Package/uftpproxyd4-notls
  $(call Package/uftp4/Default)
  TITLE+= proxy daemon without TLS support
  VARIANT:=notls
endef

define Package/uftpproxyd4-notls/description
  $(call Package/uftp4/Default/description)
  This package contains the proxy daemon built without TLS support.
endef

define Package/uftp4-keymgt
  $(call Package/uftp4/Default)
  TITLE+= key management utility
  VARIANT:=tls
  DEPENDS:=+libopenssl
endef

define Package/uftp4-keymgt/description
  $(call Package/uftp4/Default/description)
  This package contains the key management utility.
endef

MAKE_FLAGS += \
	CFLAGS="$(TARGET_CFLAGS) $(TARGET_CPPFLAGS)" \
	UNAME_S="Linux"

ifeq ($(BUILD_VARIANT),tls)
	MAKE_FLAGS += \
		OPENSSL="$(STAGING_DIR)/usr"
endif

ifeq ($(BUILD_VARIANT),notls)
	MAKE_FLAGS += \
		NO_ENCRYPTION="1"
endif

define Package/uftp4/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/uftp $(1)/usr/bin/
endef

define Package/uftpd4/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/uftpd $(1)/usr/sbin/
endef

define Package/uftpproxyd4/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/uftpproxyd $(1)/usr/sbin/
endef

Package/uftp4-notls/install=$(Package/uftp4/install)
Package/uftpd4-notls/install=$(Package/uftpd4/install)
Package/uftpproxyd4-notls/install=$(Package/uftpproxyd4/install)

define Package/uftp4-keymgt/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/uftp_keymgt $(1)/usr/bin/
endef

$(eval $(call BuildPackage,uftp4))
$(eval $(call BuildPackage,uftp4-notls))
$(eval $(call BuildPackage,uftpd4))
$(eval $(call BuildPackage,uftpd4-notls))
$(eval $(call BuildPackage,uftpproxyd4))
$(eval $(call BuildPackage,uftpproxyd4-notls))
$(eval $(call BuildPackage,uftp4-keymgt))
