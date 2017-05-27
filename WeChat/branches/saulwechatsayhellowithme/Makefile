THEOS_DEVICE_IP = 192.168.168.101

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = saulWeChatSayHelloWithMe
saulWeChatSayHelloWithMe_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 MicroMessenger"
