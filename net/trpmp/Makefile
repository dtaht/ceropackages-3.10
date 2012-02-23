# Copyright (C) 2009-2010  Internet Systems Consortium, Inc. ("ISC")
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND ISC DISCLAIMS ALL WARRANTIES WITH
# REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
# AND FITNESS.  IN NO EVENT SHALL ISC BE LIABLE FOR ANY SPECIAL, DIRECT,
# INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
# LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE
# OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
# PERFORMANCE OF THIS SOFTWARE.

# trivial relay for extended NAT-PMP, Francis_Dupont@isc.org, December 2009

# $Id: Makefile 589 2010-01-15 05:00:12Z pselkirk $

include $(TOPDIR)/rules.mk

PKG_NAME:=trpmp
PKG_VERSION:=1.0b1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME).c


include $(INCLUDE_DIR)/package.mk

PKG_UNPACK:=$(CP) files/$(PKG_SOURCE) files/Makefile $(PKG_BUILD_DIR)

define Package/$(PKG_NAME)
        SECTION:=net
        CATEGORY:=AFTR
        MAINTAINER:=Francis Dupont <fdupont@isc.org>
        TITLE:=trivial relay for extended NAT-PMP
        URL:=https://www.isc.org/software/aftr
endef

define Build/Patch
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/$(PKG_NAME) $(1)/usr/sbin/
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
