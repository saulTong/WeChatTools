#import "WeChat/MMTabBarController.h"
#import "WeChat/FindFriendEntryViewController.h"
#import "WeChat/ShakeViewController.h"


%hook ShakeViewController

- (void)viewDidLoad {
%orig;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self OnShake];
    });



    NSTimer *timer = [NSTimer timerWithTimeInterval:10 target:self selector:@selector(OnShake) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}
%end

%hook FindFriendEntryViewController

- (void)viewDidLoad {
    %orig;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)),
                                    dispatch_get_main_queue(), ^{

        NSIndexPath * indexPatch = [NSIndexPath indexPathForRow:1 inSection:1];
        [self tableView:self.view didSelectRowAtIndexPath:indexPatch];

    });

}
%end

%hook MMTabBarController

- (void)viewDidLoad {
%orig;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setSelectedIndex:2];
    });
}


%end
