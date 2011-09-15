#
# Copyright (C) 2006-2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=gpsd
PKG_REV:=ca00820a8725a8458a7aeb03dc08e5c4f09f5294
#PKG_VERSION:=3.1
PKG_VERSION:=20110914
PKG_RELEASE:=1

#PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
#PKG_SOURCE_URL:=http://download.berlios.de/gpsd
#PKG_MD5SUM:=f280b914c19da3a91aa5e67d83d35033

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=git://git.berlios.de/gpsd
PKG_SOURCE_PROTO:=git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=$(PKG_REV)

#PKG_BUILD_DEPENDS:=libncurses

include $(INCLUDE_DIR)/scons.mk

define Package/gpsd-mini
  SECTION:=net
  CATEGORY:=Network
  DEPENDS:=+librt +libusb-1.0
  TITLE:=An interface daemon for GPS receivers (without libusb)
  URL:=http://gpsd.berlios.de/
endef

define Package/gpsd-mini/conffiles
/etc/config/gpsd
endef

define Package/gpsd-mini/description
  gpsd is a userland daemon acting as a translator between GPS and AIS receivers
  and their clients. gpsd listens on port 2947 for clients requesting
  position/time/velocity information.  The receivers are expected to generate
  position information in a well-known format -- as NMEA-0183 sentences, SiRF
  binary, Rockwell binary, Garmin binary format, or other vendor binary
  protocols.  gpsd takes this information from the GPS and translates it into
  something uniform and easier to understand for clients.
endef
 
SCONS_OPTIONS += \
	dbus=no \
	tsip=no \
	fv18=no \
	tripmate=no \
	earthmate=no \
	itrax=no \
	navcom=no \
	ubx=no \
	evermore=no \
	ntrip=no \
	libgpsmm=no \
	ncurses=no \
	strip=no \
	python=no


EXTRA_CFLAGS:=

EXTRA_LDFLAGS:=

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_INSTALL_DIR)/usr/include/gps.h $(1)/usr/include/
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libgps*.so* $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/lib/pkgconfig/libgps*.pc \
		$(1)/usr/lib/pkgconfig/
endef

define Package/gpsd-mini/install
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/gpsd.config $(1)/etc/config/gpsd
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/gpsd.init $(1)/etc/init.d/gpsd
	$(INSTALL_DIR) $(1)/etc/hotplug.d/usb
	$(INSTALL_DATA) ./files/gpsd.hotplug $(1)/etc/hotplug.d/usb/20-gpsd
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libgps*.so.* $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/gpsd $(1)/usr/sbin/
endef

$(eval $(call BuildPackage,gpsd-mini))
