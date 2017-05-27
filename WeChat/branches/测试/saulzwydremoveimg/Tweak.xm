%hook WLRootHomePageViewController

- (void)viewDidLoad {
	%orig;

    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView * view = window.subviews[1];
    if ([view isKindOfClass:[UIImageView class]]) {
        [view removeFromSuperview];
    }



}

%end

