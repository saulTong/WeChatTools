THEOS_DEVICE_IP = 192.168.20.6





include $(THEOS)/makefiles/common.mk

TWEAK_NAME = saulWeMediaTools
saulWeMediaTools_FILES = Tweak.xm SaulWeChatPublicClass.m WeChat/WeMediaToolsTableViewController.m AccountListController.m WeChat/MassTableViewController.m


include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 WeChat"
