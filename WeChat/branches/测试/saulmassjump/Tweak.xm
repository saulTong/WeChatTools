
%hook BaseMsgContentViewController
- (void)willAppear {
%orig;
%log;
}

- (void)viewWillAppear:(_Bool)arg1 {
%orig;
%log;
}

- (void)willDismissAndShow {
%orig;
%log;
}

- (void)willShow {
%orig;
%log;
}

- (void)willEnterRoom {
%orig;
%log;
}

- (void)viewDidAppear:(_Bool)arg1 {
%orig;
%log;
}

%end
