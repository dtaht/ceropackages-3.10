# 
# Copyright (C) 2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=sched-bcake
PKG_VERSION:=2015-git
PKG_RELEASE:=15

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=git://github.com/dtaht/bcake
PKG_SOURCE_VERSION:=952839a6d8c808cedbd396c1e0b3788db054da91
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_BUILD_ID:=$(PKG_SOURCE_VERSION)

include $(INCLUDE_DIR)/package.mk

define KernelPackage/sched-bcake
  SUBMENU:=Network Support
  TITLE:=simplified cake derived shaper
  URL:=https://github.com/dtaht/bcake
  FILES:=$(PKG_BUILD_DIR)/sch_cake.ko
  VERSION:=$(LINUX_VERSION)-$(LINUX_RELEASE)
  AUTOLOAD:=$(call AutoLoad,75,sch_cake)
endef

include $(INCLUDE_DIR)/kernel-defaults.mk

define KernelPackage/sched-bcake/description
  Common Applications Kept Enhanced simplified cake shaper
endef

define Build/Compile
	$(MAKE) $(KERNEL_MAKEOPTS) SUBDIRS="$(PKG_BUILD_DIR)" modules
endef

$(eval $(call KernelPackage,sched-bcake))
