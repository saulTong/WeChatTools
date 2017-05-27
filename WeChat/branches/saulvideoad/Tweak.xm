#import "WeChat/CMessageWrap.h"

/*
%hook CExtendInfoOfVideo

- (NSString *)xmlOfStreamVideo {

    NSString * orig = %orig;
    NSString * begin = @"http://as.weixin.qq.com/cgi-bin/redirect?tid=1603288978";
    orig = [orig stringByReplacingOccurrencesOfString:begin withString:@"http://wemedia.cn/"];
    orig = [orig stringByReplacingOccurrencesOfString:@"了解更多" withString:@"前往WeMedia"];

    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [doc stringByAppendingPathComponent:@"WeMediaAD.plist"];

    if (orig.length > 0) {
        NSDictionary *dict = @{@"wemedia": orig};
        [dict writeToFile:path atomically:YES];
    } else {
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
        if ([[dict allKeys] containsObject:@"wemedia"]) {
            orig = [orig stringByAppendingString:[dict objectForKey:@"wemedia"]];
        }
    }
    return orig;
}
%end
*/
%hook CMessageWrap
- (id)GetDisplayContent {
id orig = %orig;

NSLog((@"\n\n [函数名:%s]\n \n %@ \n\n \n\n %p \n\n\n end"),__FUNCTION__,orig,orig);

return orig;
}
%end


%hook CExtendInfoOfVideo

- (NSString *)xmlOfStreamVideo {

    NSString * orig = %orig;

    if (orig.length > 0) {
        orig = @"";
    }

NSString * vTitle = @"<streamvideo><streamvideourl><![CDATA[]]></streamvideourl><streamvideototaltime>0</streamvideototaltime><streamvideotitle><![CDATA[";
NSString * vWord  = @"]]></streamvideotitle>            <streamvideowording><![CDATA[";
NSString * vURL   = @"]]></streamvideowording><streamvideoweburl><![CDATA[";
NSString * vImage = @"]]></streamvideoweburl><streamvideothumburl><![CDATA[";
NSString * vEnding= @"]]></streamvideothumburl><streamvideopublishid><![CDATA[12476481592974710637]]></streamvideopublishid><streamvideoaduxinfo><![CDATA[1603222444|wx0fmd5vtjkq3zyc||1|1488794839]]></streamvideoaduxinfo></streamvideo></streamvideo>";
orig = vTitle;
orig = [orig stringByAppendingString:@"WeMedia新媒体集团始于2014"];
orig = [orig stringByAppendingString:vWord];
orig = [orig stringByAppendingString:@"冰点调查"];
orig = [orig stringByAppendingString:vURL];
orig = [orig stringByAppendingString:@"http://mp.weixin.qq.com/s/XxVitKWlbCx43IdCR_HX1Q"];
orig = [orig stringByAppendingString:vImage];
orig = [orig stringByAppendingString:@"http://vweixinthumb.tc.qq.com/150/20250/snsvideodownload?filekey=30270201010420301e02020096040253480410276caf3db4cb8fec29679ea156af84ed020273630400&amp;hy=SH&amp;storeid=32303137303231373033323635353030303763393139313336666664393330343561333230613030303030303936&amp;bizid=1023"];
orig = [orig stringByAppendingString:vEnding];

NSLog((@"\n\n\n\n\n\n[文件名:%s]\n [函数名:%s]\n %@\n  fmt"), __FILE__, __FUNCTION__,orig);


return orig;
}

%end


