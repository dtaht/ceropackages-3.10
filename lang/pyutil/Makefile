#
# Copyright (C) 2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=pyutil
PKG_VERSION:=1.9.4
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://pypi.python.org/packages/source/p/pyutil
PKG_MD5SUM:=af51cf296b574112e115c9dfba51464d

TAR_CMD:=$(HOST_TAR) -C $(PKG_BUILD_DIR) --strip-components 1 $(TAR_OPTIONS)

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)

define Package/pyutil
  SECTION:=lang
  CATEGORY:=Languages
  SUBMENU:=Python
  TITLE:=A collection of utilities for Python programmers
  URL:=https://tahoe-lafs.org/trac/pyutil
  DEPENDS:=+python
endef

define Package/pyutil/description
  Write me!
endef

define Build/Compile
	$(call Build/Compile/PyMod,,install --prefix="/usr" --root="$(PKG_INSTALL_DIR)")
endef

define Package/pyutil/install
	$(INSTALL_DIR) $(1)$(PYTHON_PKG_DIR)
	$(CP) $(PKG_INSTALL_DIR)$(PYTHON_PKG_DIR)/* $(1)$(PYTHON_PKG_DIR)
endef

$(eval $(call BuildPackage,pyutil))
