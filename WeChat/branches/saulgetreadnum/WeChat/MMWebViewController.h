//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//
#import <UIKit/UIKit.h>

@interface MMWebViewController : UIViewController

@property(retain, nonatomic) UIWebView *webView;

- (void)goBack;
- (void)goForward;
- (void)reload;
- (bool)isPageDidLoad;

- (void)viewDidLoad;

- (void)webView:(id)webView didFailLoadWithError:(id)error;
- (void)webViewDidFinishLoad:(id)webView;
- (void)webViewDidStartLoad:(id)webView;



- (void)internalInitWithUrl:(id)arg1 presentModal:(_Bool)arg2 extraInfo:(id)arg3;


- (void)goToURL:(id)arg1;
- (void)delayHandleUrl:(id)arg1;
- (void)done:(id)arg1;
- (id)extraInfo;
- (id)getCurrentUrl;
- (id)getOperationButtonImageNameWithURL:(id)arg1;
- (id)getRequestingOrCurrentUrl;
- (id)getShareUrl;
- (id)getUrlPermission:(id)arg1;
- (void)goToURL:(id)arg1;
- (void)handleJumpProfileUrl:(id)arg1 profileRange:(struct _NSRange)arg2;
- (id)initWithURL:(id)arg1 presentModal:(_Bool)arg2 extraInfo:(id)arg3;
- (void)onGetA8Key:(_Bool)arg1 Reason:(int)arg2;
- (void)onJumpToEmoticonDetailViewController:(id)arg1;
- (void)onJumpToSafariWithUrl:(id)arg1;
- (void)onJumpToViewController:(id)arg1;
- (void)onLongPressOnWebview:(id)arg1;
- (void)setCurrentUrl:(id)arg1;
- (void)url:(id)arg1 DidCheckReturnContentAttribute:(unsigned int)arg2;

- (void)stop;



@end
