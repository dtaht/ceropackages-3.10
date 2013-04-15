#
# Copyright (C) 2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=tahoe-lafs
PKG_VERSION:=20130415-git-1
PKG_RELEASE:=1

#PKG_SOURCE:=allmydata-tahoe-$(PKG_VERSION).zip
#PKG_SOURCE_URL:=https://tahoe-lafs.org/source/tahoe-lafs/releases
#PKG_MD5SUM:=a8a9864c6fdd5d2e972f09667df6a96a
#PKG_BUILD_DIR:=$(BUILD_DIR)/allmydata-tahoe-$(PKG_VERSION)

PKG_REV:=e898a1093fdc2f19097227ed32a1834ca49bf758

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=git://github.com/ClashTheBunny/tahoe-lafs.git
PKG_SOURCE_SUBDIR:=tahoe-lafs-$(PKG_VERSION)
PKG_SOURCE_VERSION:=$(PKG_REV)
PKG_SOURCE_PROTO:=git


include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)

define Package/tahoe-lafs
  SECTION:=lang
  CATEGORY:=Languages
  SUBMENU:=Python
  TITLE:=The Least-Authority File System
  URL:=https://tahoe-lafs.org/
  DEPENDS:=+python +python-crypto +python-foolscap +python-mock +python-nevow \
	+python-sqlite3 +python-zfec +pyasn1 +pycryptopp +pyopenssl +simplejson
endef

define Package/tahoe-lafs/description
  Tahoe-LAFS is a Free Software/Open Source decentralized data store. It
  distributes your filesystem across multiple servers, and even if some of the
  servers fail or are taken over by an attacker, the entire filesystem continues
  to work correctly and to preserve your privacy and security.
endef

define Build/Compile
	$(call Build/Compile/PyMod,,install --prefix="$(PKG_INSTALL_DIR)/usr")
	$(SED) \
		's,#!$(HOST_PYTHON_BIN),#!/usr/bin/$(PYTHON),' \
		 $(PKG_INSTALL_DIR)/usr/bin/*
endef

define Package/tahoe-lafs/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/tahoe $(1)/usr/bin/
	$(INSTALL_DIR) $(1)$(PYTHON_PKG_DIR)
	$(CP) $(PKG_INSTALL_DIR)$(PYTHON_PKG_DIR)/* $(1)$(PYTHON_PKG_DIR)
endef

$(eval $(call BuildPackage,tahoe-lafs))
