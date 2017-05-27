%hook ApInfo

+ (void)initialize {
%orig;
NSLog((@"\n\n函数名\n%s\nend"),__FUNCTION__);
}

%end

%hook OpenUDID

+ (id)_generateFreshOpenUDID {
id orig = %orig;
NSLog((@"\n\n函数名\n%s\nend"),__FUNCTION__);
return orig;
}

+ (id)_getDictFromPasteboard:(id)arg1 {
id orig = %orig;
NSLog((@"\n\n函数名\n%s\nend"),__FUNCTION__);
return orig;
}

+ (void)_setDict:(id)arg1 forPasteboard:(id)arg2 {
%orig;
NSLog((@"\n\n函数名\n%s\nend"),__FUNCTION__);
}

+ (void)setOptOut:(_Bool)arg1 {
%orig;
NSLog((@"\n\n函数名\n%s\nend"),__FUNCTION__);
}

+ (id)value {
id orig = %orig;
NSLog((@"\n\n函数名\n%s\nend"),__FUNCTION__);
return orig;
}

+ (id)valueWithError:(id *)arg1 {
id orig = %orig;
NSLog((@"\n\n函数名\n%s\nend"),__FUNCTION__);
return orig;
}

%end


%hook TenpayUDID

+ (id)generateFreshUDID {
id orig = %orig;
NSLog((@"\n\n函数名\n%s\nend"),__FUNCTION__);
return orig;
}

+ (id)getUDIDInKeyChain {
id orig = %orig;
NSLog((@"\n\n函数名\n%s\nend"),__FUNCTION__);
return orig;
}

+ (void)saveUDIDInKeyChain:(id)arg1 {
%orig;
NSLog((@"\n\n函数名\n%s\nend"),__FUNCTION__);
}

+ (id)value {
id orig = %orig;
NSLog((@"\n\n函数名\n%s\nend"),__FUNCTION__);
return orig;
}




%end





































































































































































































/*

#import "WeChat/MultiSelectContactsViewController.h"

%hook MultiSelectContactsViewController


- (unsigned long long)getTotalSelectCount {
NSLog((@"\n\n [函数名:%s]\n end"),__FUNCTION__);
self.m_memberCountLimit = 10000;
return 3;
}

- (_Bool)onShouldSelectContact:(id)arg1 {
BOOL orig = %orig;
NSLog((@"\n\n [函数名:%s]\n \n %@ \n\n \n\n %p \n\n %@ \n\n\n end"),__FUNCTION__,arg1,arg1,[arg1 class]);

return orig;

}


- (_Bool)onFilterContactCandidate:(id)arg1 {
BOOL orig = %orig;
NSLog((@"\n\n [函数名:%s]\n \n %@ \n\n \n\n %p \n\n %@ \n\n\n end"),__FUNCTION__,arg1,arg1,[arg1 class]);

return orig;

}
- (void)onDone:(id)arg1 {
%orig;
NSLog((@"\n\n [函数名:%s]\n \n %@ \n\n \n\n %p \n\n %@ \n\n\n end"),__FUNCTION__,arg1,arg1,[arg1 class]);


}
- (void)onCancel:(id)arg1 {
%orig;
NSLog((@"\n\n [函数名:%s]\n \n %@ \n\n \n\n %p \n\n %@ \n\n\n end"),__FUNCTION__,arg1,arg1,[arg1 class]);


}

- (void)onSelectDoneWithContacts:(id)arg1 {
%orig;
NSLog((@"\n\n [函数名:%s]\n %@ \n end"),__FUNCTION__,arg1);

}

- (void)doSearch:(id)arg1 Pre:(_Bool)arg2 {
%orig;
NSLog((@"\n\n [函数名:%s]\n %@ \n end"),__FUNCTION__,arg1);

}


- (void)didDeleteLastWithKey:(id)arg1 {
%orig;
NSLog((@"\n\n [函数名:%s]\n %@ \n end"),__FUNCTION__,arg1);

}

- (void)didClickImageAtIndex:(unsigned int)arg1 withKey:(id)arg2 {
%orig;
NSLog((@"\n\n [函数名:%s]\n %lld \n %@ \n end"),__FUNCTION__,(long long)arg1,arg2);

}

- (void)onSelectContact:(id)arg1 {
%orig;
NSLog((@"\n\n [函数名:%s]\n %@ \n end"),__FUNCTION__,arg1);

}

- (void)doTagSearch:(id)arg1 arrContacts:(id)arg2 {
%orig;
NSLog((@"\n\n [函数名:%s]\n %@ \n %@ \n end"),__FUNCTION__,arg1,arg2);

}

- (void)didSearchViewTableSelect:(id)arg1 {
%orig;
NSLog((@"\n\n [函数名:%s]\n %@ \n end"),__FUNCTION__,arg1);

}
- (id)cellForSearchViewTable:(id)arg1 index:(id)arg2 {
id orig = %orig;
NSLog((@"\n\n [函数名:%s]\n \n %@ \n\n \n\n %@ \n\n %@ \n\n\n end"),__FUNCTION__,arg1,arg2,orig);


return orig;
}


- (id)makeFiterContactToTagSearchView:(id)arg1 {
id orig = %orig;
NSLog((@"\n\n [函数名:%s]\n \n %@ \n\n \n\n %@ \n\n %@ \n\n\n end"),__FUNCTION__,arg1,orig,[orig class]);


return orig;
}

- (void)cancelSearch{
%orig;
NSLog((@"\n\n [函数名:%s]\n \n end"),__FUNCTION__);

}


- (void)onSelectRadarCreateRoom{
%orig;
NSLog((@"\n\n [函数名:%s]\n \n end"),__FUNCTION__);

}


- (void)onSelectHistoryGroup{
%orig;
NSLog((@"\n\n [函数名:%s]\n \n end"),__FUNCTION__);

}


- (void)onContactSelectSearchSections:(id)arg1 sectionTitles:(id)arg2 sectionResults:(id)arg3{
%orig;
NSLog((@"\n\n [函数名:%s]\n \n %@ \n\n \n\n %p \n\n %@ \n\n\n end"),__FUNCTION__,arg1,arg1,[arg1 class]);

}


- (void)scrollViewWillBeginDragging:(id)arg1{
%orig;
NSLog((@"\n\n [函数名:%s]\n \n %@ \n\n \n\n %p \n\n %@ \n\n\n end"),__FUNCTION__,arg1,arg1,[arg1 class]);

}


- (void)tryShowSelectTip:(unsigned long long)arg1 currentSelectCount:(unsigned long long)arg2 {
%orig;
NSLog((@"\n\n [函数名:%s]\n \n %lld \n\n \n\n %lld \n\n\n end"),__FUNCTION__,arg1,arg2);

}


- (void)onTipsViewClick:(id)arg1 {
%orig;
NSLog((@"\n\n [函数名:%s]\n \n %@ \n\n \n\n %p \n\n %@ \n\n\n end"),__FUNCTION__,arg1,arg1,[arg1 class]);

}



- (void)willAnimateRotationToInterfaceOrientation:(long long)arg1 duration:(double)arg2  {
%orig;
NSLog((@"\n\n [函数名:%s]\n \n %lld \n\n \n\n %f \n\n\n end"),__FUNCTION__,arg1,arg2);

}


- (void)updatePanelView:(id)arg1 {
%orig;
NSLog((@"\n\n [函数名:%s]\n \n %@ \n\n \n\n %p \n\n %@ \n\n\n end"),__FUNCTION__,arg1,arg1,[arg1 class]);

}


- (void)onGroupMultiSelectContactReturn:(id)arg1 {
%orig;
NSLog((@"\n\n [函数名:%s]\n \n %@ \n\n \n\n %p \n\n %@ \n\n\n end"),__FUNCTION__,arg1,arg1,[arg1 class]);

}


- (void)onGroupSelectContactReturn:(id)arg1 {
%orig;
NSLog((@"\n\n [函数名:%s]\n \n %@ \n\n \n\n %p \n\n %@ \n\n\n end"),__FUNCTION__,arg1,arg1,[arg1 class]);

}


%end





#import "WeChat/CMessageWrap.h"


%hook CExtendInfoOfVideo


- (NSString *)xmlOfStreamVideo {
NSString * orig = %orig;
NSLog((@"\n\n [函数名:%s]\n \n %@ \n\n \n\n %p \n\n %@ \n\n\n end"),__FUNCTION__,orig,orig,[orig class]);

return orig;
}


%end

%hook CMessageWrap
- (id)GetDisplayContent {
id orig = %orig;

NSLog((@"\n\n [函数名:%s]\n \n %@ \n\n \n\n %p \n\n\n end"),__FUNCTION__,orig,orig);

return orig;
}

- (id)wishingString  {
id orig = %orig;

NSLog((@"\n\n [函数名:%s]\n \n %@ \n\n \n\n %p \n\n\n end"),__FUNCTION__,orig,orig);

return orig;
}

- (id)nativeUrl  {
id orig = %orig;

NSLog((@"\n\n [函数名:%s]\n \n %@ \n\n \n\n %p \n\n\n end"),__FUNCTION__,orig,orig);

return orig;
}
- (id)GetThumb  {
id orig = %orig;

NSLog((@"\n\n [函数名:%s]\n \n %@ \n\n \n\n %p \n\n\n end"),__FUNCTION__,orig,orig);

return orig;
}

- (id)GetMsgClientMsgID  {
id orig = %orig;

NSLog((@"\n\n [函数名:%s]\n \n %@ \n\n \n\n %p \n\n\n end"),__FUNCTION__,orig,orig);

return orig;
}
- (id)getMsgExtBizId  {
id orig = %orig;

NSLog((@"\n\n [函数名:%s]\n \n %@ \n\n \n\n %p \n\n\n end"),__FUNCTION__,orig,orig);

return orig;
}



%end

%hook CMessageMgr
- (void)AsyncOnAddMsg:(id)arg1 MsgWrap:(CMessageWrap *)arg2 {
%orig;
if (arg2.m_uiMessageType == 43)
    NSLog((@"\n\n\n [函数名:%s]\n \n %@ \n\n %@ \n\n %p \n end"),__FUNCTION__,arg1,arg2,arg2);

}

- (void)StartDownloadShortVideo:(id)arg1 {
%orig;
NSLog((@"\n\n [函数名:%s] \n\n %@ \n\n %p \n\n end"),__FUNCTION__,arg1,arg1);

}






%end



%hook BaseMsgContentViewController

- (void)MessageReturn:(unsigned int)arg1 MessageInfo:(NSDictionary *)arg2 Event:(unsigned int)arg3 {

%orig;

NSLog((@"\n\n\n\n\n\n\n [函数名:%s]\n \n %lld \n\n %@ \n %lld \n\nend"),__FUNCTION__,(long long)arg1,arg2,(long long)arg3);

}

%end


%hook BaseMsgContentViewController

- (void)onJumpToViewDetail:(id)arg1 {
%orig;
NSLog((@"\n\n\n\n\n\n\n [函数名:%s]\n  %@ \n end"),__FUNCTION__,arg1);
}


- (void)onMsgImgPreviewDataRequired:(id)arg1 {
%orig;
NSLog((@"\n\n\n\n\n\n\n [函数名:%s]\n  %@ \n end"),__FUNCTION__,arg1);
}


- (void)onSightViewDetail:(id)arg1 vc:(id)arg2 {
%orig;
NSLog((@"\n\n\n\n\n\n\n [函数名:%s]\n  %@ \n %@ \n end"),__FUNCTION__,arg1,arg2);
}


- (void)onPlayAttachVideo:(id)arg1 vc:(id)arg2 {
%orig;
NSLog((@"\n\n\n\n\n\n\n [函数名:%s]\n  %@ \n %@ \n end"),__FUNCTION__,arg1,arg2);
}


- (void)onImgMsgLocate:(id)arg1 vc:(id)arg2 {
%orig;
NSLog((@"\n\n\n\n\n\n\n [函数名:%s]\n  %@ \n %@ \n end"),__FUNCTION__,arg1,arg2);
}




%end



#import "WeChat/WtloginPlatformInfo.h"



%hook VideoMessageCellView


- (void)StartDownloadVideo:(id)arg1 {
%orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt \n\n\n %@"), __FILE__, __FUNCTION__,arg1);


}




- (void)StartDownloadVideo:(id)arg1 DownloadMode:(unsigned long long)arg2 {
%orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt \n\n\n %@\n\n\n %lld"), __FILE__, __FUNCTION__,arg1,arg2);

}



- (void)StartUploadVideo:(id)arg1 {
%orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt \n\n\n %@"), __FILE__, __FUNCTION__,arg1);

}


- (void)onSliencePlay:(id)arg1 {
%orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt \n\n\n %@"), __FILE__, __FUNCTION__,arg1);

}

- (void)onTouchUpInside{
%orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt \n\n\n"), __FILE__, __FUNCTION__);

}

- (id)initWithViewModel:(id)arg1 {
id orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt \n\n\n %@"), __FILE__, __FUNCTION__,arg1);

return orig;

}

%end






%hook CMessageMgr
- (void)AsyncOnAddMsg:(id)arg1 MsgWrap:(id)arg2 {
%orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt \n\n\n %@ \n\n %@"), __FILE__, __FUNCTION__,arg1,arg2);

}
%end

%hook VideoMessageViewModel

+ (_Bool)canCreateMessageViewModelWithMessageWrap:(id)arg1 {
BOOL orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n \n %@ fmt"), __FILE__, __FUNCTION__,arg1);

return orig;
}

- (id)initWithMessageWrap:(id)arg1 contact:(id)arg2 chatContact:(id)arg3 {
id orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n %@ \n %@ \n %@ fmt"), __FILE__, __FUNCTION__,arg1,arg2,arg3);

return orig;
}

- (id)cellViewClassName {
id orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n \n %@ \n fmt"), __FILE__, __FUNCTION__,orig);

return orig;
}

- (id)additionalAccessibilityDescription {
id orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n \n %@ fmt"), __FILE__, __FUNCTION__,orig);

return orig;
}



%end

/////


%hook WtloginPlatformInfo


- (void)_checkDevice {
%orig;
NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
}

- (void)writeSigDataTofile {
%orig;
NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
}

- (void)printAllMemsig {
%orig;
NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
}

- (void)clearNameToUin:(id)arg1 {
%orig;
NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
}

- (void)clearPwdSigUser:(unsigned int)arg1 {
%orig;
NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
}

- (void)resetKeyChain {
%orig;
NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
}

- (void)setConfigObject:(id)arg1 forKey:(id)arg2 {
%orig;
NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
}

- (void)wtloginPlatformDataInit {
%orig;
NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
}

- (void)genGuid {
%orig;
NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
}

- (void)GetHWAddresses {
%orig;
NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
}

- (void)GetIPAddresses {
%orig;
NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
}

- (void)FreeAddresses {
%orig;
NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
}

- (void)InitAddresses {
%orig;
NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
}



- (_Bool)tryDecrypt:(id)arg1 byKey:(id)arg2 andOutData:(id)arg3 {
BOOL orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);

return orig;
}

- (_Bool)setKsidToConfig:(id)arg1 forAccount:(id)arg2 {
BOOL orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);

return orig;
}

- (_Bool)setKsidToKeyChain:(id)arg1 {
BOOL orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);

return orig;
}

- (_Bool)setSavePwdSigToConfig:(id)arg1 forAccount:(unsigned int)arg2 {
BOOL orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);

return orig;
}

- (_Bool)setNameToConfig:(id)arg1 forUin:(unsigned int)arg2 {
BOOL orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);

return orig;
}

- (_Bool)resetLastLoginInfo {
BOOL orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);

return orig;
}

- (_Bool)setSigVailidateTime:(unsigned int)arg1 bySigType:(unsigned int)arg2 {
BOOL orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);

return orig;
}



- (unsigned int)lastLoginTime {
BOOL orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);

return orig;
}

- (unsigned int)sigVailidateBySigType:(unsigned int)arg1 {
BOOL orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);

return orig;
}


- (int)netState {
int orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);

return orig;
}


- (id)init {
id orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);

return orig;
}

- (id)macaddress {
id orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);

return orig;
}

- (id)getDeviceVersion {
id orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);

return orig;
}

- (id)ksidFromKeyChain {
id orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);

return orig;
}

- (id)tgtgtKeyFromKeyChain {
id orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);

return orig;
}

- (id)crtCarrierName {
id orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);

return orig;
}

- (id)ksidForUser:(id)arg1 {
id orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);

return orig;
}

- (id)configObjectForKey:(id)arg1 {
id orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);

return orig;
}

- (id)pwdSigUser:(unsigned int)arg1 {
id orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);

return orig;
}

- (id)appMainBundleIndentify {
id orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);

return orig;
}

- (id)appBundleVersion {
id orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);

return orig;
}

- (id)appBundleShortVersionString {
id orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);

return orig;
}

- (id)lastLoginAppVer {
id orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);

return orig;
}

- (id)lastLoginSdkVer {
id orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);

return orig;
}

- (id)guidForReport {
id orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
return orig;
}



%end


%hook WCSearchedDevice


- (id)initWithLanDevice:(id)arg1 {
id orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
return orig;
}

- (id)initWithBleDevice:(id)arg1 {
id orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
return orig;
}

- (id)init {
id orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
return orig;
}


%end


%hook WCDeviceUtil

+ (unsigned int)getUploadStepBeginTime {
int orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
return orig;
}


+ (id)deviceFromHardDevice:(id)arg1 DeviceAttr:(id)arg2 {
id orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
return orig;
}


+ (id)displayNameFromDevice:(id)arg1 {
id orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
return orig;
}


+ (_Bool)isInternalSportBrand:(id)arg1 {
BOOL orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
return orig;
}


+ (id)parseDeviceLikeMessageXML:(id)arg1 {
id orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
return orig;
}


+ (id)parseDeviceRankMessageXML:(id)arg1 {
id orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
return orig;
}


+ (_Bool)parseConnectProto:(id)arg1:(id)arg2 {
BOOL orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
return orig;
}


+ (unsigned int)hashString:(id)arg1 {
int orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
return orig;
}


+ (_Bool)saveDeviceBoundRelationshipVersion:(unsigned int)arg1 {
BOOL orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt \n %lld \n %d"), __FILE__, __FUNCTION__,(long long)arg1,orig);
return orig;
}


+ (unsigned int)getDeviceBoundRelationshipVersion {
int orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt \n %lld"), __FILE__, __FUNCTION__,(long long)orig);
return 1;
}


+ (void)addLocalMessage:(id)arg1 MessageContent:(id)arg2 {
%orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
}


+ (id)getLocalMessage:(id)arg1 {
id orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
return orig;
}


+ (long long)genTaskId {
long long orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
return orig;
}


+ (id)parseWCDeviceMsg:(id)arg1 {
id orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
return orig;
}


%end


%hook WtloginPlatformInfo

+ (id)getFileValueTypeTable {
id orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
return orig;
}


+ (id)getPackedValueTypeTable {
id orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
return orig;
}


+ (id)getValueTable {
id orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
return orig;
}


+ (id)dummyObject {
id orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
return orig;
}


- (id)deviceMacNumber {
id orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
return orig;
}


- (id)deviceDisplayIconUrl {
id orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
return orig;
}


- (id)deviceDisplayTitle {
id orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
return orig;
}


- (id)getValueTypeTable {
id orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
return orig;
}


- (id)ownerDevice {
id orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
return orig;
}


- (id)subDevices {
id orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
return orig;
}


- (id)subDeviceMd5 {
id orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
return orig;
}


- (id)getDeviceSupportUrls {
id orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
return orig;
}


- (id)getExternalInfoDictionary {
id orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
return orig;
}




- (_Bool)isValidDevice {
BOOL orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
return orig;
}


- (_Bool)hasAbility:(id)arg1 {
BOOL orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
return orig;
}

+ (_Bool)hasBoundValidDevices {
BOOL orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
return orig;
}

+ (_Bool)hasBoundAbilityDevices {
BOOL orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
return orig;
}

- (_Bool)isIgnoreInChatView {
BOOL orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
return orig;
}

- (_Bool)isAlwaysConnectInChatView {
BOOL orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
return orig;
}

- (_Bool)isConnectOnceInChatView {
BOOL orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
return orig;
}

- (_Bool)isContinueConnectWhenExit {
BOOL orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
return orig;
}

- (_Bool)isWeightScaleDev {
BOOL orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
return orig;
}

- (_Bool)isPedometerDev {
BOOL orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
return orig;
}

- (_Bool)isBleSimpleDev {
BOOL orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
return orig;
}

- (_Bool)isM7Device {
BOOL orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
return orig;
}

- (_Bool)isWifiDevice {
BOOL orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
return orig;
}

- (_Bool)isBLEDevice {
BOOL orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
return orig;
}

- (_Bool)isEADevice {
BOOL orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
return orig;
}

- (_Bool)isBluetoohDevice {
BOOL orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
return orig;
}

- (_Bool)isSubLanDevice {
BOOL orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
return orig;
}

- (_Bool)canApplyURL:(id)arg1 {
BOOL orig = %orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
return orig;
}







- (void)setupDataBeforeWriteDB {
%orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
}

- (void)setupDataFromDB {
%orig;

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n  fmt"), __FILE__, __FUNCTION__);
}









%end




*/
