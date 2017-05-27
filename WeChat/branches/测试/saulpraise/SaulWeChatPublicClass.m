
#import "SaulWeChatPublicClass.h"

@implementation SaulWeChatPublicClass

+ (instancetype)sharedInstance {
    
    static dispatch_once_t once;
    static SaulWeChatPublicClass *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[SaulWeChatPublicClass alloc] init];
    });
    
    return sharedInstance;
}


- (NSString *)documentDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    return [paths objectAtIndex:0];
}


- (BOOL)injectJQueryForWebView:(UIWebView *)webview {
    
    NSString *jsFile=[[self documentDirectory] stringByAppendingPathComponent:@"jquery.min.js"];
    NSString* jscript = [NSString stringWithContentsOfFile:jsFile encoding:NSUTF8StringEncoding error:nil];
    
    return [self execJavaScript:jscript forWebView:webview] != nil;
}

- (NSString *)execJavaScript:(NSString *)js forWebView:(UIWebView *)webView {
    return [webView stringByEvaluatingJavaScriptFromString:js];
}

- (void)holdWebView:(id)webView {
    if (_webView) {
        [_webView release];
        _webView = nil;
    }
    _webView = webView;
}



@end
