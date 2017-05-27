#import "WeChat/WCAccountLoginLastUserViewController.h"
#import "WeChat/WCAccountLoginControlLogic.h"

%hook WCAccountLoginControlLogic

- (_Bool)onHandleError:(id)arg1
{
BOOL orig = %orig;

NSLog(@"onHandleError _ %@ ",arg1);


return orig;
}

%end

%hook WCAccountLoginLastUserViewController

- (void)viewDidLoad {
%orig;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{


    });

}

- (void)WCBaseInfoItemEditChanged:(id)arg1
{
%orig;

NSLog(@"WCBaseInfoItemEditChanged _ %@",arg1);
}

- (id)createFooterBtn:(id)arg1 target:(id)arg2 sel:(SEL)arg3{
id orig = %orig;

NSLog(@"createFooterBtn _ %@ _ %@ _ %@",arg1,arg2, NSStringFromSelector(arg3));

return orig;
}

- (void)createLoginBtn:(id)arg1 relateView:(id)arg2{
%orig;

NSLog(@"createLoginBtn _ %@ _ %@",arg1,arg2);
}

- (void)onMore:(id)arg1{
%orig;

 }

- (void)setDelegate:(id)arg1{
%orig;

NSLog(@"setDelegate _ %@",arg1);
}



%end
