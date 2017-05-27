THEOS_DEVICE_IP = 192.168.20.196





include $(THEOS)/makefiles/common.mk

TWEAK_NAME = saulSendMessage
saulSendMessage_FILES = Tweak.xm SaulWeChatPublicClass.m WeChat/MassTableViewController.m 

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 WeChat"
