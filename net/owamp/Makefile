#
# Copyright (C) 2011-2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=owamp
PKG_VERSION:=3.3
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://software.internet2.edu/sources/owamp
PKG_MD5SUM:=a8ed103d2f9c07e24ad23dc91b3d51b8

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/owamp
  SECTION:=net
  CATEGORY:=Network
  TITLE:=One-Way Ping
  URL:=http://www.internet2.edu/performance/owamp/
endef

define Package/owamp/description
  OWAMP is a command line client application and a policy daemon used to
  determine one way latencies between hosts. It is an implementation of the
  OWAMP protocol as defined by http://www.rfc-editor.org/rfc/rfc4656.txt.
endef

define Package/owping
  $(call Package/owamp)
  TITLE+= client
endef

define Package/owping/description
  $(call Package/owamp/description)
  This package contains the owamp client.
endef

define Package/powstream
  $(call Package/owamp)
  TITLE+= continuous client
endef

define Package/powstream/description
  $(call Package/owamp/description)
  This package contains the powstream client.
endef

define Package/owampd
  $(call Package/owamp)
  TITLE+= policy daemon
  DEPENDS:=+aespasswd +ntpd
endef

define Package/owampd/conffiles
/etc/owampd/owampd.conf
/etc/owampd/owampd.keys
/etc/owampd/owampd.limits
/etc/owampd/owampd.pfs
endef

define Package/owampd/description
  $(call Package/owamp/description)
  This package contains the owamp policy daemon.
endef

define Package/aespasswd
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=Used to create and manage an AES keyfile
  URL:=http://www.internet2.edu/performance/owamp/aespasswd.man.html
endef

define Package/aespasswd/description
  aespasswd is used to create and manage files that hold identity/key pairs. It
  is primarily used to manage the bwctld.keys file for bwctld and the
  owampd.keys file for owampd.
endef

define Package/pfstore
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=Used to create and manage a pass-phrase store
  URL:=http://www.internet2.edu/performance/owamp/pfstore.man.html
endef

define Package/pfstore/description
  pfstore is used to create and manage files that hold identity/pass-phrase
  pairs. It is primarily used to manage the owampd.pfs file for owampd.
endef

define Package/owping/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/owping $(1)/usr/bin/
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/ow{fetch,stats,up} $(1)/usr/bin/
endef

define Package/powstream/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/powstream $(1)/usr/bin/
endef

define Package/owampd/install
	$(INSTALL_DIR) $(1)/etc/owampd
	$(INSTALL_CONF) \
		$(PKG_BUILD_DIR)/conf/owampd.{conf,limits} \
		$(1)/etc/owampd/
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/owampd.init $(1)/etc/init.d/owampd
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/owampd $(1)/usr/bin/
endef

define Package/aespasswd/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/aespasswd $(1)/usr/bin/
endef

define Package/pfstore/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/pfstore $(1)/usr/bin/
endef

$(eval $(call BuildPackage,owping))
$(eval $(call BuildPackage,powstream))
$(eval $(call BuildPackage,owampd))
$(eval $(call BuildPackage,aespasswd))
$(eval $(call BuildPackage,pfstore))
