ARCHS = arm64

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = nsaforkbeta
nsaforkbeta_FILES = Tweak.xm
nsaforkbeta_FRAMEWORKS = UIKit
nsaforkbeta_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
    install.exec "killall -9 Springboard"
SUBPROJECTS += nsasettings
include $(THEOS_MAKE_PATH)/aggregate.mk
