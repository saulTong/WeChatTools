
// Logos by Dustin Howett
// See http://iphonedevwiki.net/index.php/Logos

// WeChat use Headers

#import "WeChat/CMainControll.h"
#import "WeChat/MMWebViewController.h"
#import "WeChat/MoreViewController.h"
#import "WeChat/NewSettingViewController.h"
#import "WeChat/CAppViewControllerManager.h"
#import "WeChat/MicroMessengerAppDelegate.h"
#import "WeChat/NewMainFrameViewController.h"
#import "WeChat/WCAccountLoginLastUserViewController.h"
#import "WeChat/EnterpriseBrandSessionListViewController.h"

#import "xFiles/XWeManager.h"


%hook WCAccountLoginLastUserViewController

- (void)viewDidLoad {
    %orig;

    XWeManager* weMgr = [XWeManager sharedInstance];

    Ivar mDelegateVar = class_getInstanceVariable(objc_getClass("WCAccountLoginLastUserViewController"), "m_delegate");

    id mDelegate = object_getIvar(self, mDelegateVar);

    [weMgr doLoginAction:mDelegate];

}

%end

%hook CMainControll
-(id) init {
    
    id orig = %orig;

    XWeManager* weMgr = [XWeManager sharedInstance];

    [weMgr holdMainControll:self];

    return orig;
}
%end


%hook MoreViewController

- (void)viewDidLoad {
    %orig;

    XWeManager* weMgr = [XWeManager sharedInstance];
    [weMgr holdMoreViewController:self];
}

%end

%hook NewSettingViewController

- (void)viewDidLoad {
    %orig;
    XWeManager* weMgr = [XWeManager sharedInstance];
    [weMgr doSettingAction:self];
}

%end


%hook MicroMessengerAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    BOOL orig = %orig;

    Method theMethod = class_getClassMethod(objc_getClass("CAppViewControllerManager"), @selector(getAppViewControllerManager));

    IMP methodImp = method_getImplementation(theMethod);

    id appViewControllerMgr = methodImp(objc_getClass("CAppViewControllerManager"), @selector(getAppViewControllerManager));

    XWeManager* weMgr = [XWeManager sharedInstance];
    
    [weMgr tryLoadAccountInfo];

    NSLog(@"\n\nudid\n%@\n\n\n", [weMgr udid]);

    [weMgr holdAppViewControllerMgr:appViewControllerMgr];

    [weMgr  startLoop];

    return orig;
}

%end

%hook EnterpriseBrandSessionListViewController

- (void)viewDidLoad
{
    %orig;
    XWeManager* weMgr = [XWeManager sharedInstance];
    if([weMgr getWebviewStatus] > WVNone){
        NSLog(@"\n\n\n\n\n进入CreateChat页面\n\n\n\n\n\n");
        [self openCreateChat];
        
//        [self openEnterpriseChat];
    }
}

%end

%hook MMWebViewController

- (void)viewDidLoad
{
    %orig;

    XWeManager* weMgr = [XWeManager sharedInstance];
    [weMgr holdWebViewController:self];
}

- (void)webViewDidFinishLoad:(id)webView
{
    %orig;
    XWeManager* weMgr = [XWeManager sharedInstance];
    [weMgr injectJQueryForWebView:webView];
    [weMgr updateWebviewStatus:WVDidLoad];
    
//    UIWebView * web = (UIWebView *)webView;
//
//    NSString* url = [[web.request URL] absoluteString];
//    if ([url hasPrefix:@"https://mp.weixin.qq.com/s"] || [url hasPrefix:@"http://mp.weixin.qq.com/s"]) {
//        XWeManager* weMgr = [XWeManager sharedInstance];
////        [weMgr injectJQueryForWebView:webView];
//        [weMgr updateWebviewStatus:WVDidLoad];
//        NSLog(@"加载webView_URL\n%@\n",url);
//    }
}

// 从新加载或者刷新
- (void)webView:(id)webView didFailLoadWithError:(id)error
{
    %orig;
//    XWeManager* weMgr = [XWeManager sharedInstance];
//    [weMgr vewViewDidfaildWithWebView:webView andError:error];
}

- (void)reload
{
    %orig;

}

%end

%hook UIWebView

- (id)initWithFrame:(CGRect)frame
{
    id orig = %orig;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if([orig isMemberOfClass: [UIWebView class]]) {
            XWeManager* weMgr = [XWeManager sharedInstance];
            // 准备完成
            if([weMgr getWebviewStatus] == WVPrepare){
                [weMgr updateWebviewStatus:WVReady];
            }
        }
    });


    return orig;
}

%end
