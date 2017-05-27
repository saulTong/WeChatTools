#line 1 "/workware/source/projects/wemedia/xcode/wechat/xWeChat/xWeChat/xWeChat.xm"






#import "WeChat/MMWebViewController.h"
#import "WeChat/CAppViewControllerManager.h"
#import "WeChat/MicroMessengerAppDelegate.h"
#import "WeChat/NewMainFrameViewController.h"

#import "WeChat/EnterpriseBrandSessionListViewController.h"



#import "xFiles/XWeManager.h"


#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

#include <substrate.h>
@class MicroMessengerAppDelegate; @class UIWebView; @class MMWebViewController; @class EnterpriseBrandSessionListViewController; 
static BOOL (*_logos_orig$_ungrouped$MicroMessengerAppDelegate$application$didFinishLaunchingWithOptions$)(_LOGOS_SELF_TYPE_NORMAL MicroMessengerAppDelegate* _LOGOS_SELF_CONST, SEL, UIApplication *, NSDictionary *); static BOOL _logos_method$_ungrouped$MicroMessengerAppDelegate$application$didFinishLaunchingWithOptions$(_LOGOS_SELF_TYPE_NORMAL MicroMessengerAppDelegate* _LOGOS_SELF_CONST, SEL, UIApplication *, NSDictionary *); static void (*_logos_orig$_ungrouped$EnterpriseBrandSessionListViewController$viewDidLoad)(_LOGOS_SELF_TYPE_NORMAL EnterpriseBrandSessionListViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$EnterpriseBrandSessionListViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL EnterpriseBrandSessionListViewController* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$MMWebViewController$viewDidLoad)(_LOGOS_SELF_TYPE_NORMAL MMWebViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$MMWebViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL MMWebViewController* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$MMWebViewController$webViewDidFinishLoad$)(_LOGOS_SELF_TYPE_NORMAL MMWebViewController* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$_ungrouped$MMWebViewController$webViewDidFinishLoad$(_LOGOS_SELF_TYPE_NORMAL MMWebViewController* _LOGOS_SELF_CONST, SEL, id); static void (*_logos_orig$_ungrouped$MMWebViewController$reload)(_LOGOS_SELF_TYPE_NORMAL MMWebViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$MMWebViewController$reload(_LOGOS_SELF_TYPE_NORMAL MMWebViewController* _LOGOS_SELF_CONST, SEL); static UIWebView* (*_logos_orig$_ungrouped$UIWebView$initWithFrame$)(_LOGOS_SELF_TYPE_INIT UIWebView*, SEL, CGRect) _LOGOS_RETURN_RETAINED; static UIWebView* _logos_method$_ungrouped$UIWebView$initWithFrame$(_LOGOS_SELF_TYPE_INIT UIWebView*, SEL, CGRect) _LOGOS_RETURN_RETAINED; 

#line 19 "/workware/source/projects/wemedia/xcode/wechat/xWeChat/xWeChat/xWeChat.xm"


static BOOL _logos_method$_ungrouped$MicroMessengerAppDelegate$application$didFinishLaunchingWithOptions$(_LOGOS_SELF_TYPE_NORMAL MicroMessengerAppDelegate* _LOGOS_SELF_CONST self, SEL _cmd, UIApplication * application, NSDictionary * launchOptions) {
    BOOL orig = _logos_orig$_ungrouped$MicroMessengerAppDelegate$application$didFinishLaunchingWithOptions$(self, _cmd, application, launchOptions);

    Method theMethod = class_getClassMethod(objc_getClass("CAppViewControllerManager"), @selector(getAppViewControllerManager));
    IMP methodImp = method_getImplementation(theMethod);

    id appViewControllerMgr = methodImp(objc_getClass("CAppViewControllerManager"), @selector(getAppViewControllerManager));

    XWeManager* weMgr = [XWeManager sharedInstance];
    [weMgr holdAppViewControllerMgr:appViewControllerMgr];

    


    

NSLog(@"%@", weMgr);


    return orig;
}







static void _logos_method$_ungrouped$EnterpriseBrandSessionListViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL EnterpriseBrandSessionListViewController* _LOGOS_SELF_CONST self, SEL _cmd) {
    _logos_orig$_ungrouped$EnterpriseBrandSessionListViewController$viewDidLoad(self, _cmd);

    XWeManager* weMgr = [XWeManager sharedInstance];
    if([weMgr getWebviewStatus] > 0){
        [self openCreateChat];
    }
}







static void _logos_method$_ungrouped$MMWebViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL MMWebViewController* _LOGOS_SELF_CONST self, SEL _cmd) {
    _logos_orig$_ungrouped$MMWebViewController$viewDidLoad(self, _cmd);

    XWeManager* weMgr = [XWeManager sharedInstance];
    [weMgr holdWebViewController:self];
}


static void _logos_method$_ungrouped$MMWebViewController$webViewDidFinishLoad$(_LOGOS_SELF_TYPE_NORMAL MMWebViewController* _LOGOS_SELF_CONST self, SEL _cmd, id webView) {
    _logos_orig$_ungrouped$MMWebViewController$webViewDidFinishLoad$(self, _cmd, webView);

    XWeManager* weMgr = [XWeManager sharedInstance];
    [weMgr injectJQueryForWebView:webView];
}


static void _logos_method$_ungrouped$MMWebViewController$reload(_LOGOS_SELF_TYPE_NORMAL MMWebViewController* _LOGOS_SELF_CONST self, SEL _cmd) {
    _logos_orig$_ungrouped$MMWebViewController$reload(self, _cmd);
}






static UIWebView* _logos_method$_ungrouped$UIWebView$initWithFrame$(_LOGOS_SELF_TYPE_INIT UIWebView* self, SEL _cmd, CGRect frame) _LOGOS_RETURN_RETAINED {
    id orig = _logos_orig$_ungrouped$UIWebView$initWithFrame$(self, _cmd, frame);

if([orig isMemberOfClass: [UIWebView class]]) {

    XWeManager* weMgr = [XWeManager sharedInstance];
    
    if([weMgr getWebviewStatus] == 1){
        [weMgr updateWebviewStatus:2];
    }
}

    return orig;
}


static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$MicroMessengerAppDelegate = objc_getClass("MicroMessengerAppDelegate"); if (_logos_class$_ungrouped$MicroMessengerAppDelegate) {MSHookMessageEx(_logos_class$_ungrouped$MicroMessengerAppDelegate, @selector(application:didFinishLaunchingWithOptions:), (IMP)&_logos_method$_ungrouped$MicroMessengerAppDelegate$application$didFinishLaunchingWithOptions$, (IMP*)&_logos_orig$_ungrouped$MicroMessengerAppDelegate$application$didFinishLaunchingWithOptions$);} else {HBLogError(@"logos: nil class %s", "MicroMessengerAppDelegate");}Class _logos_class$_ungrouped$EnterpriseBrandSessionListViewController = objc_getClass("EnterpriseBrandSessionListViewController"); if (_logos_class$_ungrouped$EnterpriseBrandSessionListViewController) {MSHookMessageEx(_logos_class$_ungrouped$EnterpriseBrandSessionListViewController, @selector(viewDidLoad), (IMP)&_logos_method$_ungrouped$EnterpriseBrandSessionListViewController$viewDidLoad, (IMP*)&_logos_orig$_ungrouped$EnterpriseBrandSessionListViewController$viewDidLoad);} else {HBLogError(@"logos: nil class %s", "EnterpriseBrandSessionListViewController");}Class _logos_class$_ungrouped$MMWebViewController = objc_getClass("MMWebViewController"); if (_logos_class$_ungrouped$MMWebViewController) {MSHookMessageEx(_logos_class$_ungrouped$MMWebViewController, @selector(viewDidLoad), (IMP)&_logos_method$_ungrouped$MMWebViewController$viewDidLoad, (IMP*)&_logos_orig$_ungrouped$MMWebViewController$viewDidLoad);} else {HBLogError(@"logos: nil class %s", "MMWebViewController");}if (_logos_class$_ungrouped$MMWebViewController) {MSHookMessageEx(_logos_class$_ungrouped$MMWebViewController, @selector(webViewDidFinishLoad:), (IMP)&_logos_method$_ungrouped$MMWebViewController$webViewDidFinishLoad$, (IMP*)&_logos_orig$_ungrouped$MMWebViewController$webViewDidFinishLoad$);} else {HBLogError(@"logos: nil class %s", "MMWebViewController");}if (_logos_class$_ungrouped$MMWebViewController) {MSHookMessageEx(_logos_class$_ungrouped$MMWebViewController, @selector(reload), (IMP)&_logos_method$_ungrouped$MMWebViewController$reload, (IMP*)&_logos_orig$_ungrouped$MMWebViewController$reload);} else {HBLogError(@"logos: nil class %s", "MMWebViewController");}Class _logos_class$_ungrouped$UIWebView = objc_getClass("UIWebView"); if (_logos_class$_ungrouped$UIWebView) {MSHookMessageEx(_logos_class$_ungrouped$UIWebView, @selector(initWithFrame:), (IMP)&_logos_method$_ungrouped$UIWebView$initWithFrame$, (IMP*)&_logos_orig$_ungrouped$UIWebView$initWithFrame$);} else {HBLogError(@"logos: nil class %s", "UIWebView");}} }
#line 105 "/workware/source/projects/wemedia/xcode/wechat/xWeChat/xWeChat/xWeChat.xm"
