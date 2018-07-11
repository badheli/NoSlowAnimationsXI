ARCHS = arm64

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = nsasettings
nsasettings_FILES = nsasettingsListController.m
nsasettings_INSTALL_PATH = /Library/PreferenceBundles
nsasettings_FRAMEWORKS = UIKit
nsasetting_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
    $(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library.PreferenceLoader/Preferences$(ECHO_END)
    $(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/nsasettings.plist$(ECHO_END)
