THEOS_DEVICE_IP = 192.168.2.245




include $(THEOS)/makefiles/common.mk

TWEAK_NAME = saulPraise
saulPraise_FILES = Tweak.xm SaulWeChatPublicClass.m

include $(THEOS_MAKE_PATH)/tweak.mk 

after-install::
	install.exec "killall -9 WeChat"
