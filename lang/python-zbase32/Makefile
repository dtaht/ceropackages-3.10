#
# Copyright (C) 2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=zbase32
PKG_VERSION:=1.1.5
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://pypi.python.org/packages/source/z/zbase32
PKG_MD5SUM:=4dba0be4ac6d66968de8e5173f51d65d

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)

define Package/python-zbase32
  SECTION:=lang
  CATEGORY:=Languages
  SUBMENU:=Python
  TITLE:=Base32 encoder/decoder
  URL:=https://tahoe-lafs.org/trac/zbase32
  DEPENDS:=+python
endef

define Package/python-zbase32/description
  An alternate base32 encoder (not RFC 3548 compliant).
endef

define Build/Compile
	$(call Build/Compile/PyMod,,install --prefix="/usr" --root="$(PKG_INSTALL_DIR)")
endef

define Package/python-zbase32/install
	$(INSTALL_DIR) $(1)$(PYTHON_PKG_DIR)
	$(CP) $(PKG_INSTALL_DIR)$(PYTHON_PKG_DIR)/* $(1)$(PYTHON_PKG_DIR)
endef

$(eval $(call BuildPackage,python-zbase32))
