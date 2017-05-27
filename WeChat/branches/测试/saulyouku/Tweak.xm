#import "YKCVipModel.h"
#import "YYMediaPlayer.h"

%hook PlayVideoController
- (void)playVideo:(id)arg1 cardList:(id)arg2 {
%orig;
NSLog(@"\n play1111Video \n %@ \n %@ \n play1111Video",arg1, arg2);

}
- (void)playVideoWithVid:(id)arg1 sid:(id)arg2 aid:(id)arg3 episode:(long long)arg4 cardList:(id)arg5 {
%orig;
NSLog(@"\n play11222211Video \n %@ \n %@ \n %@ \n %@ \n play11222211Video",arg1, arg2,arg3,arg5);

}

- (id)playerUserSubscbInfo {
    id orig = %orig;
NSLog(@"\n playerUserSubscbInfo \n %@ \n playerUserSubscbInfo",orig);

    return orig;
}


%end

%hook VIP_ServiceManager

- (id)getDataWithServiceKey:(id)arg1 cacheKey:(id)arg2 datasetDic:(id)arg3 isCookie:(_Bool)arg4 isRepeat:(_Bool)arg5 isNeedCache:(_Bool)arg6 isForWeex:(_Bool)arg7 success:(SEL)arg8 failure:(SEL)arg9  {
id orig = %orig;
return orig;
}




- (id)getDataWithServiceKey:(id)arg1 cacheKey:(id)arg2 datasetDic:(id)arg3 isCookie:(_Bool)arg4 isRepeat:(_Bool)arg5 isNeedCache:(_Bool)arg6 success:(SEL)arg7 failure:(SEL)arg8  {
id orig = %orig;
return orig;
}

- (id)getParametersDic:(id)arg1 cacheKye:(id)arg2{
id orig = %orig;
return orig;
}


- (id)getResponseDic:(id)arg1{
    id orig = %orig;
    NSDictionary * dic = orig;
    if ([dic[@"result"][@"data"] isKindOfClass:[NSDictionary class]]) {
        if([[dic[@"result"][@"data"] allKeys] containsObject:@"is_vip"]) {
            NSDictionary * tmpDicData = @{ @"mobile" : dic[@"result"][@"data"][@"mobile"],@"uid" : dic[@"result"][@"data"][@"uid"],@"uname" : dic[@"result"][@"data"][@"uname"],@"user_icon" : dic[@"result"][@"data"][@"user_icon"],@"user_icon_small" : dic[@"result"][@"data"][@"user_icon_small"],@"ytid"       : dic[@"result"][@"data"][@"ytid"],@"is_vip" : [NSNumber numberWithBool:YES]};
            NSDictionary * tmpDicResult = @{@"data": tmpDicData};
            NSDictionary * dict = @{@"error": @"1", @"msg"  : @"1", @"result": tmpDicResult};
            return dict;
        }
    }
    return orig;
}

%end


%hook YKCUserModel

- (id)vipInfo:(id)arg {
%orig;
Ivar mDelegateVar = class_getInstanceVariable(objc_getClass("YKCUserModel"), "vipInfo");
id mDelegate = object_getIvar(self, mDelegateVar);

NSLog(@"\n\n\n\n vipInfo \n\n\n\n vipInfo");
YKCVipModel * info = mDelegate;

info.icon = [NSURL URLWithString:@"http://img4.imgtn.bdimg.com/it/u=3645816523,2998547329&fm=23&gp=0.jpg"];
info.mmid = [NSNumber numberWithInt:1234567890];
info.name = @"i'am vip";
info.state = [NSNumber numberWithInt:1];
info.vipGrade = [NSNumber numberWithInt:2];

return info;
}


%end


%hook YYMediaPlayer

- (id)adCookieValue {
id orig = %orig;

NSLog(@"\nadCookieValue\n\n\n %@ \n %@ \n\n\n\n\n\n orig",orig,self);
self.preVideoAdEnable = NO;
return nil;
}

- (_Bool)isTryWatch {
return NO;

}

- (_Bool)isVipUser {
%orig;

return YES;
}
- (double)getCurrentTime {
%orig;
return 0;
}



%end










