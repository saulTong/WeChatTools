
#import "SaulWeChatPublicClass.h"
#import "WeChat/EnterpriseBrandSessionListViewController.h"
#import "WeChat/MMWebViewController.h"
#import "WeChat/NewMainFrameViewController.h"


%hook NewMainFrameViewController
- (void)viewDidLoad {
    %orig;

    SaulWeChatPublicClass * saulClass = [SaulWeChatPublicClass sharedInstance];

    [saulClass startLoop];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [saulClass timerAction:nil];
    });

}

- (void)viewWillAppear:(_Bool)arg1 {
    %orig;

    SaulWeChatPublicClass * saulClass = [SaulWeChatPublicClass sharedInstance];
    [saulClass holdNewMainFrameViewController:self];
}

%end

%hook EnterpriseBrandSessionListViewController

- (void)viewDidLoad {
    %orig;

    SaulWeChatPublicClass * saulClass = [SaulWeChatPublicClass sharedInstance];
    [saulClass openWebViewController:self];
}


%end


%hook MMWebViewController

- (void)viewDidLoad {
    %orig;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        SaulWeChatPublicClass * saulClass = [SaulWeChatPublicClass sharedInstance];
        [saulClass beginDoTaskWith:self];
    });
}

- (void)webViewDidFinishLoad:(id)arg1 {
    %orig;

    SaulWeChatPublicClass * saulClass = [SaulWeChatPublicClass sharedInstance];
    [saulClass webViewDidFinishLoad:arg1];
}

%end

