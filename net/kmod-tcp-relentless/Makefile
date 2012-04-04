# 
# Copyright (C) 2006-2010 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=Relentless
#PKG_VERSION:=1
PKG_RELEASE:=1

PKG_SOURCE_URL:=http://staff.psc.edu/mathis/relentless/linux
PKG_SOURCE:=$(PKG_NAME).tar.gz
PKG_MD5SUM:=21a51847f74c6b6c6cee7d1ef8e45226

include $(INCLUDE_DIR)/package.mk

define KernelPackage/tcp-relentless
  SUBMENU:=Other modules
  TITLE:=TCP Relentless congestion control module
  URL:=http://staff.psc.edu/mathis/relentless/
  FILES:=$(PKG_BUILD_DIR)/tcp_relentless.ko
  VERSION:=$(LINUX_VERSION)-$(LINUX_RELEASE)
  AUTOLOAD:=$(call AutoLoad,30,tcp_relentless)
endef

include $(INCLUDE_DIR)/kernel-defaults.mk

define KernelPackage/tcp-relentless/description
  TCP-Relentless congestion control module (do not inflict on the internet)
endef

define Build/Compile
	$(MAKE) $(KERNEL_MAKEOPTS) SUBDIRS="$(PKG_BUILD_DIR)/" modules
endef

$(eval $(call KernelPackage,tcp-relentless))
