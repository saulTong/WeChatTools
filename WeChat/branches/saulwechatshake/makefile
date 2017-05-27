THEOS_DEVICE_IP = 192.168.20.83


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = saulWeChatShake
saulWeChatShake_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 MicroMessenger"
