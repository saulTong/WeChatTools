#import "WeChat/CContact.h"
#import "WeChat/MMWebViewController.h"

%hook MMWebViewController
- (id)extraInfo {
id orig = %orig;

NSLog(@"extraInfo\n\n %@",orig);

dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
Ivar mDelegateVar = class_getInstanceVariable(objc_getClass("MMWebViewController"), "m_extraInfo");
NSMutableDictionary * mDelegate = object_getIvar(self, mDelegateVar);
NSLog(@"\n\n\n\n\n\n\n NSMutableDictionary \n %@",mDelegate);
});



return orig;
}
- (id)getAddressBarHostText:(id)arg1 {
id orig = %orig;

NSLog(@"getAddressBarHostText\n\n %@ \n\n %@",arg1,orig);

return orig;
}

- (unsigned int)GetGeneralBitSetForUrl:(id)arg1 {
int orig = %orig;

NSLog(@"GetGeneralBitSetForUrl\n\n %@ \n\n %lld",arg1,(long long)orig);

return orig;
}
- (id)getAuthorizedMonitorEvents:(id)arg1 {
id orig = %orig;
NSLog(@"getAuthorizedMonitorEvents\n\n %@ \n\n %@",arg1,orig);

return orig;
}

- (id)getOperationButtonImageNameWithURL:(id)arg1 {
id orig = %orig;
NSLog(@"getOperationButtonImageNameWithURL\n\n %@ \n\n %@",arg1,orig);

return orig;

}

- (id)getUrlPermission:(id)arg1 {
id orig = %orig;
NSLog(@"getUrlPermission\n\n %@ \n\n %@",arg1,orig);

return orig;
}

%end


%hook CContact

- (id)initWithCoder:(id)arg1 {
id orig = %orig;
NSLog(@"initWithCoder\n\n %@ \n\n %@",arg1,orig);

return orig;
}
- (id)initWithModContact:(id)arg1 {
id orig = %orig;
NSLog(@"initWithModContact\n\n %@ \n\n %@",arg1,orig);

return orig;
}
- (id)initWithShareCardMsgWrap:(id)arg1 {
id orig = %orig;
NSLog(@"initWithShareCardMsgWrap\n\n %@ \n\n %@",arg1,orig);

return orig;
}

- (id)initWithShareCardMsgWrapContent:(id)arg1 {
id orig = %orig;
NSLog(@"initWithShareCardMsgWrapContent\n\n %@ \n\n %@",arg1,orig);

return orig;
}




%end
