#import "SaulWeChatPublicClass.h"
#import <objc/runtime.h>

@implementation SaulWeChatPublicClass
@synthesize isCheckDone,isNotFriend,isRemoveFriend,dataNumber,isCreatFloatButton,isCanUserInfo;
@synthesize isS1On,isS2On,isS3On,isS4On,isS5On,isS7On,isMoreViewController,isGetUserInfo,nearbyType,isS12On,isS13On;
@synthesize floatButton,shakeSence,shakeItem,isShakeDone,sayHelloString,tmpNearByUserInfo,tmpNearByUserNum,totalCount,isAddFriendSent,removeFriendNumberKey,isTmpUser,userInfoWithPWD,userInfoWithName,chatRoomCount,chatRoomTag,isAddFirendBegin,videoString,isS11On,isS10On,isS9On,isPushUserInfo;
@synthesize friendArray,massViewController,friendContactDic,sessionSelectView,groupContactDic,isUpdataInfo,sharefriendContactDic,massSendContentLogicController;

+ (instancetype)sharedInstance {
    static dispatch_once_t once;
    static SaulWeChatPublicClass *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[SaulWeChatPublicClass alloc] init];
    });
    return sharedInstance;
}

- (void)getTabBarViewWith:(MMTabBarController *)viewController {
    if (_tabBarViewController) {
        [_tabBarViewController release];
    }
    _tabBarViewController = [viewController retain];
//    NSLog(@"%s", __FUNCTION__);
//    NSLog(@"\n%@\n%@", _tabBarViewController, viewController);
}
- (id)getTabBarViewController {
    return _tabBarViewController;
}
- (void)getMoreViewControllerWith:(MoreViewController *)viewController {
    if (_moreViewController) {
        [_moreViewController release];
    }
    _moreViewController = [viewController retain];
//    NSLog(@"%s", __FUNCTION__);
//    NSLog(@"\n%@\n%@", _moreViewController, viewController);

}
- (id)getMoreViewController {
    return _moreViewController;
}
- (void)getActionSheetWith:(WCActionSheet *)viewController {
    if (_actionSheet) {
        [_actionSheet release];
    }
    _actionSheet = [viewController retain];
//    NSLog(@"%s", __FUNCTION__);
//    NSLog(@"\n%@\n%@", _actionSheet, viewController);
}
- (id)getActionSheet {
    return _actionSheet;
}



#pragma mark -- 创建浮动关闭插件按钮
- (void)buildFloatCloseButton
{
    if (!floatButton) {
        floatButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [floatButton setFrame:CGRectMake(0, [[UIApplication sharedApplication].delegate window].frame.size.height - 150, 45, 45)];
        [floatButton setImage:[UIImage imageNamed:@"Expression_63"] forState:UIControlStateNormal];
        [floatButton addTarget:self action:@selector(floatButtonClcked:) forControlEvents:UIControlEventTouchUpInside];
        [[[UIApplication sharedApplication].delegate window] addSubview:floatButton];
//        NSLog(@"creat");
    } else {
//        NSLog(@"done");
    }
}

- (void)floatButtonClcked:(UIButton *)sender {
    floatButton.hidden = YES;
    isS1On = isS2On = isS3On = isS4On = isS5On = isS7On =  isS9On =
    isS10On =  isS11On = isS12On = isAddFirendBegin = isUpdataInfo = NO;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CLOSED_TOOLS_NOTIFICATION" object:nil];

}

#pragma mark -- 跳转插件页面 翠航 == 3 other == 4
- (void)pushToolsViewController:(id)arg2 {
    NSIndexPath *indexPath = (NSIndexPath *)arg2;
    if (indexPath.section == 4 && isMoreViewController) {
        WeMediaToolsTableViewController * viewController = [[WeMediaToolsTableViewController alloc] init];
        _moreViewController.hidesBottomBarWhenPushed = YES;
        [_moreViewController.navigationController pushViewController:viewController animated:YES];
        _moreViewController.hidesBottomBarWhenPushed = NO;
    }
}

#pragma mark -- 新增插件cell
- (UITableViewCell *)buildToolsCellWith:(id)arg2 {
    NSIndexPath *indexPath = (NSIndexPath *)arg2;
    if (indexPath.section == 4 && isMoreViewController) {
        UITableViewCell * cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WeMediaTools"];
        cell.backgroundColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell.imageView.image = [UIImage imageNamed:@"Expression_37"];
        cell.textLabel.text = @"saulTong 插件集";
        return cell;
    }
    return nil;
}

#pragma mark -- 进入摇一摇页面
- (void)openWeMediaToolsWithViewController:(FindFriendEntryViewController *)viewController {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                 (int64_t)(.5 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(),^
    {
        if (isS1On || isS2On) {
            [viewController openNormalShake];
        } else if (isS3On) {
            [viewController openLBS];
        } else {
            
        }
                       
    });
}

#pragma mark -- 同意好友申请
- (void)doAddFriendAction:(CBaseContactInfoAssist *)infoAssist {
    [infoAssist onVerifyContactOk];
    isAddFriendSent = YES;
}

- (void)doDelegateFriendAction:(SayHelloDataLogic *)dataLogic andCellNum:(NSInteger)num {
    [dataLogic clearMsg:3 ForIndex:num];
}

#pragma mark -- 获取移除好友plist地址
- (NSString *)getRemoveUserFileAdress {
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString * path = [paths objectAtIndex:0];
    NSString * filename = [path stringByAppendingPathComponent:@"removeFriendNumberList.plist"];
    return filename;
}
#pragma mark -- 获取需要移除好友的当前用户信息
- (void)saveRemoveUserInfo:(NSString *)userID AndValue:(NSString *)numValue{
    removeFriendNumberKey = userID;
    NSString * filename = [self getRemoveUserFileAdress];
    NSDictionary * dic2 = [NSDictionary dictionaryWithContentsOfFile:filename];
    if(dic2 == nil) {
        NSFileManager* fm = [NSFileManager defaultManager];
        [fm createFileAtPath:filename contents:nil attributes:nil];
        NSDictionary* dd = [NSDictionary dictionaryWithObjectsAndKeys:@"0",removeFriendNumberKey,nil];
        [dd writeToFile:filename atomically:YES];
    } else {
        if (userID && numValue) {
            NSDictionary* dd = [NSDictionary dictionaryWithObjectsAndKeys:numValue,removeFriendNumberKey,nil];
            [dd writeToFile:filename atomically:YES];
        }
    }

//    NSLog(@"\n\n\n\n\n %@ _ %@ ",dic2,removeFriendNumberKey);
}
#pragma mark --

- (void)holdSessionSelectView:(SessionSelectView *)viewC {
    if (_sessionSelectView) {
        _sessionSelectView = nil;
    }
    self.sessionSelectView = [viewC retain];
}

- (void)holdMMMassSendContactSelectorViewController:(MMMassSendContactSelectorViewController *)viewC {
    if (_massViewController) {
        _massViewController = nil;
    }
    _massViewController = [viewC retain];
}

- (void)saveFriend:(NSMutableArray *)array {
    if (!_friendArray) {
        _friendArray = [[NSMutableArray arrayWithCapacity:array.count] mutableCopy];
    }
    _friendArray = [NSMutableArray arrayWithObject:array];
    
}

- (void)saveFriendContactDic:(NSDictionary *)dict {
    _friendContactDic =  [NSMutableDictionary dictionary];
    [_friendContactDic addEntriesFromDictionary:dict];
    self.friendContactDic = _friendContactDic;
    [self updataUserInfo:self.friendContactDic];
    
}

- (void)updataUserInfo:(NSMutableDictionary *)dict {
    if (!self.groupContactDic) {
        self.groupContactDic = [[NSMutableDictionary alloc] init];
    } else {
        [self.groupContactDic removeAllObjects];
    }
    for (NSString * key in [dict allKeys]) {
        if ([key hasSuffix:@"@chatroom"]) {                     // 群
            [self.groupContactDic setValue:[dict objectForKey:key] forKey:key];
            [self.friendContactDic removeObjectForKey:key];
        } else if ([key hasPrefix:@"gh_"]) {                    // 公众号
            [self.friendContactDic removeObjectForKey:key];
        } else if ([key isEqualToString:@"iwatchholder"] || [key isEqualToString:@"weixin"] || [key isEqualToString:@"notification_messages"]) {    // 系统
            [self.friendContactDic removeObjectForKey:key];
        }
    }
}

- (int)totalSectionWithArray:(NSMutableArray *)array {
    
    int count = array.count / 200;
    int mCount = array.count % 200;
    
    if (mCount > 0) {
        count += 1;
    }
    
    return count;
}

- (void)registerNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectDoneAndJump:) name:@"POST_SELECT_VIEW" object:nil];
}

- (void)removeNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"POST_SELECT_VIEW" object:nil];
}

- (void)jumpToFriendListViewController {
    MassTableViewController * viewController = [[MassTableViewController alloc] init];
    [_massViewController presentViewController:viewController animated:YES completion:nil];
}

- (void)selectDoneAndJump:(NSNotification *)notification {
    [self addMassUserInfo:[[notification object] integerValue]];
}

- (void)addMassUserInfo:(int)count {
    NSMutableSet *set = [NSMutableSet setWithCapacity:200];
    
    int num = (count + 1) * 200;
    
    if (num > self.friendArray.count) {
        num -= num;
        int tmp = self.friendArray.count % 200;
        for (int i = 0; i < tmp; i++) {
            int tmpNum = num * 200 + i;
            [set addObject:self.friendArray[tmpNum]];
        }
    } else {
        for (int i = 0; i < 200; i++) {
            int tmpNum = count * 200 + i;
            [set addObject:self.friendArray[tmpNum]];
        }
    }
    _massViewController.setSelectedContacts = set;
    
    [_massViewController onDone:nil];
}

- (void)holdSessionSelectController:(SessionSelectController *)viewC {
    if (_sessionSelectViewController) {
        _sessionSelectViewController = nil;
    }
    self.sessionSelectViewController = [viewC retain];
}

- (void)jumpToSelectListViewController {
    MassTableViewController * viewController = [[MassTableViewController alloc] init];
    [_sessionSelectViewController presentViewController:viewController animated:YES completion:nil];
}

- (int)totalSectionWithDictionary:(NSMutableDictionary *)dict {
    
    int count = dict.count / 200;
    int mCount = dict.count % 200;
    
    if (mCount > 0) {
        count += 1;
    }
    
    return count;
}

- (void)addShareUserInfo :(int)count {
    if (_sharefriendContactDic) {
        [_sharefriendContactDic removeAllObjects];
    } else {
        self.sharefriendContactDic = [NSMutableDictionary dictionaryWithCapacity:200];
    }
    
    NSArray *keys = [self.friendContactDic allKeys];
    
    
    int num = (count + 1) * 200;
    if (num > keys.count) {
        num -= num;
        int tmp = keys.count % 200;
        for (int i = 0; i < tmp; i++) {
            int tmpNum = num * 200 + i;
            [self.sharefriendContactDic setValue:self.friendContactDic[keys[tmpNum]] forKey:keys[tmpNum]];
        }
    } else {
        for (int i = 0; i < 200; i++) {
            int tmpNum = count * 200 + i;
            [self.sharefriendContactDic setValue:self.friendContactDic[keys[tmpNum]] forKey:keys[tmpNum]];
        }
    }
}

- (void)shareVideoAndMassMessage {
    if (isS9On || isS10On) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_moreViewController showFavoriteView];
        });
    } else if (isS11On) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_moreViewController showSettingView];
        });
    }
}

- (void)holdMassSendContentLogicController:(MassSendContentLogicController *)viewC {
    if (_massSendContentLogicController) {
        _massSendContentLogicController = nil;
    }
    self.massSendContentLogicController = [viewC retain];
}

#pragma mark --
- (NSMutableDictionary *)addGroupDict {
    if (!_addGroupDict) {
        _addGroupDict = [[NSMutableDictionary alloc] init];
    }
    return _addGroupDict;
}

- (void)getAtCContactWith:(CContact *)contact {
    if (self.atContact) {
        self.atContact = nil;
    }
    self.atContact = contact;
}

- (void)holdWeixinContentLogicController:(WeixinContentLogicController *)logVC {
    if (self.logicController) {
        return;
    }
    self.logicController = logVC;
}

- (void)holdCMessageMgr:(CMessageMgr *)mgr {
    self.globalMessageMgr = mgr;
}

- (void)sendMessage:(CMessageWrap *)arg2 {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray * tmpArr = @[@"[入群必读]欢迎各位朋友报名PPT七日提升营，抱团提升PPT制作能力。每天一篇PPT干货，认真坚持，七天就能掌握核心技巧。入群后，你将会免费得到价值999元的精选PPT课程。\n\n每天下午6点，我们将会在群内发放关于PPT制作的干货经验，包括排版、文案、背景、图片等多个方面的内容。我们还会不定期的在群内推送其他热门课程\n\n也就是说，加入到群内，不仅有ppt干货经验，还可以收获其他课程哦。注定你将不再是职场小白",
                             @"[报名方式]\n\n请复制下方的文字和图片，转发到自己的朋友圈，发表学习宣言。最后，将成功发布朋友圈的截图发到群里并@小助手。群满80人后我们会核对大家是否转发，未转发或秒删的将被请出社群，失去这个和大家共同成长的宝贵机会。\n\n朋友圈转发内容及配图如下\n\n↓↓↓↓↓↓",
                             @"我加入了 [PPT七日提升营]，组队提升PPT制作能力，在未来七天，坚持每天学习一篇干货，早日玩转PPT。希望大家一起学习，互相监督。"];
        if (!arg2.m_nsRealChatUsr.length) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                CMessageWrap *insideWrap = [self.logicController FormTextMsg:arg2.m_nsFromUsr withText:tmpArr[0]];
                [self.globalMessageMgr AddMsg:arg2.m_nsFromUsr MsgWrap:insideWrap];
            });
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                CMessageWrap *insideWrap = [self.logicController FormTextMsg:arg2.m_nsFromUsr withText:tmpArr[1]];
                [self.globalMessageMgr AddMsg:arg2.m_nsFromUsr MsgWrap:insideWrap];
            });
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                CMessageWrap *insideWrap = [self.logicController FormImageMsg:arg2.m_nsFromUsr withImage:[UIImage imageNamed:@"img.jpg"]];
                [self.globalMessageMgr AddMsg:arg2.m_nsFromUsr MsgWrap:insideWrap];
            });
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                CMessageWrap *insideWrap = [self.logicController FormTextMsg:arg2.m_nsFromUsr withText:tmpArr[2]];
                [self.globalMessageMgr AddMsg:arg2.m_nsFromUsr MsgWrap:insideWrap];
            });
        }
    });
    
    
}

- (void)sendMessageAndImage:(CMessageWrap*)arg2 {
    dispatch_queue_t q = dispatch_queue_create("fs", DISPATCH_QUEUE_SERIAL);
    NSArray * tmpArr = @[@"[入群必读]欢迎各位朋友报名PPT七日提升营，抱团提升PPT制作能力。每天一篇PPT干货，认真坚持，七天就能掌握核心技巧。入群后，你将会免费得到价值999元的精选PPT课程。\n\n每天下午6点，我们将会在群内发放关于PPT制作的干货经验，包括排版、文案、背景、图片等多个方面的内容。我们还会不定期的在群内推送其他热门课程\n\n也就是说，加入到群内，不仅有ppt干货经验，还可以收获其他课程哦。注定你将不再是职场小白",
                         @"[报名方式]\n\n请复制下方的文字和图片，转发到自己的朋友圈，发表学习宣言。最后，将成功发布朋友圈的截图发到群里并@小助手。群满80人后我们会核对大家是否转发，未转发或秒删的将被请出社群，失去这个和大家共同成长的宝贵机会。\n\n朋友圈转发内容及配图如下\n\n↓↓↓↓↓↓",
                         @"我加入了 [PPT七日提升营]，组队提升PPT制作能力，在未来七天，坚持每天学习一篇干货，早日玩转PPT。希望大家一起学习，互相监督。"];
    
    for (int i = 0 ; i <= tmpArr.count; i++) {
        dispatch_sync(q, ^{
            if (i < tmpArr.count) {
                CMessageWrap *insideWrap = [self.logicController FormTextMsg:arg2.m_nsFromUsr withText:tmpArr[i]];
                [self.globalMessageMgr AddMsg:arg2.m_nsFromUsr MsgWrap:insideWrap];
            } else {
                CMessageWrap *insideWrap = [self.logicController FormImageMsg:arg2.m_nsFromUsr withImage:[UIImage imageNamed:@"img.jpg"]];
                [self.globalMessageMgr AddMsg:arg2.m_nsFromUsr MsgWrap:insideWrap];
            }
        });
    }
    
}

- (void)userSendImageReturnMessage:(CMessageWrap *)arg2 {
    if (arg2.m_nsRealChatUsr.length) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSString * nsContent = [NSString stringWithFormat:@"@%@ %@",self.atContact.m_nsNickName,@"截图已上报成功，系统将会在两个小时内进行自动审核！如果期间未检测到您朋友圈的截图则为审核不通过，感谢您的分享。"];
            CMessageWrap *insideWrap = [self.logicController FormTextMsg:arg2.m_nsFromUsr withText:nsContent];
            insideWrap.m_nsAtUserList = self.atContact.m_nsUsrName;
            [self.globalMessageMgr AddMsg:arg2.m_nsFromUsr MsgWrap:insideWrap];
        });
    }
}

- (void)showThirtyCountImageWith:(CMessageWrap *)arg2 {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (!arg2.m_nsRealChatUsr.length) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                CMessageWrap *insideWrap = [self.logicController FormImageMsg:arg2.m_nsFromUsr withImage:[UIImage imageNamed:@"showImg.jpg"]];
                [self.globalMessageMgr AddMsg:arg2.m_nsFromUsr MsgWrap:insideWrap];
            });
        }
    });
}
#pragma mark --
#pragma mark --
#pragma mark --
#pragma mark --
#pragma mark --
@end













