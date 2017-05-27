



%hook MMTabBarController

- (void)viewDidLoad {
%orig;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setSelectedIndex:2];
    });
}