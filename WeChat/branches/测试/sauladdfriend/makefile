THEOS_DEVICE_IP = 192.168.3.78

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = saulAddFriend
saulAddFriend_FILES = Tweak.xm SaulWeChatAddFriend.m

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 MicroMessenger"
