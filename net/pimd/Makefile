#
# Copyright (C) 2006-2011 OpenWrt.org
#
# Free software, licensed under the GNU Affero General Public License v3.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

PKG_NAME:=pimd
PKG_VERSION:=2.1.7
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=ftp://ftp.vmlinux.org/pub/People/jocke/pimd/
PKG_MD5SUM:=b7c9fb10d6ae8db526b752cfe425ebd5

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/pimd
  SECTION:=net
  TITLE:=a PIMv2 compliant routing daemon
  URL:=http://github.com/troglobit/pimd
endef

define Package/pimd/description
 Pimd is implementation of Protocol Independent Multicast routing daemon.
 It supports PIMv2-SM on FreeBSD, NetBSD, OpenBSD, Linux. Enable PIM support
 in kernel is needed.
endef

MAKE_FLAGS += \
	LIBS="$(TARGET_LDFLAGS) \
		-Wl,-rpath-link=$(STAGING_DIR)/usr/lib" \
	BINDIR="/usr/bin" \
	DOCDIR="/usr/share/man/man1/" \
	SHAREDLIBDIR="/usr/lib/pimd" \
	PLATFORM="Linux"

define Package/pimd/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/pimd $(1)/usr/sbin/
endef

$(eval $(call BuildPackage,pimd))
