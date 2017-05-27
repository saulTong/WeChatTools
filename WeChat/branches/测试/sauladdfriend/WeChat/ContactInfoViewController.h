

@interface ContactInfoViewController : UIViewController

- (unsigned int)GetFromScene;
- (void)MessageReturn:(id)arg1 Event:(unsigned int)arg2;
- (void)OnSelectSession:(id)arg1 SessionSelectController:(id)arg2;
- (void)OnSelectSessionCancel:(id)arg1;
- (void)alertView:(id)arg1 clickedButtonAtIndex:(long long)arg2;
- (void)bindPhoneReturn;
- (void)confirmExpose:(unsigned int)arg1;
- (void)contactVerifyOk:(id)arg1;
- (void)copyContactField:(id)arg1 toContact:(id)arg2;
- (void)dealloc;
- (void)delAllMsg;
- (void)doReset;
- (id)getContactVerifyLogic;
- (id)getMyFriendContact;
- (id)getSearchId;
- (id)getShareMyFriendParentViewController;
- (id)getUserData;
- (id)getViewController;
- (id)init;
- (void)initSystemPluginData:(int)arg1;
- (id)initWithTitle:(id)arg1;
- (_Bool)isInMyContactList;
- (_Bool)isQQContact;
- (void)jumpToContentViewController:(id)arg1;

- (void)onAddToContact;
- (void)onDeleteContact:(id)arg1;
- (void)onExpose;
- (_Bool)onFilterSendReceiver:(id)arg1;
- (void)onFinishedShareMyFriend:(_Bool)arg1;
- (void)onFriendRequestSend;
- (void)onModifyContact:(id)arg1;
- (void)onNewMessage:(id)arg1;
- (void)onPopViewController:(_Bool)arg1;
- (void)onProfileChange;
- (void)onRemoveContact;
- (void)onSayHello;
- (void)onSayHelloViewSendSayHello:(id)arg1;
- (void)onSendVerifyMsg;
- (void)onShareMyFriend;
- (void)onStrangerContactUpdated:(id)arg1;
- (void)onTalk:(id)arg1;
- (void)onVerifyOK;
- (void)onVerifyOKWithContact:(id)arg1;
- (void)onWCGroupModMemberReturn:(_Bool)arg1 group:(id)arg2;
- (void)reloadContactAssist;
- (void)reloadData;
- (void)reloadFloatView;
- (void)reloadView;

- (void)startLoadingWithText:(id)arg1;
- (void)statBanner;
- (void)stopLoadingWithFailText:(id)arg1;
- (void)stopLoadingWithOKText:(id)arg1;
- (id)tagForActivePage;
- (void)updateContactFromServer;
- (void)viewDidDisappear:(_Bool)arg1;
- (void)viewDidLayoutSubviews;
- (void)viewDidLoad;
- (void)viewWillAppear:(_Bool)arg1;
- (void)viewWillDisappear:(_Bool)arg1;
- (void)viewWillLayoutSubviews;
@end

