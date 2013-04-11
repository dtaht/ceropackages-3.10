#
# Copyright (C) 2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=zfec
PKG_VERSION:=1.4.24
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://pypi.python.org/packages/source/z/zfec
PKG_MD5SUM:=e1bca3a1f18374f72bdf8cd42ea9c91

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)

define Package/python-zfec
  SECTION:=lang
  CATEGORY:=Languages
  SUBMENU:=Python
  TITLE:=A fast erasure codec which can be used with the command-line, C, Python or Haskell
  URL:=https://tahoe-lafs.org/trac/zfec
  DEPENDS:=+python +python-zbase32 +pyutil
endef

define Package/python-zfec/description
  Generate redundant blocks of information such that if some of the blocks are
  lost then the original data can be recovered from the remaining blocks. This
  package includes command-line tools, C API, Python API, and Haskell API.
endef

define Build/Compile
	$(call Build/Compile/PyMod,,install --prefix="$(PKG_INSTALL_DIR)/usr")
endef

define Package/python-zfec/install
	$(INSTALL_DIR) $(1)$(PYTHON_PKG_DIR)
	$(CP) $(PKG_INSTALL_DIR)$(PYTHON_PKG_DIR)/* $(1)$(PYTHON_PKG_DIR)
endef

$(eval $(call BuildPackage,python-zfec))
