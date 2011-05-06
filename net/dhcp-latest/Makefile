#
# Copyright (C) 2006-2008 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=dhcp
PKG_VERSION:=4.2.1-P1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://ftp.isc.org/isc/dhcp/
PKG_MD5SUM:=22e6f1eff6d5cfe2621a06cc62ba5b70

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

# NOTE THIS IS MIPS SPECIFIC RIGHT NOW

EXTRA_CFLAGS=-I/home/d/src/iscwrt/build_dir/target-mips_r2_uClibc-0.9.32/bind-9.8.0/lib/isc/unix/include/ -I/home/d/src/iscwrt/build_dir/target-mips_r2_uClibc-0.9.32/bind-9.8.0/lib/isc/pthreads/include/ -I/home/d/src/iscwrt/build_dir/target-mips_r2_uClibc-0.9.32/bind-9.8.0/lib/isc/mips -I/home/d/src/iscwrt/build_dir/target-mips_r2_uClibc-0.9.32/bind-9.8.0/lib/isc/

CONFIGURE_ARGS+= \
        --enable-shared \
        --disable-static \
	--localstatedir=/tmp \
	--enable-delayed-ack \
	ac_cv_file__dev_random=yes \
	--with-libbind=/home/d/src/iscwrt/build_dir/target-mips_r2_uClibc-0.9.32/bind-9.8.0/lib/isc/ \
	UNAME_S=Linux \
	UNAME_M=$(ARCH) \
	UNAME_R=2.6.38

define Package/dhcp-latest-relay/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/dhcrelay $(1)/usr/sbin/
endef

define Package/dhcp-latest-server/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_DIR) $(1)/usr/local/lib
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/dhcpd $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/omshell $(1)/usr/bin/
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/local/lib/*.a $(1)/usr/local/lib
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/dhcpd.init $(1)/etc/init.d/dhcpd
endef

$(eval $(call BuildPackage,dhcp-latest-relay))
$(eval $(call BuildPackage,dhcp-latest-server))
