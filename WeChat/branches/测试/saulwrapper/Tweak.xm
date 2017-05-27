#import "WeChat/NewMainFrameViewController.h"
#import "WeChat/MMWebViewController.h"

%hook NewMainFrameViewController

- (void)PushViewController:(id)arg1 {
%orig;
    NSLog(@"\n PushViewController \n%@\n PushViewController",arg1);
}

- (void)OpenContactInfo:(id)arg1 {
%orig;
    NSLog(@"\n OpenContactInfo \n%@\n OpenContactInfo",arg1);

}

- (void)OnRoomMemberChange:(id)arg1 withNewMemberList:(id)arg2
{
%orig;
NSLog(@"\n OnRoomMemberChange \n%@\n%@\n OnRoomMemberChange",arg1,arg2);

}

- (void)handleSelectIndexPath:(id)arg1 tableView:(id)arg2
{
%orig;
NSLog(@"\n handleSelectIndexPath \n%@\n%@\n handleSelectIndexPath",arg1,arg2);

}

- (void)handleSightPanGesture:(id)arg1
{
%orig;
    NSLog(@"\n handleSightPanGesture \n%@\n handleSightPanGesture",arg1);

}

%end

%hook MMWebViewController

- (void)webViewDidFinishLoad:(id)webView
{
%orig;
NSLog(@"\n webViewDidFinishLoad \n%@\n webViewDidFinishLoad",webView);

}
- (void)webViewDidStartLoad:(id)webView
{
%orig;
NSLog(@"\n webViewDidStartLoad \n%@\n webViewDidStartLoad",webView);

}

%end
