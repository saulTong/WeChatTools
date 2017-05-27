THEOS_DEVICE_IP = 192.168.20.202

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = saulLoginTest
saulLoginTest_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 weChat"
