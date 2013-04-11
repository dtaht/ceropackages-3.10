#
# Copyright (C) 2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=pycryptopp
PKG_VERSION:=0.6.0.1206569328141510525648634803928199668821045408958
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://pypi.python.org/packages/source/p/pycryptopp
PKG_MD5SUM:=ce38fbe03705d27da408c78b56eb1947

PKG_BUILD_DEPENDS:=distribute/host
TAR_CMD:=$(HOST_TAR) -C $(PKG_BUILD_DIR) --strip-components 1 $(TAR_OPTIONS)

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)

define Package/pycryptopp
  SECTION:=lang
  CATEGORY:=Languages
  SUBMENU:=Python
  TITLE:=Python wrappers for a few algorithms from the Crypto++ library
  URL:=https://tahoe-lafs.org/trac/pycryptopp
  DEPENDS:=+python +libcryptoxx
endef

define Package/pycryptopp/description
  pycryptopp is a python wrapper around a few algorithms from the Crypto++ and
  python-Ed25519 libraries.
endef

define Build/Compile
	$(call Build/Compile/PyMod,,install --prefix="/usr" --root="$(PKG_INSTALL_DIR)")
endef

define Package/pycryptopp/install
	$(INSTALL_DIR) $(1)$(PYTHON_PKG_DIR)
	$(CP) $(PKG_INSTALL_DIR)$(PYTHON_PKG_DIR)/* $(1)$(PYTHON_PKG_DIR)
endef

$(eval $(call BuildPackage,pycryptopp))
