#import "WeChat/CMessageWrap.h"
#import "WeChat/MMServiceCenter.h"
#import "WeChat/CMessageMgr.h"
#import "WeChat/CContactMgr.h"
#import "WeChat/CContact.h"
#import "SaulWeChatPublicClass.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>



%hook  WeixinContentLogicController

- (void)ViewDidAppear {
    %orig;
    SaulWeChatPublicClass * saul = [SaulWeChatPublicClass sharedInstance];
    [saul holdWeixinContentLogicController:self];
}
%end

%hook CMessageMgr

- (CMessageMgr *)init
{
CMessageMgr *result = %orig;
SaulWeChatPublicClass * saul = [SaulWeChatPublicClass sharedInstance];
[saul holdCMessageMgr:result];
return result;
}


- (void)AsyncOnPreAddMsg:(id)arg1 MsgWrap:(CMessageWrap *)arg2 {
%orig;

    NSLog((@"\n\n函数名\n%s "),__FUNCTION__);
    NSLog(@"\n发信人 %@ \n 收信人 %@ \n 正文 %@\n 类型 %lld\n ID %@ \n  %@ \n end",
arg2.m_nsFromUsr,arg2.m_nsRealChatUsr,arg2.m_nsContent,(long long)arg2.m_uiMessageType,arg2.m_nsRealChatUsr,arg2.m_nsToUsr);

/*
    CContactMgr *contactManager = [[objc_getClass("MMServiceCenter") defaultCenter] getService:[objc_getClass("CContactMgr") class]];
    CContact *selfContact = [contactManager getSelfContact];
NSLog(@"\n\n\nself = %@  ---- %@",selfContact.m_nsUsrName,arg2.m_nsToUsr);
*/

    if (![arg1 hasSuffix:@"@chatroom"]) {
        NSLog(@"不是群聊，不是群聊，不是群聊");
        return;
    }



    NSArray *result = (NSArray *)[objc_getClass("CContact") getChatRoomMemberWithoutMyself:arg2.m_nsFromUsr];
    for (CContact * contact in result) {
        if ([contact.m_nsUsrName isEqualToString: arg2.m_nsRealChatUsr]) {
            SaulWeChatPublicClass * saul = [SaulWeChatPublicClass sharedInstance];
            [saul getAtCContactWith:contact];
            NSLog(@"\n\n\n 找到了 %@ \n %@",contact,saul.atContact);
        }
    }

    switch(arg2.m_uiMessageType) {
        case 10002: { // 扫码入群
            SaulWeChatPublicClass * saul = [SaulWeChatPublicClass sharedInstance];
            if ([arg2.m_nsFromUsr hasSuffix:@"@chatroom"]) {
                if ([saul.addGroupDict objectForKey:arg2.m_nsFromUsr]) {
                    int num = [[saul.addGroupDict objectForKey:arg2.m_nsFromUsr] integerValue];
                    NSString * value = [NSString stringWithFormat:@"%lld",(long long)num+1];
                    [saul.addGroupDict setValue:value forKey:arg2.m_nsFromUsr];
                } else {
                    [saul.addGroupDict setValue:@"1" forKey:arg2.m_nsFromUsr];
                }
            }

            saul.addGroupNum = [[saul.addGroupDict objectForKey:arg2.m_nsFromUsr] integerValue];
            if (saul.addGroupNum >= saul.senMessageCount) {
                [saul sendMessage:arg2];
                saul.addGroupNum = 0;
                [saul.addGroupDict setValue:@"1" forKey:arg2.m_nsFromUsr];
            }
            break;
        }
/*
        case 10000: { // 邀请入群
            SaulWeChatPublicClass * saul = [SaulWeChatPublicClass sharedInstance];
            saul.addGroupNum += 1;
            if (saul.addGroupNum == 2) {
                [saul sendMessage:arg2];
                saul.addGroupNum = 0;
            }
            break;
        }
*/
        case 3: { // 图片
            SaulWeChatPublicClass * saul = [SaulWeChatPublicClass sharedInstance];
            [saul userSendImageReturnMessage:arg2];
            break;
        }
        default:
            break;
        }

}


%end


