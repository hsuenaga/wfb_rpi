################################################################################
#
# rtw88
#
################################################################################
RTW88_VERSION = b89af8cd40d9528b0cdb9a6251efe49d8a69bfc6
RTW88_SITE = $(call github,lwfinger,rtw88,$(RTW88_VERSION))

RTW88_LICENSE = GPL-2.0
#RTW88_LICENSE_FILES = COPYING

$(eval $(kernel-module))

RTW88_FIRMWARE_DIR = "$(TARGET_DIR)/lib/firmware/rtw88"
RTW88_CONF_DIR = "$(TARGET_DIR)/etc/modprobe.d"
define RTW88_INSTALL_FW
	@echo "Installing Firmware to $(RTW88_FIRMWARE_DIR)"
	@install -Dvm 644 -t $(RTW88_FIRMWARE_DIR) $(@D)/firmware/*.bin
	@xz -f -C crc32 $(RTW88_FIRMWARE_DIR)/*.bin
	@echo "Installing Blacklist to $(RTW88_CONF_DIR)"
	@install -Dvm 644 -t $(RTW88_CONF_DIR) $(@D)/rtw88.conf
endef
RTW88_POST_BUILD_HOOKS += RTW88_INSTALL_FW

$(eval $(generic-package))
