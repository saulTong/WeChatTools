#import "AccountListController.h"
#import "WeChat/WCAccountControlData.h"
#import "WeChat/WCAccountLoginLastUserViewController.h"
#import "WeChat/WCAccountLoginLastUserViewControllerDelegate-Protocol.h"
#import "WeChat/WCAccountLoginControlLogic.h"
#import "WeChat/WCBaseTextFieldItem.h"


%hook WCAccountLoginLastUserViewController

- (void)viewDidLoad {
%orig;

    UIButton * transparentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [transparentButton setTitle:@"切换账号" forState:UIControlStateNormal];
    [transparentButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    transparentButton.titleLabel.font = [UIFont systemFontOfSize:15];
    transparentButton.titleLabel.textColor = [UIColor lightGrayColor];
    transparentButton.frame = CGRectMake(0, 0, 90, 40);
    transparentButton.center = CGPointMake(((UIViewController *)self).view.center.x, ((UIViewController *)self).view.center.y * 2 - 140);
    [transparentButton addTarget:self action:@selector(clickImage) forControlEvents:UIControlEventTouchUpInside];
    [((UIViewController *)self).view addSubview:transparentButton];
}

%new
- (void)setAccount:(AccountInfo *)ai
{
    WCBaseTextFieldItem * &m_textFieldPwdItem = MSHookIvar<WCBaseTextFieldItem *>(self, "m_textFieldPwdItem");
    [m_textFieldPwdItem setText:ai.userPwd];

    UILabel * &m_labelUserName = MSHookIvar<UILabel *>(self, "m_labelUserName");
    m_labelUserName.text = ai.userName;

    WCAccountLoginControlLogic *m_delegate = MSHookIvar<WCAccountLoginControlLogic *>(self, "m_delegate");
    [m_delegate onLastUserLoginUserName:ai.userName Pwd:ai.userPwd];
}

%new
- (void)clickImage
{
    AccountListController * alc = [[AccountListController alloc] init];
    alc.parent = self;
    UINavigationController * unc = [[UINavigationController alloc] initWithRootViewController:alc];
    [self presentViewController:unc animated:YES completion:^{
    }];
    [alc release];
    [unc release];
}

- (void)onNext
{
%orig;

    WCBaseTextFieldItem * &m_textFieldPwdItem = MSHookIvar<WCBaseTextFieldItem *>(self, "m_textFieldPwdItem");
    UILabel * &m_labelUserName = MSHookIvar<UILabel *>(self, "m_labelUserName");

    AccountInfo * ai = [[AccountInfo alloc] init];
    ai.userName = m_labelUserName.text;
    ai.userPwd = [m_textFieldPwdItem getValue];
    [AccountInfo updateAccount:ai];
    [ai release];
}

%end


%hook WCAccountLoginFirstUserViewController

- (void)onNext
{
%orig;

    WCBaseTextFieldItem * &m_textFieldUserNameItem = MSHookIvar<WCBaseTextFieldItem *>(self, "m_textFieldUserNameItem");
    WCBaseTextFieldItem * &m_textFieldPwdItem = MSHookIvar<WCBaseTextFieldItem *>(self, "m_textFieldPwdItem");

    AccountInfo * ai = [[AccountInfo alloc] init];
    ai.userName = [m_textFieldUserNameItem getValue];
    ai.userPwd = [m_textFieldPwdItem getValue];
    [AccountInfo updateAccount:ai];
    [ai release];
}

%end

