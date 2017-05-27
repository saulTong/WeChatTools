#import "SaulWeChatPublicClass.h"
#import <objc/runtime.h>

@implementation SaulWeChatPublicClass

+ (instancetype)sharedInstance {
    static dispatch_once_t once;
    static SaulWeChatPublicClass *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[SaulWeChatPublicClass alloc] init];
    });
    return sharedInstance;
}



- (void)startLoop {
    if (!_taskArray) {
        _taskArray = [[NSMutableArray alloc] init];
        NSLog(@"创建 任务数组");
    }
    if (!_readNumArray) {
        _readNumArray = [[NSMutableArray alloc] init];
        NSLog(@"创建 访问数组");
    }

    NSTimer *timer = [NSTimer timerWithTimeInterval:300 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void) timerAction:(NSTimer*) timer {
    
    if (_taskArray.count > 0) {
        return;
    }
    if([[self mediaTask] count] == 0)  {
        return;
   
    }
    NSDictionary * dic = [self mediaTask];
    _taskArray = [[NSMutableArray arrayWithArray:[dic objectForKey:@"data"]] mutableCopy];
    if (_taskArray.count > 0) {
        if (_currWebViewController)
            [self openURL];
        else
            [self openEnterpriseBrandSessionView];
    }
    
}

- (void)holdNewMainFrameViewController:(NewMainFrameViewController *)viewController {
    
    if (_newMainViewController) {
        _newMainViewController = nil;
    }
    
    _newMainViewController = viewController;
}


- (NSDictionary*)mediaTask {
    
    NSError *error;
    NSString* path = [NSString stringWithFormat:@"http://webook.aihave.cn/webook/app_api/article/all"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:path] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60];
    
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *taskDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:&error];
    
    return taskDic;
}

- (void)openEnterpriseBrandSessionView {
    
    if (_newMainViewController) {
        [_newMainViewController openEnterpriseBrandSessionView:nil];
    }
    
}

- (void)openWebViewController:(EnterpriseBrandSessionListViewController *)viewController {
    
    [viewController openCreateChat];
}

- (void)beginDoTaskWith:(MMWebViewController *)viewController {
    
    if (_currWebViewController) {
        _currWebViewController = nil;
    }
    _currWebViewController = viewController;
    [self openURL];
}

- (void)openURL {
    
    if (_taskArray.count) {
        if (_currWebViewController.webView) {
            Ivar mDelegateVar = class_getInstanceVariable(objc_getClass("MMWebViewController"), "m_addressBarView");
            UIImageView * mDelegate = object_getIvar(_currWebViewController, mDelegateVar);
            
            [mDelegate removeFromSuperview];
            mDelegate = nil;
            [_currWebViewController.webView removeFromSuperview];
            _currWebViewController.webView = nil;
            
        }
        NSDictionary * dic = _taskArray[0];
        NSURL* urls = [[NSURL alloc] initWithString:[dic objectForKey:@"sourceUrl"]];
        [_currWebViewController internalInitWithUrl:urls presentModal:0 extraInfo:nil];
    } else {
        
        [self POSTAsynRequest];
        
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webview {
    
    if (webview.isLoading) {
        return;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSString *currentURL = [webview stringByEvaluatingJavaScriptFromString:@"document.documentElement.innerHTML"];
        NSString * readCount = @"nil";
        
        // 阅读总数
        NSString * count = @"<span id=\"readNum3\">";
        if ([currentURL rangeOfString:count].location != NSNotFound) {
            NSArray *array = [currentURL componentsSeparatedByString:count];
            NSArray * lastCount = [array[1] componentsSeparatedByString:@"</span></div>"];
            readCount = lastCount[0];
        }
        NSLog(@"\n\n\n\n\n %@ \n\n\n\n\nreadCount",readCount);
        NSDictionary * dic = @{@"id" : _taskArray[0][@"id"] ,
                               @"wxReadCount" : readCount} ;
        [_readNumArray addObject: [dic mutableCopy]];
        [_taskArray removeObjectAtIndex:0];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self openURL];
        });

    });

}


- (void)POSTAsynRequest {

    NSString *baseUrlString = @"http://webook.aihave.cn/webook/app_api/article/update";
    NSURL *url = [NSURL URLWithString:baseUrlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    NSData *dataFriends = [NSJSONSerialization dataWithJSONObject:_readNumArray options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString *bodyString = [[NSString alloc] initWithData:dataFriends encoding:NSUTF8StringEncoding];
    
    NSData *bodyData = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:bodyData];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
            NSLog(@"request is \n %@ \n request", dict);
        
//        [_currWebViewController.navigationController popToRootViewControllerAnimated:YES];
        
        if (_readNumArray.count > 0) {
            [_readNumArray removeAllObjects];
        }
    }];
    
    
}

@end













