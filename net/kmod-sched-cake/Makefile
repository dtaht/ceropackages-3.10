# 
# Copyright (C) 2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=sched-cake
PKG_VERSION:=2015-git
PKG_RELEASE:=7

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=git://github.com/dtaht/sch_cake
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_VERSION:=444f9e5c0fde1400f21175eacfa7ced60b410e49
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define KernelPackage/sched-cake
  SUBMENU:=Network Support
  TITLE:=Cake fq_codel derived shaper
  URL:=https://github.com/dtaht/sch_cake
  FILES:=$(PKG_BUILD_DIR)/sch_cake.ko
  VERSION:=$(LINUX_VERSION)-$(LINUX_RELEASE)
  AUTOLOAD:=$(call AutoLoad,75,sch_cake)
endef

include $(INCLUDE_DIR)/kernel-defaults.mk

define KernelPackage/sched-cake/description
  Common Applications Kept Enhanced fq_codel derived shaper
endef

define Build/Compile
	$(MAKE) $(KERNEL_MAKEOPTS) SUBDIRS="$(PKG_BUILD_DIR)" modules
endef

$(eval $(call KernelPackage,sched-cake))
