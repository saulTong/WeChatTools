

@interface SaulWeChatPublicClass : NSObject
{
    BOOL isCheckDone;
    BOOL isNotFriend;
    BOOL isRemoveFriend;
    BOOL isGetUserList;
    NSInteger dataNumber;
    NSString * removeFriendNumberKey;
}
@property (nonatomic, assign) BOOL isCheckDone;
@property (nonatomic, assign) BOOL isNotFriend;
@property (nonatomic, assign) BOOL isRemoveFriend;
@property (nonatomic, assign) BOOL isGetUserList;
@property (nonatomic, assign) NSInteger dataNumber;
@property (nonatomic, retain) NSString * removeFriendNumberKey;
+(instancetype)sharedInstance;


@end

/*
 #import "WeChat/ContactInfoViewController.h"
 #import "WeChat/WCTimeLineFooterView.h"
 #import "WeChat/WCListViewController.h"
 #import "WeChat/WeixinContactInfoAssist.h"
 #import "WeChat/CBaseContactInfoAssist.h"
 #import "WeChat/ContactsViewController.h"
 #import "WeChat/ContactsDataLogic.h"
 #import "WeChat/CBaseContact.h"
 #import "SaulWeChatPublicClass.h"
 #import "WeChat/MMTabBarController.h"
 
 SaulWeChatPublicClass * saulClass;
 NSMutableArray * array;
 
 %hook MMTabBarController
 - (void)viewDidLoad
 {
 %orig;
 
 UILabel * label = [[UILabel alloc] init];
 label.frame = CGRectMake(160, 20, 70, 30);
 label.textColor = [UIColor whiteColor];
 label.font = [UIFont systemFontOfSize:12];
 label.text = @"删除好友 →";
 [self.view addSubview:label];
 
 UISwitch *switch1 = [[UISwitch alloc]init];
 switch1.frame = CGRectMake(230, 20, 0, 0);
 [switch1 setOn:NO];
 [switch1 addTarget:self action:@selector(switchIsChanged:) forControlEvents:UIControlEventValueChanged];
 [self.view addSubview:switch1];
 }
 
 %new
 -(void)switchIsChanged:(UISwitch *)swith
 {
 if ([swith isOn]){
 [SaulWeChatPublicClass sharedInstance].isRemoveFriend = YES;
 } else {
 [SaulWeChatPublicClass sharedInstance].isRemoveFriend = NO;
 }
 [SaulWeChatPublicClass sharedInstance].dataNumber = 0;
 }
 
 %end
 
 %hook ContactsViewController
 - (void)viewWillAppear:(_Bool)arg1
 {
 %orig;
 
 if (![SaulWeChatPublicClass sharedInstance].isRemoveFriend) {
 return;
 }
 
 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
 
 if (saulClass.dataNumber < array.count) {
 CBaseContact * contact = array[saulClass.dataNumber];
 NSLog(@"\n %@ \n %@ \n %lld \n ↑",[contact getContactTalkRoomName],contact,(long long)saulClass.dataNumber);
 
 if ([contact isSelf] ||
 [contact isWeixinTeamContact] ||
 [contact isFileHelper] ||
 [[contact getContactTalkRoomName] isEqualToString:@"公众号安全助手"] ||
 [[contact getContactTalkRoomName] isEqualToString:@"微信支付"] ||
 [[contact getContactTalkRoomName] isEqualToString:@"最热视频库"] ||
 [[contact getContactTalkRoomName] isEqualToString:@"最爱萌宠"] ||
 [[contact getContactTalkRoomName] isEqualToString:@"一条笑话"] ||
 [[contact getContactTalkRoomName] isEqualToString:@"运动范"] ||
 [[contact getContactTalkRoomName] isEqualToString:@"星座说"] ||
 [[contact getContactTalkRoomName] isEqualToString:@"笑料包袱铺"] ||
 [[contact getContactTalkRoomName] isEqualToString:@"天天测试"] ||
 [[contact getContactTalkRoomName] isEqualToString:@"社长有点儿慌"] ||
 [[contact getContactTalkRoomName] isEqualToString:@"热门爆笑gif图"] ||
 [[contact getContactTalkRoomName] isEqualToString:@"全球爆笑汇"] ||
 [[contact getContactTalkRoomName] isEqualToString:@"牛逼视频"] ||
 [[contact getContactTalkRoomName] isEqualToString:@"喵智障"] ||
 [[contact getContactTalkRoomName] isEqualToString:@"每日最新热点视频"] ||
 [[contact getContactTalkRoomName] isEqualToString:@"免费艺术签名馆"] ||
 [[contact getContactTalkRoomName] isEqualToString:@"老王有点忙"] ||
 [[contact getContactTalkRoomName] isEqualToString:@"灵异漫画"] ||
 [[contact getContactTalkRoomName] isEqualToString:@"冷丫"] ||
 [[contact getContactTalkRoomName] isEqualToString:@"奇葩爆笑说"] ||
 [[contact getContactTalkRoomName] isEqualToString:@"精选爆笑汇"] ||
 [[contact getContactTalkRoomName] isEqualToString:@"精选女主播"] ||
 [[contact getContactTalkRoomName] isEqualToString:@"花花校园"] ||
 [[contact getContactTalkRoomName] isEqualToString:@"搞笑奇葩大爆料"] ||
 [[contact getContactTalkRoomName] isEqualToString:@"共读吧"] ||
 [[contact getContactTalkRoomName] isEqualToString:@"穿搭时尚派"] ||
 [[contact getContactTalkRoomName] isEqualToString:@"不瘦不爱"] ||
 [[contact getContactTalkRoomName] isEqualToString:@"比比谁更贱"] ) {
 [self viewWillAppear:arg1];
 } else {
 [self showContactInfoView:contact];
 }
 saulClass.dataNumber++;
 } else{
 UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"删除%lld个单向好友",(long long)saulClass.isDelFriend] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"okay",nil];
 [alert show];
 saulClass.dataNumber = 0;
 }
 });
 }
 
 - (void)viewDidLoad {
 %orig;
 array = [[NSMutableArray alloc] init];
 Ivar mDelegateVar = class_getInstanceVariable(objc_getClass("ContactsViewController"), "m_contactsDataLogic");
 ContactsDataLogic * mDelegate = object_getIvar(self, mDelegateVar);
 array = [mDelegate getAllContacts];
 
 }
 %end
 
 %hook WeixinContactInfoAssist
 - (_Bool)isNeedHideUserName
 {
 BOOL orig = %orig;
 
 if (![SaulWeChatPublicClass sharedInstance].isRemoveFriend) {
 return orig;
 }
 
 if (saulClass.isCheckDone) {
 if (saulClass.isNotFriend) { // 不是好友
 saulClass.isCheckDone = NO;
 saulClass.isNotFriend = NO;
 [self doDeleteContact];
 saulClass.isDelFriend++;
 }
 }
 
 return orig;
 }
 %end
 
 %hook ContactInfoViewController
 
 - (void)viewWillAppear:(BOOL)arg1 {
 %orig;
 
 if (![SaulWeChatPublicClass sharedInstance].isRemoveFriend) {
 return;
 }
 
 if (!saulClass) {
 saulClass = [SaulWeChatPublicClass sharedInstance];
 }
 if (saulClass.isCheckDone) {
 if (!saulClass.isNotFriend) {
 saulClass.isCheckDone = NO;
 [self.navigationController popViewControllerAnimated:YES];
 } else {
 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
 [self.navigationController popViewControllerAnimated:YES];
 });
 }
 
 } else {
 Ivar mDelegateVar = class_getInstanceVariable(objc_getClass("ContactInfoViewController"), "m_oContactInfoAssist");
 CBaseContactInfoAssist * mDelegate = object_getIvar(self, mDelegateVar);
 [mDelegate showAlbumList];
 }
 
 }
 
 %end
 
 %hook WCListViewController // 判断是否是好友
 - (void)viewDidLoad {
 %orig;
 
 if (![SaulWeChatPublicClass sharedInstance].isRemoveFriend) {
 return;
 }
 
 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
 
 saulClass.isCheckDone = YES;
 [self onDissmiss];
 });
 }
 
 %end
 
 
 %hook WCTimeLineFooterView
 
 - (id)initWithFrame:(struct CGRect)arg1 {
 id orig = %orig;
 
 if (![SaulWeChatPublicClass sharedInstance].isRemoveFriend) {
 return orig;
 }
 
 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
 [self onClick];
 });
 
 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
 Ivar mDelegateVar = class_getInstanceVariable(objc_getClass("WCTimeLineFooterView"), "m_label");
 UILabel * mDelegate = object_getIvar(self, mDelegateVar);
 if ([mDelegate.text isEqualToString:@"非对方的朋友只显示最多十张照片"]) {
 saulClass.isNotFriend = YES;
 }
 });
 
 return orig;
 }
 
 %end
 

 */
