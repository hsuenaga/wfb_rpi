################################################################################
#
# wfbya
#
################################################################################
WFBYA_VERSION = 08f9e9637a3a69552e5cb0b674fa3ef7ff45410a
#WFBYA_SITE = $(call github,hsuenaga,wfb-ya,$(WFBYA_VERSION))
WFBYA_SITE = https://github.com/hsuenaga/wfb-ya.git
WFBYA_SITE_METHOD = git
WFBYA_GIT_SUBMODULES = YES

WFBYA_LICENSE = GPL-3.0+
WFBYA_LICENSE_FILES = LICENSE.txt
WFBYA_DEPENDENCIES = host-pkgconf libevent libpcap libsodium

define WFBYA_PERMISSIONS
/usr/bin/wfb_listener f 755 root root - - - - -
|xattr CAP_NET_RAW+eip
|xattr CAP_NET_ADMIN+eip
endef

$(eval $(cmake-package))
