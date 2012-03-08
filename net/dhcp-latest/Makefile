#
# Copyright (C) 2006-2008 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=dhcp
PKG_VERSION:=4.2.3-P2
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://ftp.isc.org/isc/dhcp/
PKG_MD5SUM:=14f57fd580d01633d0fad4809007a801

BIND_VERSION:=bind-9.9.0

include $(INCLUDE_DIR)/package.mk

define Package/dhcp-latest/Default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=IP Addresses and Names
  TITLE:=ISC's DHCP with v4 and v6 support
  DEPENDS:=+bind-latest-libs
  URL:=https://www.isc.org/software/dhcp
endef

define Package/dhcp-latest-relay
  $(call Package/dhcp-latest/Default)
  TITLE+= relay
endef

define Package/dhcp-latest-server
  $(call Package/dhcp-latest/Default)
  TITLE+= server
endef

EXTRA_CFLAGS=-I$(BUILD_DIR)/$(BIND_VERSION)/lib/isc/unix/include/ \
	-I$(BUILD_DIR)/$(BIND_VERSION)/lib/isc/pthreads/include/ \
	-I$(BUILD_DIR)/$(BIND_VERSION)/lib/isc/$(ARCH)/include \
	-I$(BUILD_DIR)/$(BIND_VERSION)/lib/dns/include

# FIXME something like this would fix up all the files 
# sed s#../bind#$(BUILD_DIR)/$(BIND_VERSION)#g ./dhcpctl/Makefile
# but since we are not compiling statically, that doesn't work either

CONFIGURE_ARGS+= \
        --enable-shared \
        --disable-static \
	--localstatedir=/tmp \
	--enable-delayed-ack \
	ac_cv_file__dev_random=yes \
	--with-libbind=$(BUILD_DIR)/bind-9.9.0/lib/isc/ \
	UNAME_S=Linux \
	UNAME_M=$(ARCH) \
	UNAME_R=3.3.0

define Package/dhcp-latest-relay/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/dhcprelay $(1)/usr/sbin/
endef

define Package/dhcp-latest-server/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_DIR) $(1)/usr/lib
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/dhcpd $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/omshell $(1)/usr/bin/
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/lib/*.so* $(1)/usr/lib
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/dhcpd.init $(1)/etc/init.d/dhcpd
	$(INSTALL_BIN) ./files/dhcpd6.init $(1)/etc/init.d/dhcpd6
endef

$(eval $(call BuildPackage,dhcp-latest-relay))
$(eval $(call BuildPackage,dhcp-latest-server))
