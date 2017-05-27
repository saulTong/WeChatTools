@interface WCAccountLoginLastUserViewController : UIViewController



- (void)WCBaseInfoItemEditChanged:(id)arg1;
- (void)adjustTableViewRect;
- (void)adjustViewAndNavBarRect;
- (id)createFooterBtn:(id)arg1 target:(id)arg2 sel:(SEL)arg3;
- (id)createHeadImgView;
- (void)createLoginBtn:(id)arg1 relateView:(id)arg2;
- (id)createPwdInputView:(id)arg1;
- (id)createVoicePrintLoginBtn:(id)arg1;
- (void)dealloc;
- (void)didReceiveMemoryWarning;
- (id)getDisplayLoginName;
- (double)getVisibleHeight;
- (void)hideKeyBoard;
- (id)init;
- (void)initChangeAccountBtnForIPad;
- (void)initHeaderView;
- (_Bool)isLastLoginAcountTypePhone;
- (void)onLastUserChangeAccountForIPad:(id)arg1;
- (void)onLastUserVoicePrintLogin;
- (void)onMore:(id)arg1;
- (void)onNext;
- (void)onSwitchPwdInput;
- (void)setDelegate:(id)arg1;
- (void)vcResignFirstResponder;
- (void)viewDidLoad;


@end

