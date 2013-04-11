#
# Copyright (C) 2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=nevow
PKG_VERSION:=0.10.0
PKG_RELEASE:=1

PKG_SOURCE:=Nevow-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://pypi.python.org/packages/source/N/Nevow
PKG_MD5SUM:=66dda2ad88f42dea05911add15f4d1b2

PKG_BUILD_DIR:=$(BUILD_DIR)/Nevow-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)

define Package/python-nevow
  SECTION:=lang
  CATEGORY:=Languages
  SUBMENU:=Python
  TITLE:=Web application construction kit
  URL:=http://divmod.org/trac/wiki/DivmodNevow
  DEPENDS:=+python-expat +twisted
endef

define Package/python-nevow/description
  Divmod Nevow is a web application construction kit written in Python. It is
  designed to allow the programmer to express as much of the view logic as
  desired in Python, and includes a pure Python XML expression syntax named stan
  to facilitate this. However it also provides rich support for designer-edited
  templates, using a very small XML attribute language to provide bi-directional
  template manipulation capability.
endef

define Build/Compile
	$(call Build/Compile/PyMod,,install --prefix="/usr" --root="$(PKG_INSTALL_DIR)")
endef

define Package/python-nevow/install
	$(INSTALL_DIR) $(1)$(PYTHON_PKG_DIR)
	$(CP) $(PKG_INSTALL_DIR)$(PYTHON_PKG_DIR)/* $(1)$(PYTHON_PKG_DIR)
endef

$(eval $(call BuildPackage,python-nevow))
