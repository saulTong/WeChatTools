//
//  XWeManager.h
//  xWeChat
//
//  Created by vertex young on 16/4/27.
//
//

#import <Foundation/Foundation.h>

#import "../WeChat/CMainControll.h"
#import "../WeChat/MoreViewController.h"
#import "../WeChat/MMTabBarController.h"
#import "../WeChat/MMWebViewController.h"
#import "../WeChat/NewSettingViewController.h"
#import "../WeChat/CAppViewControllerManager.h"
#import "../WeChat/WCAccountLoginControlLogic.h"



typedef enum {
    TTDidExec = -2,
    TTNone = -1,
    TTRead = 0,
    TTPraise,
    TTComment,
    TTPAndC
} TaskType;


typedef enum {
    ESSwitching = -2,
    ESSwitch = -1,
    ESReady = 0,
    ESStart,
    ESLoad,
    ESPraise,
    ESComment
} ExecStatus;


typedef enum {
    WVNone = 0,
    WVPrepare,
    WVReady,
    WVLoading,
    WVDidLoad
} WVStatus;


#pragma mark - ###线程池元素
@interface ExecTask : NSObject
@property (nonatomic,assign) TaskType taskType;
@property (nonatomic,assign) ExecStatus execStatus;
@property (nonatomic,strong) NSDictionary* theTask;
@property (nonatomic,strong) NSDictionary* taskList;
@end


@interface AccountInfo : NSObject
@property (nonatomic, strong) NSDictionary *accInfo;
@property (nonatomic, strong) NSMutableSet *execAccs;

-(BOOL) isLoopOver;
-(BOOL) isMultiAccount;
-(void) resetExecAccount;
-(void) reduceAccount:(NSString*) account;

@end


@interface XWeManager : NSObject {
    ExecTask* _execTask;
    AccountInfo* _accountInfo;
    NSDictionary* _currentTask;
    CMainControll* _mainControll;
    MoreViewController* _moreViewController;
    CAppViewControllerManager* _AppViewControllerMgr;
    MMWebViewController* _currWebViewController;
    UIActivityIndicatorView* _activityIndicatorView;
    
    int _webviewStatus;  // Webview状态，0：idle；1：开始准备；2：准备成功 3：打开页面ing 4：已经打开页面
}

+(id)sharedInstance;

-(void) tryLoadAccountInfo;
-(BOOL) tryFetchAccountInfo;

-(NSString*) documentDirectory;

-(void) holdMainControll:(CMainControll*) mainControll;
-(void) holdWebViewController:(MMWebViewController*) webViewController;
-(void) holdMoreViewController:(MoreViewController*) moreViewController;
-(void) holdAppViewControllerMgr:(CAppViewControllerManager*) appViewControllerMgr;

-(id) getMMTabBarController;
-(id) getMoreViewController;
-(id) getCurrWebViewController;
-(id) getAppViewControllerManager;
-(id) getNewMainFrameViewController;

-(id) getLastLoginName;
-(id) getLastUserName;


-(id) getTopWebview;
-(int) getWebviewStatus;

-(void) createTopWebview;
-(void) updateWebviewStatus:(int)webviewStatus;

-(void) toRootView;
-(void) tryLogout;

-(BOOL) injectJQuery;
-(BOOL) defaultTools;
-(BOOL) containsJQuery;
-(NSString*) jQueryVersion;

-(BOOL) openUrl:(NSString*) path;

-(NSDictionary*) adDatas;
-(NSString*) getAppMsgExtUrl;

-(NSString*) execJavaScript:(NSString*) js;
-(NSString*) execJavaScript:(NSString*) js forWebView:(UIWebView*) webView;

-(NSString*) injectJavaScript:(NSString*) jsSrc;
-(NSString*) injectJavaScriptBlock:(NSString*) jsBlock;

-(NSString*) injectJavaScript:(NSString*) jsSrc forWebView:(UIWebView*) webView;
-(NSString*) injectJavaScriptBlock:(NSString*) jsBlock forWebView:(UIWebView*) webView;

-(BOOL) isPageDidLoad;
-(BOOL) isLogin;

-(int) mediaLikeNum;
-(int) mediaReadNum;

-(NSString*) udid;

-(void) injectMedia;
-(BOOL) isMediaDidInject;

-(NSArray*) contentIds;
-(BOOL) praiseCommentByContentId:(NSString*) contentId;


-(BOOL) injectJSLiteForWebView:(UIWebView*) webview;
-(BOOL) injectJQueryForWebView:(UIWebView*) webview;

-(int) praiseMedia;
-(int) praiseComment;


-(int) praiseMediaOnly;
-(int) praiseCommentOnly;
-(void) tryPraiseCommentOnly;

-(void) tryPraise;

-(void) showIndicator;
-(void) hideIndicator;

-(void) task;
-(BOOL) startLoop;

-(void) doLoginAction:(WCAccountLoginControlLogic*) accountLoginControlLogic;
-(void) doSettingAction:(NewSettingViewController*) newSettingViewController;

@end
