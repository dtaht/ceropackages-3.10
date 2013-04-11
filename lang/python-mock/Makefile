#
# Copyright (C) 2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=mock
PKG_VERSION:=0.8.0
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).zip
PKG_SOURCE_URL:=http://mock.googlecode.com/files
PKG_MD5SUM:=7dba423ce7994c433f6b84b101f1f4ba

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)

define Package/python-mock
  SECTION:=lang
  CATEGORY:=Languages
  SUBMENU:=Python
  TITLE:=Mocking and Testing Library
  URL:=http://www.voidspace.org.uk/python/mock/
  DEPENDS:=+python
endef

define Package/python-mock/description
  mock is a library for testing in Python. It allows you to replace parts of
  your system under test with mock objects and make assertions about how they
  have been used.
endef

define Build/Compile
	$(call Build/Compile/PyMod,,install --prefix="/usr" --root="$(PKG_INSTALL_DIR)")
endef

define Package/python-mock/install
	$(INSTALL_DIR) $(1)$(PYTHON_PKG_DIR)
	$(CP) $(PKG_INSTALL_DIR)$(PYTHON_PKG_DIR)/* $(1)$(PYTHON_PKG_DIR)
endef

$(eval $(call BuildPackage,python-mock))
