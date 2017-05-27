THEOS_DEVICE_IP = 192.168.20.169


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = saulWeChatSayHello
saulWeChatSayHello_FILES = Tweak.xm SaulWeChatSayHello.m

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 MicroMessenger"
