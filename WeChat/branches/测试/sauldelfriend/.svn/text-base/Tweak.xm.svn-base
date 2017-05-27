#import "WeChat/SayHelloViewController.h"
#import "WeChat/SayHelloDataLogic.h"

%hook SayHelloViewController
- (void)OnClear:(id)arg1
{
%orig;

NSLog(@"del friend with \n%@",arg1);

}



%end


%hook SayHelloDataLogic
- (void)clearMsg:(unsigned long)arg1
{
%orig;

NSLog(@"clearMsg with \n%ld",arg1);

}
- (void)clearMsg:(unsigned long)arg1 ForIndex:(unsigned long)arg2
{
%orig;

NSLog(@"clearMsg with \n%ld_%ld",arg1,arg2);

}

- (void)onFriendAssistClearMsg:(id)arg1
{
%orig;

NSLog(@"onFriendAssistClearMsg with \n%@",arg1);

}

%end
