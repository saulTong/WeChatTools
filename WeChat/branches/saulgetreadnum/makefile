THEOS_DEVICE_IP = 192.168.20.162

ARCHS = armv7 arm64
TARGET = iphone:latest:8.0






include $(THEOS)/makefiles/common.mk

TWEAK_NAME = saulGetReadNum
saulGetReadNum_FILES = Tweak.xm SaulWeChatPublicClass.m

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 WeChat"
