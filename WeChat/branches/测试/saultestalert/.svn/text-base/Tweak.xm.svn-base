#import "WeChat/WCAccountLoginControlLogic.h"
#import "WeChat/WCAccountBaseControlLogic.h"
#import "WeChat/WCBaseControlLogic.h"
#import "WeChat/WCAccountLoginLastUserViewController.h"
#import "WeChat/WCAccountLoginFirstUserViewController.h"


%hook WCAccountLoginFirstUserViewController

- (void)viewDidLoad {
%orig;

dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

UIWindow *window = [UIApplication sharedApplication].keyWindow;

for(UIView *view in window.subviews)
{
    for (UIView * subv in view.subviews) {
NSLog(@"view is \n%@",subv);
        UIAlertController *alert = [[UIAlertController alloc] init];
        if([subv isKindOfClass:[alert.view class]]) {
            [alert removeFromParentViewController];
            [subv.superview removeFromSuperview];
        }
    }
}
});

}

%end

/*

%hook WCAccountLoginLastUserViewController

- (void)WCBaseInfoItemEditChanged:(id)arg1
{
%orig;
NSLog(@"WCBaseInfoItemEditChanged\n%@",arg1);
}

- (void)createLoginBtn:(id)arg1 relateView:(id)arg2
{
%orig;
NSLog(@"createLoginBtn\n%@-%@",arg1,arg2);

}


%end


%hook WCAccountBaseControlLogic

- (void)addTopViewController:(id)arg1
{
%orig;
NSLog(@"addTopViewController\n%@",arg1);
}

- (id)gotoViewController:(Class)arg1 withData:(id)arg2
{
id isRetuen = %orig;
NSLog(@"gotoViewController 1,2\n%@-%@",arg1,arg2);
return isRetuen;

}

- (id)gotoViewController:(Class)arg1 withData:(id)arg2 Animation:(_Bool)arg3
{
id isRetuen = %orig;
NSLog(@"gotoViewController 1,2,3\n%@-%@",arg1,arg2);
return isRetuen;
}

- (id)gotoViewController:(Class)arg1 withData:(id)arg2 Present:(_Bool)arg3
{
id isRetuen = %orig;
NSLog(@"gotoViewController 1,2,3\n%@-%@",arg1,arg2);
return isRetuen;
}
- (id)gotoViewController:(Class)arg1 withData:(id)arg2 Present:(_Bool)arg3 Animation:(_Bool)arg4
{
id isRetuen = %orig;
NSLog(@"gotoViewController 1,2,3,4\n%@-%@",arg1,arg2);
return isRetuen;
}

- (id)gotoViewController:(Class)arg1 withData:(id)arg2 Present:(_Bool)arg3 showNavigation:(_Bool)arg4 Animation:(_Bool)arg5
{
id isRetuen = %orig;
NSLog(@"gotoViewController 1,2,3,4,5\n%@-%@",arg1,arg2);
return isRetuen;
}

- (id)gotoViewController:(Class)arg1 withData:(id)arg2 Present:(_Bool)arg3 showNavigation:(_Bool)arg4 Animation:(_Bool)arg5 transitioningDelegate:(id)arg6
{
id isRetuen = %orig;
NSLog(@"gotoViewController 1,2,3,4,5,6\n%@-%@-%@",arg1,arg2,arg6);
return isRetuen;
}

- (id)gotoViewController:(Class)arg1 withData:(id)arg2 Title:(id)arg3 HeadTip:(id)arg4
{
id isRetuen = %orig;
NSLog(@"gotoViewController 1,2,3,4\n%@-%@-%@-%@",arg1,arg2,arg3,arg4);
return isRetuen;
}

- (id)gotoViewController:(Class)arg1 withData:(id)arg2 Title:(id)arg3 HeadTip:(id)arg4 Present:(_Bool)arg5
{
id isRetuen = %orig;
NSLog(@"gotoViewController 1,2,3,4,5\n%@-%@-%@-%@",arg1,arg2,arg3,arg4);
return isRetuen;
}

- (id)gotoViewController:(Class)arg1 withData:(id)arg2 Title:(id)arg3 HeadTip:(id)arg4 Present:(_Bool)arg5 Animation:(_Bool)arg6
{
id isRetuen = %orig;
NSLog(@"gotoViewController 1,2,3,4,5,6\n%@-%@-%@-%@",arg1,arg2,arg3,arg4);
return isRetuen;
}

- (id)gotoViewControllerHideNavigation:(Class)arg1 withData:(id)arg2 Animation:(_Bool)arg3
{
id isRetuen = %orig;
NSLog(@"gotoViewControllerHideNavigation 1,2,3\n%@-%@",arg1,arg2);
return isRetuen;
}

- (_Bool)onError:(id)arg1
{
BOOL isReturn = %orig;
NSLog(@"onError\n%@",arg1);

return isReturn;
}

- (void)showLoadingOK:(id)arg1
{
%orig;
NSLog(@"showLoadingOK\n%@",arg1);
}

%end


%hook WCBaseControlLogic

- (void)onErrorAction:(id)arg1
{
%orig;
    NSLog(@"onErrorAction\n%@",arg1);
}

- (_Bool)onHandleError:(id)arg1
{
BOOL isReturn = %orig;
NSLog(@"onHandleError\n%@",arg1);

return isReturn;
}

- (void)reportEnterView:(id)arg1
{
%orig;
NSLog(@"reportEnterView\n%@",arg1);
}
- (void)reportExitView:(id)arg1
{
%orig;
NSLog(@"reportExitView\n%@",arg1);
}
- (void)reportOpenMainView:(id)arg1
{
%orig;
NSLog(@"reportOpenMainView\n%@",arg1);
}

%end





















































































































%hook NSDictionary

+ (id)dictionaryWithContentsOfFile:(NSString *)path {

id result = %orig;

//NSLog(@"dic content is\n%@",result);

return result;
}
%end

*/
