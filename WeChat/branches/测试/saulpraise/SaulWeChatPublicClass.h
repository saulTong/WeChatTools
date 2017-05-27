

@interface SaulWeChatPublicClass : NSObject {
    UIWebView * _webView;
}

+ (instancetype)sharedInstance;

- (void)holdWebView:(id)webView;

- (BOOL)injectJQueryForWebView:(UIWebView *)webview;


@end


