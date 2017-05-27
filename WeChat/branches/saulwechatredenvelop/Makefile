THEOS_DEVICE_IP = 192.168.168.103


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = saulWeChatRedEnvelop
saulWeChatRedEnvelop_FILES = Tweak.xm
saulWeChatRedEnvelop_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 MicroMessenger"
