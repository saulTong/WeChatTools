@interface CBaseContactInfoAssist : NSObject

- (id)init;
- (void)onAddToContacts;



- (id)GetFloatView;
- (id)GetTableView;
- (void)MessageReturn:(id)arg1 Event:(unsigned int)arg2;
- (void)addContactInternal;
- (void)contactVerifyOk:(id)arg1 opCode:(unsigned int)arg2;
- (double)getSignatureWidth;
- (id)getUserNameCol;
- (void)handleAddedContact;
- (double)heightForPluginIntroCell:(id)arg1;
- (id)init;
- (void)initLoadingView;
- (void)initNickNameLabel;
- (void)initUserNameLabel;
- (_Bool)isInMyContactList;
- (void)onVerifyContactOk;

- (void)makeContactIntroCell:(id)arg1 text:(id)arg2;
- (void)onAddToContacts;
- (void)onContactUpdated;
- (void)onContactVerifyFillVerifyMsg:(id)arg1;
- (void)opShareMyFriend;
- (void)reloadTableView;
- (void)reloadView;
- (void)stopLoading;
- (void)updateFooterView;
- (void)updateInstallStateAndReloadTableView;
- (void)updateNickNameLabel;
- (void)verifyContactWithOpCode:(unsigned int)arg1;




//
//
- (void)showAlbumList;
- (void)doDeleteContact;
- (id)getInfoDisplayName;
- (void)onAction;

@end

