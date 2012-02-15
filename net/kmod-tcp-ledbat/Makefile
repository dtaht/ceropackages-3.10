# 
# Copyright (C) 2006-2010 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=tcp-ledbat
PKG_VERSION:=20120214git
PKG_RELEASE:=2

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=git://github.com/silviov/TCP-LEDBAT.git
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_VERSION:=fe0a6626d3853009709953807543d2279a4b7cde
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define KernelPackage/kmod-tcp-ledbat
  SUBMENU:=Other modules
  TITLE:=TCP LEDBAT congestion control module
  URL:=https://github.com/silviov/TCP-LEDBAT
  FILES:=$(PKG_BUILD_DIR)/src/tcp_ledbat.ko
  CATEGORY:=Kernel
  VERSION:=$(LINUX_VERSION)-$(LINUX_RELEASE)
  AUTOLOAD:=$(call AutoLoad,30,tcp_ledbat)
endef

include $(INCLUDE_DIR)/kernel-defaults.mk

define KernelPackage/kmod-tcp-ledbat/description
  TCP-LEDBAT congestion control module implementing draft v9 of the standard
endef

define Build/Compile
	cd src
	$(MAKE) $(KERNEL_MAKEOPTS) SUBDIRS="$(PKG_BUILD_DIR)" modules
endef

define KernelPackage/kmod-tcp-ledbat/install
	$(INSTALL_DIR) $(1)/lib/modules/
	$(INSTALL_BIN) ./src/tcp_ledbat.ko $(1)/lib/modules/
endef

$(eval $(call KernelPackage,kmod-tcp-ledbat))
