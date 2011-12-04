#
# Copyright (C) 2007 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# $Id$

include $(TOPDIR)/rules.mk

PKG_NAME:=samba
PKG_VERSION:=3.6.1
PKG_RELEASE:=1

PKG_SOURCE_URL_SUBDIR:=/
PKG_SOURCE_URL:=http://ftp.samba.org/pub/samba$(PKG_SOURCE_URL_SUBDIR)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_MD5SUM:=5291717be0734e07dc07b6110e162e87

include $(INCLUDE_DIR)/package.mk

MAKE_PATH:=source3
CONFIGURE_PATH:=source3

PKG_BUILD_BIN:=$(PKG_BUILD_DIR)/$(MAKE_PATH)/bin

define Package/samba3x
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=Samba3 - NetBIOS/SMB
	TITLE:=Samba3 - NetBIOS/SMB
	URL:=http://www.samba.org/
endef

define Package/samba3x/description
 The Samba software suite is a collection of programs that implements the
 SMB protocol for UNIX systems, allowing you to serve files and printers to
 Windows, NT, OS/2 and DOS clients. This protocol is sometimes also referred
 to as the LanManager or Netbios protocol.
endef

define Package/samba3x-common
	$(call Package/samba3x)
	TITLE:=NetBIOS/SMB client and server shared files
endef

define Package/samba3x-server
	$(call Package/samba3x)
	TITLE:=NetBIOS/SMB file and print servers
	DEPENDS:=samba3x-common
endef

define Package/samba3x-client
	$(call Package/samba3x)
	TITLE:=NetBIOS/SMB client utilities
	DEPENDS:=samba3x-common
endef

TARGET_CFLAGS += -Os -DMAX_DEBUG_LEVEL=2
TARGET_LDFLAGS += -s -Wl,-rpath-link=$(STAGING_DIR)/usr/lib

CONFIGURE_VARS += \
	ac_cv_file__proc_sys_kernel_core_pattern=yes \
	libreplace_cv_HAVE_C99_VSNPRINTF=yes \
	libreplace_cv_HAVE_GETADDRINFO=yes \
	libreplace_cv_HAVE_IFACE_IFCONF=yes \
	LINUX_LFS_SUPPORT=yes \
	samba_cv_CC_NEGATIVE_ENUM_VALUES=yes \
	samba_cv_HAVE_GETTIMEOFDAY_TZ=yes \
	samba_cv_HAVE_IFACE_IFCONF=yes \
	samba_cv_HAVE_KERNEL_OPLOCKS_LINUX=yes \
	samba_cv_HAVE_SECURE_MKSTEMP=yes \
	samba_cv_HAVE_WRFILE_KEYTAB=no \
	samba_cv_USE_SETREUID=yes \
	samba_cv_USE_SETRESUID=yes \
	samba_cv_have_setreuid=yes \
	samba_cv_have_setresuid=yes

CONFIGURE_ARGS += \
	--exec-prefix=/usr \
	--prefix=/ \
	--disable-avahi \
	--disable-cups \
	--disable-pie \
	--disable-relro \
	--disable-static \
	--disable-swat \
	--with-codepagedir=/etc/samba \
	--with-configdir=/etc/samba \
	--with-included-iniparser \
	--with-included-popt \
	--with-lockdir=/var/lock \
	--with-logfilebase=/var/log \
	--with-nmbdsocketdir=/var/nmbd \
	--with-piddir=/var/run \
	--with-privatedir=/etc/samba \
	--with-sendfile-support \
	--without-cluster-support \
	--without-ads \
	--without-krb5 \
	--without-ldap \
	--without-pam \
	--without-winbind


define Package/samba3x-common/install
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DATA) ./files/samba.config $(1)/etc/config/samba
	$(INSTALL_DIR) $(1)/etc/samba
	$(INSTALL_DATA) ./files/smb.conf.template $(1)/etc/samba
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/codepages/lowcase.dat $(1)/etc/samba
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/codepages/upcase.dat $(1)/etc/samba
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/codepages/valid.dat $(1)/etc/samba
	$(INSTALL_DIR) $(1)/usr/lib
	$(INSTALL_BIN) $(PKG_BUILD_BIN)/libsmbclient.so.0 $(1)/usr/lib
	$(INSTALL_BIN) $(PKG_BUILD_BIN)/libtalloc.so.2 $(1)/usr/lib
	$(INSTALL_BIN) $(PKG_BUILD_BIN)/libtdb.so.1 $(1)/usr/lib
	#$(INSTALL_BIN) $(PKG_BUILD_BIN)/libwbclient.so.0 $(1)/usr/lib
endef

define Package/samba3x-client/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(INSTALL_BIN) $(PKG_BUILD_BIN)/libsmbsharemodes.so $(1)/usr/lib
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_BIN)/nmblookup $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_BIN)/net $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_BIN)/smbcacls $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_BIN)/smbclient $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_BIN)/smbcontrol $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_BIN)/smbget $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_BIN)/smbstatus $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_BIN)/smbtree $(1)/usr/bin
endef

define Package/samba3x-server/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/samba.init $(1)/etc/init.d/samba
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_BIN)/nmbd $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_BIN)/smbd $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_BIN)/smbpasswd $(1)/usr/sbin
	#$(INSTALL_BIN) $(PKG_BUILD_BIN)/winbindd $(1)/usr/sbin
endef

$(eval $(call BuildPackage,samba3x-common))
$(eval $(call BuildPackage,samba3x-client))
$(eval $(call BuildPackage,samba3x-server))

