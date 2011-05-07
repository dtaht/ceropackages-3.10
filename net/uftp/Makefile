#
# Copyright (C) 2006-2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=uftp
PKG_VERSION:=3.4.3
PKG_RELEASE:=2

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar
PKG_SOURCE_URL:=http://www.tcnj.edu/~bush/downloads/$PKG_SOURCE
PKG_MD5SUM:=fbff338872847182627f29a9fab5788b

PKG_INSTALL:=1
PKG_FIXUP:=libtool
PKG_REMOVE_FILES:=aclocal.m4 ltmain.sh

include $(INCLUDE_DIR)/package.mk

define Package/uftp
  SECTION:=net
  CATEGORY:=Network
  DEPENDS:=+libpthread +openssl
  TITLE:=Multicast FTP daemon
  URL:=http://www.tcnj.edu/~bush/uftp.html
endef

define Package/uftp/compile
	make -f makefile
endef

define Build/InstallDev

endef

define Package/uftp/install
	$(INSTALL_DIR) $(1)/usr/bin $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/uftpd \
			$(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/uftp \
			$(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/uftpproxyd \
			$(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/uftp_keymgt \
			$(1)/usr/sbin/

endef

$(eval $(call BuildPackage,uftp))
