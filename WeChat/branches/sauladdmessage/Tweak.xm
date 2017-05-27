#import "WeChat/WCTimeLineViewController.h"
#import "WeChat/WCNewCommitViewController.h"
#import "WeChat/MMGrowTextView.h"
#import "WeChat/MMAssetPickerController.h"

%hook MMAssetPickerController

- (void)OnSend:(id)arg1
{
%orig;
NSLog(@"\n OnSend \n %@ \nend",arg1);
}

- (void)processingImageAtIndex:(id)arg1
{
%orig;
NSLog(@"\n processingImageAtIndex \n %@ \nend",arg1);

}



%end

%hook WCNewCommitViewController

- (void)viewDidLoad {
%orig;
/*
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)),
    dispatch_get_main_queue(), ^{

        Ivar mDelegateVar = class_getInstanceVariable(objc_getClass("WCNewCommitViewController"), "_textView");
        MMGrowTextView *mDelegate = object_getIvar(self, mDelegateVar);

        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString *path = [paths objectAtIndex:0];
        NSString *filename=[path stringByAppendingPathComponent:@"oneWork.plist"];
        NSDictionary* dic = [NSDictionary dictionaryWithContentsOfFile:filename];
        if (dic) {
            NSMutableSet *sets = [NSMutableSet setWithCapacity:200];
            [sets addObjectsFromArray:[dic allKeys]];
            NSString * oneWork = [sets anyObject];
            [mDelegate insertString:[dic valueForKey:[sets anyObject]]];
            NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:dic];
            [dict removeObjectForKey:oneWork];
            [dict writeToFile:filename atomically:YES];
        } else {
            [mDelegate insertString:@"无聊ing......"];
        }

    });

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)),
    dispatch_get_main_queue(), ^{

        [self OnPostTimeline];

    });
*/
}

%end


%hook WCTimeLineViewController

- (void)viewDidLoad {
%orig;
/*
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)),
    dispatch_get_main_queue(), ^{

        [self openWriteTextViewController];

    });

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8 * NSEC_PER_SEC)),
    dispatch_get_main_queue(), ^{

        [self disMissSelf];
    });
*/
}

- (void)newYearActionSheet:(id)arg1 clickedButtonAtIndex:(long long)arg2
{
%orig;
NSLog(@"\n newYearActionSheet \n %@ - %lld \n newYearActionSheet", arg1, arg2);

}

- (void)actionSheet:(id)arg1 clickedButtonAtIndex:(long long)arg2
{
%orig;
    NSLog(@"\n actionSheet \n %@ - %lld \n actionSheet", arg1, arg2);

}

%end
/*
 *  发送文字  - (void)openWriteTextViewController

 * 拍照和照片 - (void)showImagePicker:(long long)arg1; 1是拍照
    MMAssetPickerController
 * 小视频
*/

