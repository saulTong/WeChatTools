//
//  XWeManager.m
//  xWeChat
//
//  Created by vertex young on 16/4/27.
//
//
#import <objc/runtime.h>
#import <objc/message.h>

#import "XWeManager.h"

#import "../WeChat/NewMainFrameViewController.h"

@implementation AccountInfo
-(void) reduceAccount:(NSString*) account
{
    if (!self.accInfo || !self.execAccs) {
        return;
    }
    
    [self.execAccs removeObject:account];
}

-(void) resetExecAccount
{
    if (!self.accInfo || !self.execAccs) {
        return;
    }
    
    [self.execAccs removeAllObjects];
    [self.execAccs addObjectsFromArray:[self.accInfo allKeys]];
    
}
-(BOOL) isMultiAccount
{
    return self.accInfo && self.accInfo.count>1;
}

-(BOOL) isLoopOver
{
    return !self.execAccs || self.execAccs.count == 0;
}

@end

@implementation ExecTask
@synthesize description;

-(NSString*) description{
    return [NSString stringWithFormat:@"\n%@\ntaskType:%d\nexecStatus:%d\ntaskList:\n%@", super.description, self.taskType, self.execStatus, self.taskList];
}
@end

@interface XWeManager (xWeChat)
-(UIWebView *) topWebView;
-(void) timerAction:(NSTimer*) timer;
@end

@implementation XWeManager

+(instancetype)sharedInstance {
    static XWeManager *singleton = nil;
    if (! singleton) {
        singleton = [[self alloc] initPrivate];
    }
    return singleton;
}

-(NSString*) documentDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    return [paths objectAtIndex:0];
}

-(BOOL) saveAccountInfo:(NSDictionary*) dict
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path = [paths objectAtIndex:0];
    if (!path) {
        return NO;
    }
    NSString *filename=[path stringByAppendingPathComponent:@"xWechatAccinfo.plist"];
    
    return [dict writeToFile:filename atomically:YES];
}

-(BOOL) tryFetchAccountInfo
{
    @try {
        NSError *error;
        NSString* path = [NSString stringWithFormat: @"http://x.laifuzi.cn/vstatic/data/acc1.json?token=%@", [self udid]];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:path] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60];
        NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:&error];
        if (!dict || dict.count == 0) {
            return NO;
        }
        
        return [self saveAccountInfo:dict];
        
    } @catch (...) {
    }
    return NO;
}

-(void) tryLoadAccountInfo
{
    if(!_accountInfo) {
        _accountInfo = [AccountInfo new];
    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    
    NSString *path = [paths objectAtIndex:0];
    if (!path) {
        return;
    }
    
    NSLog(@"++++++++++++tryLoadAccountInfo++++++++++++");
    NSLog(@"%@", path);
    NSLog(@"++++++++++++tryLoadAccountInfo++++++++++++");
    
    NSString *filename=[path stringByAppendingPathComponent:@"xWechatAccinfo.plist"];
    NSDictionary* dict = [NSDictionary dictionaryWithContentsOfFile:filename];
    _accountInfo.accInfo = dict;
    if (!dict || dict.count == 0) {
        _accountInfo.execAccs = nil;
    } else {
        NSMutableSet *sets = [NSMutableSet setWithCapacity:20];
        [sets addObjectsFromArray:[dict allKeys]];
        _accountInfo.execAccs = sets;
    }
    
    //NSLog(@"%@", _accountInfo);
}

-(NSString*) udid
{
    //    return @"921A1961-9FAD-441A-AE74-485E0B2B2C02"; // pad 10
    //    return @"0A1535A7-A61B-4FC1-BA9A-F77ECDD21FF0"; // pad 26
    //    return @"2BCFC986-431A-4B2A-9120-E690CD74F9EF"; // pad 25
    //    return @"BDF66718-65CD-4453-8165-53864735AB39"; // pad 24
    //    return @"0FD48A8B-724E-4418-8720-D0E03D28612F"; // iphone 22
    
    return [[UIDevice currentDevice].identifierForVendor UUIDString];
}

- (instancetype)init {
    return nil;
}
//实现自己真正的私有初始化方法
- (instancetype)initPrivate {
    _webviewStatus = WVNone;
    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    
    _activityIndicatorView.tag = 103;
    
    //设置显示样式,见UIActivityIndicatorViewStyle的定义
    _activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    
    
    //设置背景色
    _activityIndicatorView.backgroundColor = [UIColor blackColor];
    
    //设置背景透明
    _activityIndicatorView.alpha = 0.5;
    
    //设置背景为圆角矩形
    _activityIndicatorView.layer.cornerRadius = 6;
    _activityIndicatorView.layer.masksToBounds = YES;
    
    self  = [super init];
    
    [self resetExecTask];
    
    
    return self;
}

-(void) createTopWebview {
    @try {
        id newMainFrameViewController = [self getNewMainFrameViewController];
        [self updateWebviewStatus:1];
        [newMainFrameViewController openEnterpriseBrandSessionView:nil];
    }
    @catch(...){
    }
}


-(void) toRootView
{
    if(_AppViewControllerMgr){
        [[_AppViewControllerMgr getNewMainFrameViewController] popToSelfViewController];
    }
}

-(void) tryLogout
{
    [self toRootView];
    MMTabBarController* tbc = [self getMMTabBarController];
    [tbc setSelectedIndex:3];
}

-(UIWebView*) topWebView
{
    if(_currWebViewController == nil) return nil;
    return _currWebViewController.webView;
}

-(int) getWebviewStatus
{
    return _webviewStatus;
}

-(id) getTopWebview
{
    return [self topWebView];
}

-(void) holdMainControll:(CMainControll*) mainControll
{
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"\n%@\n%@", _mainControll, mainControll);
    
    
    if (_mainControll) {
        [_mainControll release];
    }
    _mainControll = [mainControll retain];
}

-(void) holdMoreViewController:(MoreViewController*) moreViewController
{
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"\n%@\n%@", _moreViewController, moreViewController);
    
    if (_moreViewController) {
        [_moreViewController release];
    }
    
    _moreViewController = [moreViewController retain];
}


-(void) holdWebViewController:(MMWebViewController*) webViewController
{
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"\n%@\n%@", _currWebViewController, webViewController);
    
    if(_currWebViewController) {
        [_currWebViewController release];
    }
    _currWebViewController = [webViewController retain];
}

-(void) holdAppViewControllerMgr:(CAppViewControllerManager*) appViewControllerMgr {
    
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"\n%@\n%@", _AppViewControllerMgr, appViewControllerMgr);
    
    if(_AppViewControllerMgr) {
        [_AppViewControllerMgr release];
    }
    
    
    _AppViewControllerMgr = [appViewControllerMgr retain];
}

- (id) getNewMainFrameViewController {
    
    if(_AppViewControllerMgr == nil) return nil;
    
    return [_AppViewControllerMgr getNewMainFrameViewController];
}

-(id) getCurrWebViewController {
    return _currWebViewController;
}

-(id) getMoreViewController
{
    return _moreViewController;
}

-(BOOL) isPageDidLoad
{
    if(!_currWebViewController)
        return FALSE;
    
    return [_currWebViewController isPageDidLoad]?YES:NO;
}

-(id) getMMTabBarController
{
    if (!_AppViewControllerMgr) {
        return nil;
    }
    
    return [_AppViewControllerMgr getTabBarController];
}

-(id) getAppViewControllerManager {
    return _AppViewControllerMgr;
}

-(void) updateWebviewStatus:(int)webviewStatus
{
    _webviewStatus = webviewStatus;
    if (_webviewStatus == WVDidLoad) {
        [self webViewDidLoad];
    }
}

-(NSString*) execJavaScript:(NSString*) js
{
    UIWebView *webView = [self topWebView];
    if(!webView || !js) return nil;
    
    return [self execJavaScript:js forWebView:webView];
}

-(NSString*) execJavaScript:(NSString*) js forWebView:(UIWebView*) webView
{
    return [webView stringByEvaluatingJavaScriptFromString:js];
}

-(NSString*) injectJavaScript:(NSString*) jsSrc
{
    NSString *script = [NSString stringWithFormat:@"var script=document.createElement('script');script.type='text/javascript';script.src='%@';document.getElementsByTagName('head')[0].appendChild(script);", jsSrc];
    
    return [self execJavaScript:script];
}

-(NSString*) injectJavaScriptBlock:(NSString*) jsBlock
{
    NSString *script = [NSString stringWithFormat:@"var script=document.createElement('script');script.type='text/javascript';script.text='%@';document.getElementsByTagName('head')[0].appendChild(script);", jsBlock];
    
    return [self execJavaScript:script];
}

-(NSString*) injectJavaScript:(NSString*) jsSrc forWebView:(UIWebView*) webView
{
    NSLog(@"-----------injectJavaScript:forWebView-------------");
    NSLog(@"%@", webView);
    NSLog(@"-----------injectJavaScript:forWebView-------------");
    
    NSString *script = [NSString stringWithFormat:@"var script=document.createElement('script');script.type='text/javascript';script.src='%@';document.getElementsByTagName('head')[0].appendChild(script);", jsSrc];
    
    return [self execJavaScript:script forWebView:webView];
}

-(NSString*) injectJavaScriptBlock:(NSString*) jsBlock forWebView:(UIWebView*) webView
{
    NSString *script = [NSString stringWithFormat:@"var script=document.createElement('script');script.type='text/javascript';script.text='%@';document.getElementsByTagName('head')[0].appendChild(script);", jsBlock];
    
    return [self execJavaScript:script forWebView:webView];
}

-(NSDictionary*) adDatas
{
    @try {
        NSString* jsonString = [self execJavaScript:@"(function(){var e=JSON.stringify(window._adRenderData); return e;})();"];
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        return [[[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil] objectForKey:@"advertisement_info"] valueForKey:@"0"];
    } @catch (...) {
        
    }
    return nil;
}

-(NSString*) getAppMsgExtUrl
{
    NSString*script = @"(function(){var url=\"https://mp.weixin.qq.com/mp/getappmsgext?__biz=\" + biz + \"&appmsg_type=\" + appmsg_type + \"&mid=\" + mid + \"&sn=\" + sn + \"&idx=\" + idx + \"&scene=\" + source + \"&title=\" + encodeURIComponent(msg_title.htmlDecode()) + \"&ct=\" + ct + \"&devicetype=\" + devicetype.htmlDecode() + \"&version=\" + version.htmlDecode() + \"&f=json&r=\" + Math.random() + \"&is_need_ticket=1&is_need_ad=1&comment_id=\" + comment_id + \"&is_need_reward=0&both_ad=1&reward_uin_count=0\" +\"&uin=\" + uin + \"&key=\" + key + \"&pass_ticket=\" + pass_ticket + \"&wxtoken=\" + wxtoken + \"&devicetype=\" + devicetype + \"&clientversion=\" + clientversion + \"&x5=0\"; return url;})();";
    
    return [self execJavaScript:script];
}

-(BOOL) injectJQuery
{
    NSString *jsFile=[[self documentDirectory] stringByAppendingPathComponent:@"jquery.min.js"];
    NSString* jscript = [NSString stringWithContentsOfFile:jsFile encoding:NSUTF8StringEncoding error:nil];
    return [self execJavaScript:jscript] != nil;
}

-(BOOL) defaultTools
{
    NSString*script = @"var pp=function(a){var b=a.children(\"span[class=praise_num]\"),c=b.html(),d=c.indexOf(\"\u4e07\"),c=parseInt(c)?parseInt(c):0;0<=d&&b.html(c+1);a.data(\"status\",1);a.addClass(\"praised\")},xx=function(a){$.ajax(\"https://mp.weixin.qq.com/mp/appmsg_comment?action=likecomment&&like=1&__biz=\"+biz+\"&appmsgid=\"+appmsgid+\"&comment_id=\"+comment_id+\"&content_id=\"+a+\"&uin=\"+uin+\"&key=\"+key+\"&pass_ticket=\"+pass_ticket+\"&wxtoken=\"+wxtoken+\"&devicetype=\"+devicetype+\"&clientversion=\"+clientversion+\"&x5=0\",{async:!1})},nn=function(a){$.ajax(\"https://mp.weixin.qq.com/mp/appmsg_like?__biz=\"+biz+\"&mid=\"+mid+\"&idx=\"+idx+\"&like=1&f=json&appmsgid=\"+appmsgid+\"&itemidx=\"+itemidx+\"&uin=\"+uin+\"&key=\"+key+\"&pass_ticket=\"+pass_ticket+\"&wxtoken=\"+wxtoken+\"&devicetype=\"+devicetype+\"&clientversion=\"+clientversion+\"&x5=0\",{async:!1,method:\"POST\"})},yy=function(a){return $(\"span[class~=js_comment_praise][data-content-id=\"+a+\"]\")},cc=$(\"span[class~=js_comment_praise][data-status=0]\"),dd=function(){var a=[];cc.each(function(){var b=$(this);a.push(b.data(\"content-id\"))});return a.join(\",\")},vv=function(a){var b=yy(a);pp(b);xx(a)},oo=function(){cc.each(function(){var a=$(this),b=a.data(\"content-id\");pp(a);xx(b)})},ll=function(){var a=$(\"span[id=readNum3]\").html();return a=parseInt(a)?parseInt(a):0},kk=function(){var a=$(\"span[id=likeNum3]\").html();return a=parseInt(a)?parseInt(a):0},tt=function(){return !0};";
    
    return [self execJavaScript:script] != nil;
}

-(BOOL) injectJSLiteForWebView:(UIWebView*) webview
{
    NSString *jsFile=[[self documentDirectory] stringByAppendingPathComponent:@"JSLite.min.js"];
    
    NSString* jsLite = [NSString stringWithContentsOfFile:jsFile encoding:NSUTF8StringEncoding error:nil];
    
    NSLog(@"-----------injectJSLiteForWebView:forWebView-------------");
    NSLog(@"%@", webview);
    NSLog(@"%@", jsLite);
    NSLog(@"-----------injectJSLiteForWebView:forWebView-------------");
    
    return [self execJavaScript:jsLite forWebView:webview] != nil;
}

-(BOOL) injectJQueryForWebView:(UIWebView*) webview
{
    NSString *jsFile=[[self documentDirectory] stringByAppendingPathComponent:@"jquery.min.js"];
    NSString* jscript = [NSString stringWithContentsOfFile:jsFile encoding:NSUTF8StringEncoding error:nil];
    
    return [self execJavaScript:jscript forWebView:webview] != nil;
}

-(int) praiseMedia2
{
    @try {
        NSString *script = @"(function(){var a=document.getElementById('like3'),b=0;a&&'0'==a.getAttribute('like')&&(a.click(),b=1);return b})();";
        return [[self execJavaScript:script] intValue];
    } @catch (...) {
    }
    return 0;
}

-(int) praiseMedia
{
    @try {
        NSString *script = @"(function(){var a=document.getElementById('like3'),b=0,nn=function(a){$.ajax(\"https://mp.weixin.qq.com/mp/appmsg_like?__biz=\"+biz+\"&mid=\"+mid+\"&idx=\"+idx+\"&like=1&f=json&appmsgid=\"+appmsgid+\"&itemidx=\"+itemidx+\"&uin=\"+uin+\"&key=\"+key+\"&pass_ticket=\"+pass_ticket+\"&wxtoken=\"+wxtoken+\"&devicetype=\"+devicetype+\"&clientversion=\"+clientversion+\"&x5=0\",{async:!1,method:\"POST\"})};a&&'0'==a.getAttribute('like')&&(nn(),b=1);return b})();";
        return [[self execJavaScript:script] intValue];
    } @catch (...) {
    }
    return 0;
}

-(int) mediaReadNum
{
    NSString *num=[self execJavaScript:@"(function(){return document.getElementById('readNum3').innerHTML})()"];
    
    if(num == nil) return -1;
    
    return [num intValue];
}

-(int) mediaLikeNum
{
    NSString *num=[self execJavaScript:@"(function(){return document.getElementById('likeNum3').innerHTML})()"];
    
    if(num == nil) return -1;
    
    return [num intValue];
}

-(BOOL) isMediaDidInject {
    @try {
        NSString *s = [self execJavaScript:@"tt()"];
        if (!s) {
            return NO;
        }
        return [s boolValue];
    } @catch (...) {
    }
    return NO;
}

-(BOOL) containsJQuery
{
    NSString* version = [self jQueryVersion];
    return version !=nil && [version length]>0;
}

-(NSString*) jQueryVersion
{
    return [self execJavaScript:@"(function(){return $().jquery;})()"];
}

-(BOOL) openUrl:(NSString*) path
{
    @try {
        UIWebView *webView = [self topWebView];
        if(!webView) return FALSE;
        
        NSURL* url = [[NSURL alloc] initWithString:path];
        [webView loadRequest:[NSURLRequest requestWithURL:url]];
        
        return TRUE;
    } @catch (...) {
    }
    
    return FALSE;
}

-(NSArray*) contentIds
{
    NSString* s = [self execJavaScript:@"dd()"];
    if (!s || s.length == 0) {
        return nil;
    }
    
    return [s componentsSeparatedByString:@","];
}

-(void) injectMedia
{
    if (![self isMediaDidInject]) {
        [self performSelectorOnMainThread:@selector(defaultTools) withObject:nil waitUntilDone:YES];
    }
}

-(BOOL) praiseCommentByContentId:(NSString*) contentId
{
    NSString* script = [NSString stringWithFormat:@"vv('%@')", contentId];
    
    return [self execJavaScript:script] != nil;
}

-(int) praiseComment
{
    NSArray* ids = [self contentIds];
    if(!ids)
        return 0;
    
    int praiseCount = 0;
    for(int i=0; i<ids.count; i++) {
        id cid = [ids objectAtIndex:i];
        if ([self praiseCommentByContentId:cid]) {
            praiseCount++;
        }
        [NSThread sleepForTimeInterval:0.1f];
    }
    
    return praiseCount;
}

-(int) praiseMediaOnly
{
    if ([self isPageDidLoad]) {
        int c = [self mediaLikeNum];
        return [self praiseMedia] + c;
    }
    return 0;
}

-(int) praiseCommentOnly
{
    int r = 0;
    if ([self isPageDidLoad]) {
        [self injectMedia];
        int c=10;
        while (c>0) {
            if ([self isMediaDidInject]) {
                r = [self praiseComment];
                break;
            }
            [self injectMedia];
            [NSThread sleepForTimeInterval:0.2f];
            c--;
        }
    }
    [self commentDidPraise:r];
    return r;
}

-(void) tryPraiseCommentOnly
{
    [self showIndicator];
    [self performSelector:@selector(praiseCommentOnly) withObject:nil afterDelay:2];
}

-(void) tryPraise
{
    //[self praiseMediaOnly];
    [self tryPraiseCommentOnly];
}

-(void) showIndicator
{
    id mainWindow = [_AppViewControllerMgr getMainWindow];
    if (!mainWindow) {
        return;
    }
    
    [_activityIndicatorView startAnimating];
    
    [mainWindow addSubview:_activityIndicatorView];
    _activityIndicatorView.center = [mainWindow center];
}

-(void) hideIndicator
{
    [_activityIndicatorView removeFromSuperview];
    [_activityIndicatorView stopAnimating];
}


-(BOOL) startLoop
{
    NSTimer *timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    return timer != nil;
}

-(void) timerAction:(NSTimer*) timer
{
    [self task];
}

-(NSDictionary*) mediaTask {
    @try {
        NSError *error;
        NSString* path = [NSString stringWithFormat:@"http://101.201.102.98:8090/qqAccount/api/getTask.do?token=%@", [self udid]];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:path] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60];
        
        NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSDictionary *taskDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:&error];
        NSLog(@"%@", taskDic);
        
        return taskDic;
    }
    @catch(...){
    }
    
    return nil;
}

-(BOOL) isWebViewPresent
{
    id webView = [self getTopWebview];
    if (!webView) {
        return NO;
    }
    
    return [[webView superview] superview] != nil;
}

-(BOOL) tryPresentWebView
{
    id webView = [self getTopWebview];
    if (!webView) {
        [self createTopWebview];
        webView = [self getTopWebview];
    }
    
    UIView* view = nil;
    if (webView && ![(view=[webView superview]) superview]) {
        id mainWindow = [_AppViewControllerMgr getMainWindow];
        [mainWindow addSubview:view];
    }
    
    return webView!=nil;
}

-(void) switchAccount
{
    if (!_moreViewController) {
        [self tryLogout];
        return;
    }
    
    if (_moreViewController) {
        [_moreViewController showSettingView];
    }
    
    //NSLog(@"%@", self);
}

-(void) switchAccountDidSuccess
{
    _execTask.theTask = nil;
    _execTask.taskList = nil;
    _execTask.taskType = TTNone;
    _execTask.execStatus = ESReady;
    
    if (_currWebViewController) {
        [_currWebViewController release];
    }
    
    _currWebViewController = nil;
}

-(BOOL) validateTask:(NSDictionary*) task
{
    NSNumber* taskId;
    NSDictionary* tasks;
    return task && (taskId = [task valueForKey:@"taskId"]) && [taskId intValue]>0 && (tasks=[task valueForKey:@"result"]) && tasks.count>0;
}

-(void) trySwitchAccount
{
    _execTask.execStatus = ESSwitch;
    [self tryLogout];
}

-(void) task
{
    if (_execTask && _execTask.execStatus == ESSwitching) {
        if ([self isLogin]) {
            [self switchAccountDidSuccess];
        }
        return;
    }
    
    if (_execTask && _execTask.execStatus == ESSwitch) {
        if ([self isLogin]) {
            [self switchAccount];
        }
        return;
    }
    
    if (_execTask && _execTask.taskType == TTDidExec) {
        [self taskDidExecute];
        
        return;
    }
    
    if (!_currentTask) {
        NSLog(@"-------开始采集任务列表-------\n");
        NSDictionary *taskDic = [self mediaTask];
        if (![self validateTask:taskDic]) {
            return;
        }
        // 缓存任务
        _currentTask = [taskDic retain];
        _execTask.taskType = TTRead;
        //NSLog(@"%@", _currentTask);
    }
    
    if (![self isWebViewPresent]) {
        if (![self tryPresentWebView]) {
            // 如果图文容器没有准备好，则退出
            return;
        }
    }
    
    [self executetask];
}

-(NSDictionary*) taskDidFinish:(NSNumber*) taskId
{
    NSError *error;
    NSString* path = @"http://101.201.102.98:8090/qqAccount/api/submitTask.do?token=%@&taskId=%@";
    
    path = [NSString stringWithFormat:path, [self udid], taskId];
    
    NSLog(@"-------更新任务状态-------\n");
    NSLog(@"%@", path);
    NSLog(@"-------更新任务状态-------\n");
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:path] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *taskDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:&error];
    
    return taskDic;
}

-(void) taskDidExecute{
    // 当前微信账号执行完毕
    //NSLog(@"-------当前任务执行完毕-------");
    //NSLog(@"-------提交任务执行完成-taskId=%@", [_currentTask objectForKey:@"taskId"]);
    
    // 尝试删除当前执行用户
    [_accountInfo reduceAccount: [self getLastLoginName]];
    
    if ([_accountInfo isLoopOver]) {
        [_accountInfo resetExecAccount];
        id taskId = [_currentTask valueForKey:@"taskId"];
        [self taskDidFinish:taskId];
        if (_currentTask) {
            [_currentTask release];
            _currentTask = nil;
        }
        
        [self resetExecTask];
        return;
    }
    
    // 尝试切换账号执行
    if (_accountInfo && [_accountInfo isMultiAccount]) {
        [self trySwitchAccount];
    } else {
        if (_currentTask) {
            [_currentTask release];
            _currentTask = nil;
        }
        
        [self resetExecTask];
    }
}

- (void)resetExecTask
{
    if (!_execTask) {
        _execTask = [ExecTask new];
    }
    _execTask.theTask = nil;
    _execTask.taskList = nil;
    _execTask.taskType = TTRead;
    _execTask.execStatus = ESReady;
}

-(void) executetask
{
    // 执行任务
    //NSLog(@"-------开始执行任务列表-------\n");
    if (!_execTask) {
        [self resetExecTask];
    } else if (_execTask.taskType == TTNone && _currentTask) {
        [_currentTask release];
        _currentTask = nil;
        _execTask.taskType = TTRead;
        return;
    }
    
    //NSLog(@"%@", _currentTask);
    if (!_currentTask) {
        return;
    }
    
    //NSLog(@"%@", _execTask);
    
    if (_execTask.taskType == TTRead) {
        [self doReadTask];
    } else if(_execTask.taskType == TTPraise) {
        [self doPraiseTask];
    } else if(_execTask.taskType == TTComment) {
        [self doCommentTask];
    } else if(_execTask.taskType == TTPAndC) {
        [self doPAndCTask];
    }
}

-(void) doPAndCTask {
    //NSLog(@"-------执行图文评论点赞任务列表-------\n");
    //NSLog(@"%@", _execTask);
    
    if (!_execTask || _execTask.taskType != TTPAndC) {
        return;
    }
    
    if (_execTask.execStatus == ESLoad) {
        _execTask.execStatus = ESPraise;
        
        [self tryPraise];
        return;
    } else if (_execTask.execStatus == ESComment) {
        NSMutableDictionary* dic = (NSMutableDictionary*)_execTask.theTask;
        [dic setValue:[NSNumber numberWithInt:1] forKey:@"status"];
        _webviewStatus = WVReady;
    } else if (_execTask.execStatus > ESReady) {
        return;
    }
    
    //NSLog(@"%@", _execTask);
    
    NSDictionary* taskList = _execTask.taskList;
    if (!taskList) {
        taskList = [[_currentTask objectForKey:@"result"]  valueForKey:@"pandcs"];
        _execTask.taskList = taskList;
    }
    
    if (!_execTask.taskList || _execTask.taskList.count == 0) {
        _execTask.taskList = nil;
        _execTask.theTask = nil;
        _execTask.taskType = TTDidExec;
        _execTask.execStatus = ESReady;
        
        _webviewStatus = WVReady;
        [self taskDidExecute];
        return;
    }
    
    NSEnumerator *enumerator = [taskList keyEnumerator];
    bool hasReadTask = false;
    for (id key in enumerator) {
        id theTask = [taskList objectForKey:key];
        if (!theTask) {
            continue;
        }
        // 当且仅当webview准备好的时候才能打开连接
        if(_webviewStatus == WVReady) {
            int status = [theTask objectForKey:@"status"]?[[theTask objectForKey:@"status"] intValue]:0;
            if (status>0) {
                continue;
            }
            
            NSString* url = [theTask objectForKey:@"url"];
            if (!url) {
                continue;
            }
            
            _execTask.theTask = theTask;
            _execTask.execStatus = ESStart;
            
            _webviewStatus = WVLoading;
            hasReadTask = true;
            
            [self openUrl:url];
            //NSLog(@"%@", url);
        }
    }
    if (!hasReadTask) {
        _execTask.taskList = nil;
        _execTask.theTask = nil;
        _execTask.taskType = TTDidExec;
        _execTask.execStatus = ESReady;
        
        [self taskDidExecute];
    }
    
}

-(void) doCommentTask {
    //NSLog(@"-------执行评论点赞任务列表-------\n");
    //NSLog(@"%@", _execTask);
    
    if (!_execTask || _execTask.taskType != TTComment) {
        return;
    }
    
    if (_execTask.execStatus == ESLoad) {
        _execTask.execStatus = ESPraise;
        [self tryPraiseCommentOnly];
        return;
    } else if (_execTask.execStatus == ESComment) {
        NSMutableDictionary* dic = (NSMutableDictionary*)_execTask.theTask;
        [dic setValue:[NSNumber numberWithInt:1] forKey:@"status"];
        _webviewStatus = WVReady;
    } else if (_execTask.execStatus > ESReady) {
        return;
    }
    
    NSDictionary* taskList = _execTask.taskList;
    if (!taskList) {
        taskList = [[_currentTask objectForKey:@"result"]  valueForKey:@"comments"];
        _execTask.taskList = taskList;
    }
    
    if (!_execTask.taskList || _execTask.taskList.count == 0) {
        _execTask.taskList = nil;
        _execTask.theTask = nil;
        _execTask.taskType = TTPAndC;
        _execTask.execStatus = ESReady;
        
        _webviewStatus = WVReady;
        return;
    }
    
    NSEnumerator *enumerator = [taskList keyEnumerator];
    bool hasReadTask = false;
    for (id key in enumerator) {
        id theTask = [taskList objectForKey:key];
        if (!theTask) {
            continue;
        }
        // 当且仅当webview准备好的时候才能打开连接
        if(_webviewStatus == WVReady) {
            int status = [theTask objectForKey:@"status"]?[[theTask objectForKey:@"status"] intValue]:0;
            if (status>0) {
                continue;
            }
            
            NSString* url = [theTask objectForKey:@"url"];
            if (!url) {
                continue;
            }
            
            _execTask.theTask = theTask;
            _execTask.execStatus = ESStart;
            
            _webviewStatus = WVLoading;
            [self openUrl:url];
            hasReadTask = true;
        }
    }
    if (!hasReadTask) {
        _execTask.taskList = nil;
        _execTask.theTask = nil;
        _execTask.taskType = TTPAndC;
        _execTask.execStatus = ESReady;
    }
}

-(void) doPraiseTask {
    //NSLog(@"-------执行阅读点赞任务列表-------\n");
    //NSLog(@"%@", _execTask);
    
    if (!_execTask || _execTask.taskType != TTPraise) {
        return;
    }
    
    if (_execTask.execStatus == ESLoad) {
        if ([self praiseMediaOnly]) {
            NSMutableDictionary* dic = (NSMutableDictionary*)_execTask.theTask;
            [dic setValue:[NSNumber numberWithInt:1] forKey:@"status"];
            _webviewStatus = WVReady;
        }
    } else if (_execTask.execStatus > ESReady) {
        return;
    }
    
    NSDictionary* taskList = _execTask.taskList;
    if (!taskList) {
        taskList = [[_currentTask objectForKey:@"result"] valueForKey:@"praises"];
        _execTask.taskList = taskList;
    }
    
    if (!_execTask.taskList || _execTask.taskList.count == 0) {
        _execTask.taskList = nil;
        _execTask.theTask = nil;
        _execTask.taskType = TTComment;
        _execTask.execStatus = ESReady;
        
        _webviewStatus = WVReady;
        return;
    }
    
    NSEnumerator *enumerator = [taskList keyEnumerator];
    bool hasReadTask = false;
    for (id key in enumerator) {
        id theTask = [taskList objectForKey:key];
        if (!theTask) {
            continue;
        }
        // 当且仅当webview准备好的时候才能打开连接
        if(_webviewStatus == WVReady) {
            int status = [theTask objectForKey:@"status"]?[[theTask objectForKey:@"status"] intValue]:0;
            if (status>0) {
                continue;
            }
            
            NSString* url = [theTask objectForKey:@"url"];
            if (!url) {
                continue;
            }
            
            _execTask.theTask = theTask;
            _execTask.execStatus = ESStart;
            
            _webviewStatus = WVLoading;
            [self openUrl:url];
            hasReadTask = true;
        }
    }
    if (!hasReadTask) {
        _execTask.taskList = nil;
        _execTask.theTask = nil;
        _execTask.taskType = TTComment;
        _execTask.execStatus = ESReady;
    }
}

-(void) doReadTask {
    //NSLog(@"-------执行阅读任务列表-------\n");
    //NSLog(@"%@", _execTask);
    
    if (!_execTask || _execTask.taskType != TTRead) {
        return;
    }
    
    if (_execTask.execStatus == ESLoad) {
        NSMutableDictionary* dic = (NSMutableDictionary*)_execTask.theTask;
        [dic setValue:[NSNumber numberWithInt:1] forKey:@"status"];
        
        _webviewStatus = WVReady;
    } else if (_execTask.execStatus > ESReady) {
        return;
    }
    
    NSDictionary* taskList = _execTask.taskList;
    if (!taskList) {
        taskList = [[_currentTask objectForKey:@"result"] valueForKey:@"reads"];
        _execTask.taskList = taskList;
    }
    
    if (!_execTask.taskList || _execTask.taskList.count == 0) {
        _execTask.taskList = nil;
        _execTask.theTask = nil;
        _execTask.taskType = TTPraise;
        _execTask.execStatus = ESReady;
        
        _webviewStatus = WVReady;
        return;
    }
    NSEnumerator *enumerator = [taskList keyEnumerator];
    bool hasReadTask = false;
    for (id key in enumerator) {
        id theTask = [taskList objectForKey:key];
        if (!theTask) {
            continue;
        }
        // 当且仅当webview准备好的时候才能打开连接
        if(_webviewStatus == WVReady) {
            int status = [theTask objectForKey:@"status"]?[[theTask objectForKey:@"status"] intValue]:0;
            if (status>0) {
                continue;
            }
            
            NSString* url = [theTask objectForKey:@"url"];
            if (!url) {
                continue;
            }
            
            _execTask.theTask = theTask;
            _execTask.execStatus = ESStart;
            
            _webviewStatus = WVLoading;
            [self openUrl:url];
            hasReadTask = true;
            
            NSLog(@"---------当前登录用户池[%@]----------", _accountInfo.execAccs);
            NSLog(@"---------当前登录用户[%@]----------", [self getLastLoginName]);
        }
    }
    if (!hasReadTask) {
        _execTask.taskList = nil;
        _execTask.theTask = nil;
        _execTask.taskType = TTPraise;
        _execTask.execStatus = ESReady;
    }
}

-(BOOL) isLogin
{
    
    Method theMethod = class_getClassMethod(objc_getClass("CAppUtil"), @selector(isLogin));
    IMP methodImp = method_getImplementation(theMethod);
    
    bool r = methodImp(objc_getClass("CAppUtil"), @selector(isLogin));
    
    return r?YES:NO;
}

-(id) getLastLoginName
{
    
    Method theMethod = class_getClassMethod(objc_getClass("CAppUtil"), @selector(getLastLoginName));
    IMP methodImp = method_getImplementation(theMethod);
    
    return methodImp(objc_getClass("CAppUtil"), @selector(getLastLoginName));
}
-(id) getLastUserName
{
    Method theMethod = class_getClassMethod(objc_getClass("CAppUtil"), @selector(getLastUserName));
    IMP methodImp = method_getImplementation(theMethod);
    
    return methodImp(objc_getClass("CAppUtil"), @selector(getLastUserName));
}


-(void) webViewDidLoad
{
    // 检测当前执行的任务
    if (!_execTask || _execTask.taskType == TTNone || !_execTask.taskList) {
        // 当前任务为空，或者任务列表为空，或者当且任务类型未知
        return;
    }
    if ((_execTask.taskType == TTRead || _execTask.taskType == TTPraise || _execTask.taskType == TTComment || _execTask.taskType == TTPAndC) && _execTask.theTask) {
        _execTask.execStatus = ESLoad;
    }
    
}

-(void) commentDidPraise:(int) count {
    // 结束loading动画
    [self hideIndicator];
    
    // 检测当前执行的任务
    if (!_execTask || _execTask.taskType == TTNone || !_execTask.taskList) {
        // 空任务、空任务列表、未知任务类型则退出
        return;
    }
    
    if ((_execTask.taskType == TTComment || _execTask.taskType == TTPAndC) && _execTask.theTask) {
        _execTask.execStatus = ESComment;
    }
    
}

-(void) doSettingAction:(NewSettingViewController*) newSettingViewController
{
    if (_execTask && _execTask.execStatus == ESSwitch) {
        [newSettingViewController tryQuit];
    }
}

-(void) tryDoLogin:(WCAccountLoginControlLogic*) accountLoginControlLogic
{
    _execTask.execStatus = ESSwitching;
    NSString* userName = [_accountInfo.execAccs anyObject];
    NSString* pwd = [_accountInfo.accInfo valueForKey:userName];
    NSLog(@"username = %@ pwd = %@ - %@",userName,pwd,accountLoginControlLogic);
    [accountLoginControlLogic onLastUserLoginUserName:userName Pwd:pwd];

//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [accountLoginControlLogic onLastUserLoginUserName:userName Pwd:pwd];
//    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeAlert:accountLoginControlLogic userName:userName pwd:pwd];
//        if ([self removeAlert:accountLoginControlLogic]) {
//            NSLog(@"\n\n\n\n\n登陆出问题了\n\n\n\n");
//            [self saveInvalidAccountInfoWithUserName:userName andPwd:pwd];
//            [self removeAccountInfoWithUserName:userName];
//            [self resetAccountInfoWithUserName:userName];
//            [self tryDoLogin:accountLoginControlLogic];
//        }
    });
}

- (void)resetAccountInfoWithUserName:(NSString *)userName
{
    NSString * path = [self documentDirectory];
    NSString *filename=[path stringByAppendingPathComponent:@"xWechatAccinfo.plist"];
    NSDictionary* dict = [NSDictionary dictionaryWithContentsOfFile:filename];
    _accountInfo.accInfo = dict;
    [_accountInfo.execAccs removeObject:userName];
    if (_accountInfo.execAccs.count == 0) {
//        [_accountInfo.execAccs addObjectsFromArray:[dict allKeys]];
        [_accountInfo.execAccs addObject:[dict allKeys][0]];
    }
}

- (void)removeAccountInfoWithUserName:(NSString *)userName
{
    NSString * path = [self documentDirectory];
    NSString *filename=[path stringByAppendingPathComponent:@"xWechatAccinfo.plist"];
    NSDictionary* dic = [NSDictionary dictionaryWithContentsOfFile:filename];
    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dict removeObjectForKey:userName];
    [dict writeToFile:filename atomically:YES];
}

- (void)saveInvalidAccountInfoWithUserName:(NSString *)userName andPwd:(NSString *)pwd
{
    NSString * filename = [self createPlist];
    NSDictionary* dic = [NSDictionary dictionaryWithContentsOfFile:filename];
    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dict setValue:pwd forKey:userName];
    [dict writeToFile:filename atomically:YES];
}

- (NSString *)createPlist
{
    NSString * path = [self documentDirectory];
    NSString * filename = [path stringByAppendingPathComponent:@"InvalidAccount.plist"];
    NSFileManager * fm = [NSFileManager defaultManager];
    NSDictionary * dic = [NSDictionary dictionaryWithContentsOfFile:filename];
    if(!dic) {
        [fm createFileAtPath:filename contents:nil attributes:nil];
    }
    return filename;
}

- (void)removeAlert:(WCAccountLoginControlLogic *)accountLoginControlLogic userName:(NSString *)userName pwd:(NSString *)pwd
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    NSLog(@"window___window___window\n\n\n\n\n%@\n%@\n\n\n\n\n window___window___window",window.subviews,window);
    if (window.subviews.count >= 2) {
        // ios7
        if ([self.udid isEqualToString:@"0A1535A7-A61B-4FC1-BA9A-F77ECDD21FF0"] ||
            [self.udid isEqualToString:@"2BCFC986-431A-4B2A-9120-E690CD74F9EF"]) {
//            for (UIView * view in [window.subviews lastObject].subviews) {
//                [view removeFromSuperview];
//            }
//            if ([[window.subviews lastObject].subviews lastObject] &&
//                ![[[window.subviews lastObject].subviews lastObject] isEqual:[UIView class]]) {
//                NSLog(@"win lastobject\n\n\n\n%@",[[window.subviews lastObject].subviews lastObject]);
//                [[[window.subviews lastObject].subviews lastObject] removeFromSuperview];
//            } else {
//                NSLog(@"啥也没有");
//                return;
//            }
//            [window.subviews[window.subviews.count - 1] removeFromSuperview];
//            [window.subviews[0] removeFromSuperview];
//            [[window.subviews lastObject] removeFromSuperview];
//            [window removeFromSuperview];
//            [window.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            window.hidden = YES;
            window = nil;
        } else {
            [accountLoginControlLogic dismissCurrentViewWithAnimated:NO];
        }
        NSLog(@"\n\n\n\n\n登陆出问题了\n\n\n\n");
        [self saveInvalidAccountInfoWithUserName:userName andPwd:pwd];
        [self removeAccountInfoWithUserName:userName];
        [self resetAccountInfoWithUserName:userName];
        [NSThread sleepForTimeInterval:2.f];
        [self tryDoLogin:accountLoginControlLogic];

    } else {
        NSLog(@"\n\n\n\n\n登陆成功了\n\n\n\n登陆成功了");
    }
}

-(void) doLoginAction:(WCAccountLoginControlLogic*) accountLoginControlLogic
{
    if (_execTask && _execTask.execStatus == ESSwitch) {
        [self performSelector:@selector(tryDoLogin:) withObject:accountLoginControlLogic afterDelay:2.5];
    }
}

@end
