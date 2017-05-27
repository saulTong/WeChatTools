
#import "WeChat/WCRedEnvelopesReceiveHomeView.h"
#import "WeChat/WCPayC2CMessageCellView.h"
#import "WeChat/BaseMsgContentViewController.h"
#import "WeChat/WCRedEnvelopesRedEnvelopesDetailViewController.h"



%hook BaseMsgContentViewController

- (void)MessageReturn:(unsigned int)arg1 MessageInfo:(NSDictionary *)arg2 Event:(unsigned int)arg3 {

%orig;
static BOOL isFirst = NO;

    if (isFirst) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UITableView *tableView = [self valueForKey:@"m_tableView"];
            if (!tableView) {
                Ivar mDelegateVar = class_getInstanceVariable(objc_getClass("BaseMsgContentViewController"), "m_tableView");
                tableView = object_getIvar(self, mDelegateVar);
            }

//            NSLog(@"\n\n\n\n tableview \n\n\n %@ \n\n\n tableview",tableView);
            NSArray *cells = [tableView visibleCells];
            UITableViewCell *cell = [cells lastObject];
//            NSLog(@"\n\n\n cell total \n %@ \n\n last Cell \n %@", cells, [cells lastObject]);
            for (UIView *view in cell.contentView.subviews) {
                if ([view isKindOfClass:%c(WCPayC2CMessageCellView)]) {
                    WCPayC2CMessageCellView *v = (WCPayC2CMessageCellView *)view;
                    [v onTouchUpInside];
                    isFirst = NO;
                    break;
                }
            }
        });
    }
    isFirst = !isFirst;
}

%end

%hook WCRedEnvelopesReceiveHomeView

- (void)showAnimation {
    %orig;
    [self OnOpenRedEnvelopes];
}
%end

%hook WCRedEnvelopesRedEnvelopesDetailViewController

- (void)setLeftCloseBarButton{
%orig;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self OnLeftBarButtonDone];
    });
}



%end
