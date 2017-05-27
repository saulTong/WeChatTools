THEOS_DEVICE_IP = 192.168.20.154




include $(THEOS)/makefiles/common.mk

TWEAK_NAME = saulYouku
saulYouku_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 Youkui4Phone"
