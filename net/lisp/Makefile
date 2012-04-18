#
# Copyright (C) 2011 Vasileios Lakafosis <vasileios@gatech.edu>
# Copyright (C) 2011-2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=lispmob
#PKG_REV:=bdc7b19b46993b6847d9158b9b8c398bce95784a
PKG_VERSION:=0.2.3
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
#PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
#PKG_SOURCE_PROTO:=git
#PKG_SOURCE_URL:=git://github.com/LISPmob/lispmob.git
PKG_SOURCE_URL:=http://downloads.lispmob.org
PKG_MD5SUM:=d9647bde5ada1d8ccf1909d8c9c23385
#PKG_SOURCE_VERSION:=$(PKG_REV)

PKG_BUILD_DEPENDS:=confuse libopenssl
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/kernel-defaults.mk

define Package/lisp/Default
  TITLE:=LISP (Locator/ID Separation Protocol)
  URL:=http://lisp.cisco.com/
endef

define KernelPackage/lisp
  $(call Package/lisp/Default)
  SUBMENU:=Network Support
  TITLE+= support
  FILES:= \
    $(PKG_BUILD_DIR)/lisp_mod/lisp.ko \
    $(PKG_BUILD_DIR)/lisp_int/lisp_int.ko
  DEPENDS:=+kmod-ipt-core
endef

define KernelPackage/lisp/description
  Kernel module for the Locator/ID Separation Protocol.
endef

define Package/lispd
  $(call Package/lisp/Default)
  SECTION:=net
  CATEGORY:=Network
  TITLE+= daemon
  DEPENDS:=+confuse +ip +kmod-lisp +libopenssl +librt
endef

define Package/lispd/description
  This package provides support for the Locator/ID Separation Protocol.
endef

define Package/lispd/conffiles
/etc/lispd.conf
endef

define Package/lispconf
  $(call Package/lisp/Default)
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE+= configuration utility
  DEPENDS:=+lispd
endef

define Package/lispconf/description
  Run with "-x cache" to see cache map.
endef

MAKE_FLAGS += \
	PREFIX="/usr/sbin"

define Build/Compile
	$(MAKE) \
		$(KERNEL_MAKEOPTS) \
		SUBDIRS="$(PKG_BUILD_DIR)/lisp_int" \
		modules
	$(MAKE) \
		$(KERNEL_MAKEOPTS) \
		SUBDIRS="$(PKG_BUILD_DIR)/lisp_mod" \
		modules
	$(call Build/Compile/Default)
endef

define Package/lispd/install
	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/lispd/lispd.conf.example $(1)/etc/lispd.conf
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/lispd.init $(1)/etc/init.d/
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/lispd $(1)/usr/sbin/
endef

define Package/lispconf/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/lispconf $(1)/usr/sbin/
endef

$(eval $(call KernelPackage,lisp))
$(eval $(call BuildPackage,lispd))
$(eval $(call BuildPackage,lispconf))
