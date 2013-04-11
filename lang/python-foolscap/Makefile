#
# Copyright (C) 2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=foolscap
PKG_VERSION:=0.6.4
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://foolscap.lothar.com/releases
PKG_MD5SUM:=0aedae62a0be50da4f89d80b5b30c8a2

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)

define Package/python-foolscap
  SECTION:=lang
  CATEGORY:=Languages
  SUBMENU:=Python
  TITLE:=Python+Twisted RPC protocol
  URL:=http://foolscap.lothar.com/
  DEPENDS:=+pyopenssl +python-bzip2 +twisted
endef

define Package/python-foolscap/description
  "Foolscap" is an RPC protocol for Python+Twisted, providing a capability-based
  security model and flexible serialization. It is intended to replace Twisted's
  native "Perspective Broker" RPC system.
endef

define Build/Compile
	$(call Build/Compile/PyMod,,install --prefix="/usr" --root="$(PKG_INSTALL_DIR)")
endef

define Package/python-foolscap/install
	$(INSTALL_DIR) $(1)$(PYTHON_PKG_DIR)
	$(CP) $(PKG_INSTALL_DIR)$(PYTHON_PKG_DIR)/* $(1)$(PYTHON_PKG_DIR)
endef

$(eval $(call BuildPackage,python-foolscap))
