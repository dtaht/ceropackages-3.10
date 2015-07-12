# 
# Copyright (C) 2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=sched-fq_pie
PKG_VERSION:=2015-git
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=git://github.com/dtaht/sched_fq_pie
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_VERSION:=d5dfc7657c5187d0eabf97e84b5f414df8e9cc34
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define KernelPackage/sched-fq_pie
  SUBMENU:=Network Support
  TITLE:=sch_fq pie
  URL:=https://github.com/dtaht/sch_fq_pie
  FILES:=$(PKG_BUILD_DIR)/sch_fq_pie.ko
  VERSION:=$(LINUX_VERSION)-$(LINUX_RELEASE)
  AUTOLOAD:=$(call AutoLoad,75,sch_fq_pie)
endef

include $(INCLUDE_DIR)/kernel-defaults.mk

define KernelPackage/sched-fq_pie/description
	FQ_Pie - a combination of sch_fq + pie
endef

define Build/Compile
	$(MAKE) $(KERNEL_MAKEOPTS) SUBDIRS="$(PKG_BUILD_DIR)" modules
endef

$(eval $(call KernelPackage,sched-fq_pie))
