#import "SaulWeChatPublicClass.h"

#import "WeChat/CMainControll.h"
#import "WeChat/MMWebViewController.h"
#import "WeChat/MoreViewController.h"
#import "WeChat/NewSettingViewController.h"
#import "WeChat/CAppViewControllerManager.h"
#import "WeChat/MicroMessengerAppDelegate.h"
#import "WeChat/NewMainFrameViewController.h"
#import "WeChat/WCAccountLoginLastUserViewController.h"
#import "WeChat/EnterpriseBrandSessionListViewController.h"


%hook NewMainFrameViewController

- (void)viewWillAppear:(_Bool)arg1 {
    %orig;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self openEnterpriseBrandSessionView:nil];
    });
}

%end

%hook EnterpriseBrandSessionListViewController

- (void)viewDidLoad {
    %orig;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self openCreateChat];
    });
}

%end



%hook MMWebViewController

- (void)viewDidLoad {
    %orig;

Ivar mDelegateVar = class_getInstanceVariable(objc_getClass("MMWebViewController"), "m_addressBarView");
UIImageView * mDelegate = object_getIvar(self, mDelegateVar);
mDelegate.backgroundColor = [UIColor redColor];


NSURL * url = [NSURL URLWithString:@"http://mp.weixin.qq.com/s?__biz=MjM5ODIyNjUyMA==&mid=2654395126&idx=1&sn=cf55fdc8da0e6fa5bd414da6582fc81b&chksm=bd0f85c18a780cd72f8e2ca745810ae164c235959fcf74c48e5748c09ad0607dbebbcc203bd2&mpshare=1&scene=1&srcid=1222YCyKzQH6nvUpQTZP2U8F&from=singlemessage&isappinstalled=0#rd"];
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
[self internalInitWithUrl:url presentModal:0 extraInfo:nil];
Ivar mDelegateVar = class_getInstanceVariable(objc_getClass("MMWebViewController"), "m_lastPageShot");
UIImageView * mDelegate = object_getIvar(self, mDelegateVar);
mDelegate.backgroundColor = [UIColor yellowColor];

});

}

- (void)webViewDidFinishLoad:(id)webView {
    %orig;

    SaulWeChatPublicClass * manager = [SaulWeChatPublicClass sharedInstance];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSInteger height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"] intValue];
        NSString* javascript = [NSString stringWithFormat:@"window.scrollBy(0, %lld);", (long long)height];
        [webView stringByEvaluatingJavaScriptFromString:javascript];

        [manager injectJQueryForWebView:webView];
    });
}


- (void)internalInitWithUrl:(id)arg1 presentModal:(_Bool)arg2 extraInfo:(id)arg3 {
 %orig;
//    NSLog(@"\n\n\n internalInitWithUrl \n %@ \n\n\n internalInitWithUrl",arg1);
//    NSLog(@"\n\n\n internalInitWithUrl \n %d \n\n\n internalInitWithUrl",arg2);
//    NSLog(@"\n\n\n internalInitWithUrl \n %@ \n\n\n internalInitWithUrl",arg3);
}




%end

%hook UIWebView

- (id)initWithFrame:(CGRect)frame {
    id orig = %orig;

    if([orig isMemberOfClass: [UIWebView class]]) {
//        SaulWeChatPublicClass * manager = [SaulWeChatPublicClass sharedInstance];
//        [manager holdWebView:orig];
    }

    return orig;
}

%end

