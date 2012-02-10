#
# Copyright (C) 2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=xorp
PKG_VERSION:=1.8.3
PKG_RELEASE:=1
PKG_VARIANT:=

PKG_SOURCE_URL:=@SF/xorp
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)$(PKG_VARIANT)-src.tar.gz
PKG_MD5SUM:=5879bcf398a7040e893bfb0b33329511
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)$(PKG_VARIANT)
PKG_BUILD_DEPENDS:=
PKG_BUILD_PARALLEL:=4

include $(INCLUDE_DIR)/package.mk

define Package/xorp
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Xorp
  URL:=http://www.xorp.org/
  DEPENDS:=+libopenssl
endef

define Build/Configure
endef

define Build/Compile
	cd $(PKG_BUILD_DIR); \
	scons target=$(GNU_TARGET_NAME) \
                host=$(GNU_TARGET_NAME) \
                build=$(GNU_HOST_NAME) \
		CC="$(TARGET_CC) -I$(STAGING_DIR)/usr/include $(TARGET_CFLAGS)" CXX="$(TARGET_CXX) -I$(STAGING_DIR)/usr/include $(TARGET_CXXFLAGS)" \
		CPPPATH=$(STAGING_DIR)/usr/include \
		LINKFLAGS="-L$(STAGING_DIR)/usr/lib -Wl,-rpath-link,$(STAGING_DIR)/usr/lib" \
		-j$(PKG_BUILD_PARALLEL) \
		prefix=/usr/ \
		strip=yes shared=yes STRIP=$(STRIP) disable_ipv6=false \
		install DESTDIR=$(PKG_INSTALL_DIR)
endef

define Package/xorp/install
	$(INSTALL_DIR) $(1)/usr/
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/* \
		$(1)/usr/
	mv $(1)/usr/sbin/xorpsh $(1)/usr/sbin/xorpsh.bin
	$(INSTALL_BIN) ./files/xorpsh.sh $(1)/usr/sbin/xorpsh
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) ./files/xorp.init $(1)/etc/init.d/xorp
endef

$(eval $(call BuildPackage,xorp))

