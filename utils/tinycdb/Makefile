# 
# Copyright (C) 2006-2008 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=tinycdb
PKG_RELEASE:=1
PKG_SOURCE_URL:=http://www.corpit.ru/mjt/tinycdb/
PKG_VERSION:=0.77
PKG_MD5SUM:=c00e5fb96c30356ac3b67b2ab5d5641b

PKG_SOURCE:=$(PKG_NAME)_$(PKG_VERSION).tar.gz

include $(INCLUDE_DIR)/package.mk

define Package/tinycdb
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=TinyCDB
  URL:=http://www.corpit.ru/mjt/tinycdb.html
  MAINTAINER:=Denis Shulyaka <Shulyaka@gmail.com>
#  DEPENDS:=
endef

define Package/tinycdb/description
 TinyCDB is a very fast and simple package for creating and reading constant data bases
endef

define Package/tinycdb/install
        cd $(PKG_BUILD_DIR); $(MAKE) DESTDIR=$(1) install
endef

$(eval $(call BuildPackage,tinycdb))
