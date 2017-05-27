
#import "WeChat/EnterpriseBrandSessionListViewController.h"
#import "WeChat/MMWebViewController.h"
#import "WeChat/NewMainFrameViewController.h"


@interface SaulWeChatPublicClass : NSObject {
    NewMainFrameViewController * _newMainViewController;
    EnterpriseBrandSessionListViewController * _enterpriseBSLViewController;
    MMWebViewController * _currWebViewController;
    NSMutableArray * _taskArray;
    NSMutableArray * _readNumArray;
}
@property (nonatomic, strong) NSMutableArray * taskArray;
@property (nonatomic, strong) NSMutableArray * readNumArray;


+ (instancetype)sharedInstance;

- (void)startLoop;

- (void)holdNewMainFrameViewController:(NewMainFrameViewController *)viewController;

- (void)openEnterpriseBrandSessionView;

- (void)openWebViewController:(EnterpriseBrandSessionListViewController *)viewController;

- (void)beginDoTaskWith:(MMWebViewController *)viewController;

- (void)webViewDidFinishLoad:(UIWebView *)webview;

- (void)timerAction:(NSTimer*) timer;
@end
