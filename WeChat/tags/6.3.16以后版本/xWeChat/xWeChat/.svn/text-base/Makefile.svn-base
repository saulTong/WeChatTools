THEOS_DEVICE_IP = 192.168.20.151

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = xWeChat

xWeChat_FILES = xWeChat.xm xFiles/XWeManager.m xFiles/XPersistentThreadPool.m 

xWeChat_FRAMEWORKS = SystemConfiguration 

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 WeChat"
