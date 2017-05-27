

@interface SaulWeChatPublicClass : NSObject

@property (nonatomic, assign) BOOL isCheckDone;
@property (nonatomic, assign) BOOL isNotFriend;
@property (nonatomic, assign) BOOL isRemoveFriend;
@property (nonatomic, assign) int dataNumber;

+(instancetype)sharedInstance;


@end

/*

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
 [[contact getContactTalkRoomName] isEqualToString:@"我的Mr鹿"] ||
 [[contact getContactTalkRoomName] isEqualToString:@"BiaNews"] ||
 [[contact getContactTalkRoomName] isEqualToString:@"掌上北京"] ||
 [[contact getContactTalkRoomName] isEqualToString:@"WeMedia联盟"] ||
 [[contact getContactTalkRoomName] isEqualToString:@"WeMedia岩浆互动"] ||
 [[contact getContactTalkRoomName] isEqualToString:@"一句话一世界"] ||
 [[contact getContactTalkRoomName] isEqualToString:@"比比谁更贱"] ) {
 [self viewWillAppear:arg1];
 NSLog(@"\n 跳过 \n GO");
 }

 */
