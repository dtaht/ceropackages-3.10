#
# Copyright (C) 2006-2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=sch_sfb
PKG_VERSION:=20110409
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://www.pps.jussieu.fr/~jch/software/files/
PKG_MD5SUM:=e28db32a892f8f21eff4d647ee479e74

include $(INCLUDE_DIR)/package.mk

# FIXME, need depends

define KernelPackage/kmod-sfb
  TITLE:="Stochastic Fair Blue"
  URL:=http://www.pss.jussieu.fr/~jch/sfb
  CATEGORY:=Kernel
  FILES:=$(LINUX_DIR)/net/sched/sch_sfb.ko
  VERSION:=$(LINUX_VERSION)-$(LINUX_RELEASE)
  AUTOLOAD:=$(call AutoLoad,30,sch_sfb)
endef

define KernelPackage/kmod-sfb/description
The SFB qdisc
endef

define KernelPackage/kmod-sfb/build
	make KERNEL_SOURCE=$(LINUX_DIR)
endef

define KernelPackage/kmod-sfb/install
	$(CP) $(PKG_INSTALL_DIR)/sch_sfb.ko $(1)/lib/modules/net/sched/
endef

$(eval $(call KernelPackage,kmod-sfb))
