#
# Copyright (C) 2006-2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=gpsd
PKG_REV:=8bf64049845b133410a957a91a37081273d63057
#PKG_VERSION:=3.1
PKG_VERSION:=20110921
PKG_RELEASE:=1

#PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
#PKG_SOURCE_URL:=http://download.berlios.de/gpsd
#PKG_MD5SUM:=f280b914c19da3a91aa5e67d83d35033

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=git://git.berlios.de/gpsd
PKG_SOURCE_PROTO:=git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=$(PKG_REV)

PKG_BUILD_DEPENDS:=libncurses

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/scons.mk

define Package/gpsd/Default
  DEPENDS:=+librt
  URL:=http://gpsd.berlios.de/
endef

define Package/gpsd/Default/description
  gpsd is a userland daemon acting as a translator between GPS and AIS receivers
  and their clients. gpsd listens on port 2947 for clients requesting
  position/time/velocity information.  The receivers are expected to generate
  position information in a well-known format -- as NMEA-0183 sentences, SiRF
  binary, Rockwell binary, Garmin binary format, or other vendor binary
  protocols.  gpsd takes this information from the GPS and translates it into
  something uniform and easier to understand for clients.
endef

define Package/gpsd
  $(call Package/gpsd/Default)
  SECTION:=net
  CATEGORY:=Network
  DEPENDS+= +libgps +libgpsd
  TITLE:=An interface daemon for GPS receivers
endef

define Package/gpsd/conffiles
/etc/config/gpsd
endef

define Package/gpsd/description
  $(call Package/gpsd/Default/description)
  This package contains the GPS daemon.
endef

define Package/cgps
  $(call Package/gpsd/Default)
  SECTION:=net
  CATEGORY:=Network
  DEPENDS+= +libgps +libncurses
  TITLE:=Test client for gpsd
endef

define Package/cgps/description
  $(call Package/gpsd/Default/description)
  This package contains a GPS test client.
endef

define Package/libgps
  $(call Package/gpsd/Default)
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=C service library for communicating with the GPS daemon
endef

define Package/libgps/description
  $(call Package/gpsd/Default/description)
  This package contains the libgps library.
endef

define Package/libgpsd
  $(call Package/gpsd/Default)
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=C service library for GPS applications
endef

define Package/libgpsd/description
  $(call Package/gpsd/Default/description)
  This package contains the libgpsd library.
endef

SCONS_OPTIONS += \
	dbus_export=no \
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
	libQgpsmm=no \
	bluez=no \
	strip=no \
	python=no \
	usb=no

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

define Package/gpsd/install
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/gpsd.config $(1)/etc/config/gpsd
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/gpsd.init $(1)/etc/init.d/gpsd
	$(INSTALL_DIR) $(1)/etc/hotplug.d/usb
	$(INSTALL_DATA) ./files/gpsd.hotplug $(1)/etc/hotplug.d/usb/20-gpsd
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/gpsd $(1)/usr/sbin/
endef

define Package/cgps/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/cgps $(1)/usr/bin/
endef

define Package/libgps/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libgps.so.* $(1)/usr/lib/
endef

define Package/libgpsd/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libgpsd.so.* $(1)/usr/lib/
endef

$(eval $(call RequireCommand,chrpath, \
	$(PKG_NAME) requires chrpath installed on the host-system. \
))

$(eval $(call BuildPackage,gpsd))
$(eval $(call BuildPackage,cgps))
$(eval $(call BuildPackage,libgps))
$(eval $(call BuildPackage,libgpsd))
