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

define KernelPackage/sch_sfb
  SUBMENU:=Other modules
# DEPENDS:=@TARGET_ar71xx
  TITLE:=Stochastic Fair Blue Network queueing discipline
  URL:=http://www.pss.jussieu.fr/~jch/sfb
  CATEGORY:=Kernel
  FILES:=$(PKG_BUILD_DIR)/sch_sfb.ko
  VERSION:=$(LINUX_VERSION)-$(LINUX_RELEASE)
  AUTOLOAD:=$(call AutoLoad,30,sch_sfb)
endef

define KernelPackage/sch_sfb/description
  The SFB queuing disipline
endef

#define Build/Prepare
#	mkdir -p $(PKG_BUILD_DIR)
#	$(CP) ./* $(PKG_BUILD_DIR)/
#endef

define Build/Compile
	$(MAKE) -C "$(LINUX_DIR)" \
		CROSS_COMPILE="$(TARGET_CROSS)" \
		ARCH="$(LINUX_KARCH)" \
		SUBDIRS="$(PKG_BUILD_DIR)" \
		EXTRA_CFLAGS="$(BUILDFLAGS)" \
		modules
endef

define KernelPackage/sch_sfb/install
	$(INSTALL_DIR) $(1)/lib/modules/
	$(INSTALL_BIN) ./sch_sfb.ko $(1)/lib/modules/
endef

$(eval $(call KernelPackage,sch_sfb))

