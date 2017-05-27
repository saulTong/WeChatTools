#import "WeChat/WCOperateFloatView.h"
#import "WeChat/WCLikeButton.h"
#import "WeChat/WCDataItem.h"
#import "WeChat/WCTimeLineViewController.h"
#import "WeChat/WCTimeLineCellShowItem.h"
#import "WeChat/MMTabBarController.h"
#import "SaulWeChatPublicClass.h"


%hook MMTabBarController

- (void)viewDidLoad
{
%orig;
    UISwitch *switch1 = [[UISwitch alloc]init];
    switch1.frame = CGRectMake(100, 20, 0, 0);
    [switch1 setOn:NO];
    [switch1 addTarget:self action:@selector(switchIsChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:switch1];
//    [[[UIApplication sharedApplication].delegate window] addSubview:switch1];

}

%new
-(void)switchIsChanged:(UISwitch *)swith
{
SaulWeChatPublicClass *addFriend = [SaulWeChatPublicClass sharedInstance];

    if ([swith isOn]){
        addFriend.isThumbOn = YES;
    } else {
        addFriend.isThumbOn = NO;
    }
}

%end



%hook WCTimeLineViewController
- (void)viewDidLoad
{
%orig;

    SaulWeChatPublicClass * userData = [SaulWeChatPublicClass sharedInstance];
    if (!userData.isThumbOn) {
        return ;
    }
/*
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

while (userData.dataItem.count){
NSMutableSet *sets = [NSMutableSet setWithCapacity:200];
[sets addObjectsFromArray:[userData.dataItem allKeys]];
NSString * key = [sets anyObject];
if ([userData.dataItem valueForKey:key]) {
[self onCommentDataItem:[userData.dataItem valueForKey:key] point:CGPointMake(300,300)];
}
[NSThread sleepForTimeInterval:2.f];
[self onLoadMore];
}
    });

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        SaulWeChatPublicClass * userData = [SaulWeChatPublicClass sharedInstance];
        for (int i = 0; i < userData.dataItem.count; i++) {
            NSMutableSet *sets = [NSMutableSet setWithCapacity:20];
            [sets addObjectsFromArray:[userData.dataItem allKeys]];
            NSString * key = [sets anyObject];
NSLog(@"key\n%@\nkey/nitem/n%@/nitem",key,[userData.dataItem valueForKey:key]);
            [NSThread sleepForTimeInterval:2.f];
            [self onCommentDataItem:[userData.dataItem valueForKey:key] point:CGPointMake(100,100)];
        }


    });
*/
}

- (void)onCommentDataItem:(id)arg1 point:(struct CGPoint)arg2 {
%orig;
        NSLog(@"\nonCommentDataItemWithPoint - 执行动画\n");
}


%end

%hook WCTimeLineCellShowItem

- (id)initWithDataItem:(id)arg1 {
id orig = %orig;

    SaulWeChatPublicClass * userData = [SaulWeChatPublicClass sharedInstance];
    if (!userData.isThumbOn) {
        return orig;
    }


    Ivar mDelegateVar = class_getInstanceVariable(objc_getClass("WCTimeLineCellShowItem"), "m_dataItemID");
    id mDelegate = object_getIvar(self, mDelegateVar);

    [userData addDataItemWihtKey:mDelegate andValue:arg1];

    return orig;
}

%end

%hook WCOperateFloatView

- (void)onLikeItem:(id)arg1 {
%orig;
    SaulWeChatPublicClass * userData = [SaulWeChatPublicClass sharedInstance];
    if (!userData.isThumbOn) {
        return ;
    }

    WCLikeButton * button = arg1;
    if ([button.titleLabel.text isEqualToString:@"赞"] ||
    [button.titleLabel.text isEqualToString:@"Like"]) {
        [button onLikeFriend];
    }
    Ivar mDelegateVar = class_getInstanceVariable(objc_getClass("WCOperateFloatView"), "m_item");
    id mDelegate = object_getIvar(self, mDelegateVar);
    WCDataItem * item = mDelegate;
    [userData removeDataIeamWihtKey:item.tid];
}

- (void)showWithItemData:(id)arg1 tipPoint:(struct CGPoint)arg2 {
%orig;

    SaulWeChatPublicClass * userData = [SaulWeChatPublicClass sharedInstance];
    if (!userData.isThumbOn) {
        return ;
    }

    Ivar mDelegateVar = class_getInstanceVariable(objc_getClass("WCOperateFloatView"), "m_likeBtn");
    id mDelegate = object_getIvar(self, mDelegateVar);
    [self onLikeItem:mDelegate];
}

%end

/*
需要 tableview
获取多少条数据
- (long long)numberOfSectionsInTableView:(id)arg1;
追加数据
- (void)onLoadMore;
||
- (void)MMRefreshTableFooterDidTriggerRefresh:(id)arg1;


Ivar mDelegateVar = class_getInstanceVariable(objc_getClass("WCTimeLineViewController"), "m_tableView");
id mTableView = object_getIvar(self, mDelegateVar);

long long tmpNum = 0;
long long fNum = 100;
while (1) {
if (tmpNum == fNum) return;
tmpNum = fNum;
[self MMRefreshTableFooterDidTriggerRefresh:mTableView];
[NSThread sleepForTimeInterval:2.f];
fNum = [self numberOfSectionsInTableView:mTableView];
NSLog(@"\nafter   fNum - %llu --- tmpNum - %llu\n",fNum,tmpNum);

}
SaulWeChatPublicClass * userData = [SaulWeChatPublicClass sharedInstance];
NSLog(@"\nSaulWeChatPublicClass - %lu\n",(long)userData.dataItem.count);


static int listNum = 0;
NSLog(@"\n initWithDataItem \n key - %@ \n vle - %@ \n\n\n list number is %ld\n initWithDataItem ",mDelegate,arg1,(long)listNum);
listNum++;
*/
