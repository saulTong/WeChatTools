THEOS_DEVICE_IP = 192.168.20.49


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = saulLoginList
saulLoginList_FILES = Tweak.xm AccountListController.m 

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 WeChat"
