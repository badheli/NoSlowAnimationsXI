ARCHS = arm64

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = noslowanimationsxi
noslowanimationsxi_FILES = Tweak.xm
noslowanimationsxi_FRAMEWORKS = UIKit
noslowanimationsxi_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
    install.exec "killall -9 Springboard"
SUBPROJECTS += nsasettings
include $(THEOS_MAKE_PATH)/aggregate.mk
