
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
                CMessageWrap *insideWrap = [self.logicController FormImageMsg:arg2.m_nsFromUsr withImage:[UIImage imageNamed:@"test.jpeg"]];
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
                CMessageWrap *insideWrap = [self.logicController FormImageMsg:arg2.m_nsFromUsr withImage:[UIImage imageNamed:@"test.jpeg"]];
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






@end


