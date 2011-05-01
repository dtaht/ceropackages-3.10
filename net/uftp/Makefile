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

PKG_BUILD_DEPENDS:=libncurses

include $(INCLUDE_DIR)/package.mk

define Package/uftp
  SECTION:=net
  CATEGORY:=Network
  DEPENDS:=+libpthread
  TITLE:=An interface daemon for GPS receivers (without libusb)
  URL:=http://www.tcnj.edu/~bush/uftp.html
endef

CONFIGURE_CMD =./autogen.sh

CONFIGURE_ARGS += \
        --disable-dbus \
        --disable-tsip \
        --disable-fv18 \
        --disable-tripmate \
        --disable-earthmate \
        --disable-itrax \
        --disable-navcom \
        --disable-ubx \
        --disable-evermore \
        --disable-ntrip \
	--disable-libgpsmm \
	--disable-garmin \
        --without-x \

EXTRA_CFLAGS:=

EXTRA_LDFLAGS:=

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_INSTALL_DIR)/usr/include/gps.h $(1)/usr/include/
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libgps*.{a,so*} $(1)/usr/lib/
endef

define Package/uftp/install
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/uftp.config $(1)/etc/config/uftp
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/uftp.init $(1)/etc/init.d/uftp
	$(INSTALL_DIR) $(1)/etc/hotplug.d/usb
	$(INSTALL_DATA) ./files/uftp.hotplug $(1)/etc/hotplug.d/usb/20-uftp
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libgps*.so* $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/uftp $(1)/usr/sbin/
endef

$(eval $(call BuildPackage,uftp))
