# 
# Copyright (C) 2006-2010 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=sch_sfb
PKG_VERSION:=20110409
PKG_RELEASE:=2

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://www.pps.jussieu.fr/~jch/software/files/
PKG_MD5SUM:=e28db32a892f8f21eff4d647ee479e74

include $(INCLUDE_DIR)/package.mk

define KernelPackage/sch_sfb
  SUBMENU:=Other modules
  TITLE:=Stochastic Fair Blue Network queueing discipline
  URL:=http://www.pss.jussieu.fr/~jch/sfb
  FILES:=$(PKG_BUILD_DIR)/sch_sfb.ko
  CATEGORY:=Kernel
  VERSION:=$(LINUX_VERSION)-$(LINUX_RELEASE)
  AUTOLOAD:=$(call AutoLoad,30,sch_sfb)
endef

include $(INCLUDE_DIR)/kernel-defaults.mk

define KernelPackage/sch_sfb/description

endef

define Build/Compile
	$(MAKE) $(KERNEL_MAKEOPTS) SUBDIRS="$(PKG_BUILD_DIR)" modules
endef

$(eval $(call KernelPackage,sch_sfb))
