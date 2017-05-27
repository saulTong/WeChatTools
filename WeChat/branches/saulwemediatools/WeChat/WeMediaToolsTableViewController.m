//
//  WeMediaToolsTableViewController.m
//  emptyProject
//
//  Created by saulTong on 2016/11/30.
//  Copyright © 2016年 saulTong. All rights reserved.
//

#import "../SaulWeChatPublicClass.h"
#import "WeMediaToolsTableViewController.h"
#import "MMTabBarController.h"
#import "../AccountListController.h"

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

@interface WeMediaToolsTableViewController ()

@property (nonatomic, strong) UISwitch * s1;
@property (nonatomic, strong) UISwitch * s2;
@property (nonatomic, strong) UISwitch * s3;
@property (nonatomic, strong) UISwitch * s4;
@property (nonatomic, strong) UISwitch * s5;
@property (nonatomic, strong) UISwitch * s7;
@property (nonatomic, strong) UISwitch * s9;
@property (nonatomic, strong) UISwitch * s10;
@property (nonatomic, strong) UISwitch * s11;
@property (nonatomic, strong) UISwitch * s12;
@property (nonatomic, strong) UISwitch * s13;
@property (nonatomic, strong) UIView * animationView;
@property (nonatomic, strong) UIView * myview;
@property (nonatomic, strong) UITextField * textField;

@end

@implementation WeMediaToolsTableViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    if (publicClass.isTmpUser) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)executeCommand {
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    // 摇一摇
    if (publicClass.isS1On || publicClass.isS2On || publicClass.isS3On) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                     (int64_t)(1 * NSEC_PER_SEC)),
                       dispatch_get_main_queue(), ^{
                           [publicClass.tabBarViewController setSelectedIndex:2];
        });
    } else if (publicClass.isS4On || publicClass.isS5On || publicClass.isS7On ) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                     (int64_t)(1 * NSEC_PER_SEC)),
                       dispatch_get_main_queue(), ^{
                           [publicClass.tabBarViewController setSelectedIndex:1];
                       });
    } else if (publicClass.isS12On ) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                     (int64_t)(1 * NSEC_PER_SEC)),
                       dispatch_get_main_queue(), ^{
                           [publicClass.tabBarViewController setSelectedIndex:0];
                       });
    }

}

- (void)switchAction:(UISwitch *)sender
{
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    if (sender.tag != 113) {
        [publicClass buildFloatCloseButton];
    }
    publicClass.isS1On = publicClass.isS2On = publicClass.isS3On =
    publicClass.isS4On = publicClass.isS5On = publicClass.isS7On =
    publicClass.isS9On = publicClass.isS10On = publicClass.isS11On =
    publicClass.isS12On = NO;
    if (sender.tag == 101) {
        if (sender.on) {
            [self showAnimation:3];
            publicClass.floatButton.hidden = NO;
            publicClass.isS1On = YES;
        } else {
            publicClass.floatButton.hidden = YES;
            publicClass.isS1On = NO;
        }
        _s2.on = _s3.on = _s4.on = _s5.on = _s10.on = _s11.on = _s9.on = _s12.on = NO;
    } else if (sender.tag == 102) {
        if (sender.on) {
            publicClass.floatButton.hidden = NO;
            publicClass.isS2On = YES;
            [self buildInputView];
        } else {
            publicClass.floatButton.hidden = YES;
            publicClass.isS2On = NO;
        }
        _s1.on = _s3.on = _s4.on = _s5.on = _s10.on = _s11.on = _s9.on = _s12.on = NO;
    } else if (sender.tag == 103) {
        if (sender.on) {
            publicClass.floatButton.hidden = NO;
            publicClass.isS3On = YES;
            [self buildInputView];
        } else {
            publicClass.floatButton.hidden = YES;
            publicClass.isS3On = NO;
        }
        _s2.on = _s1.on = _s4.on = _s5.on = _s10.on = _s11.on = _s9.on = _s12.on = NO;
    } else if (sender.tag == 104) {
        if (sender.on) {
            [self showAnimation:3];
            publicClass.floatButton.hidden = NO;
            publicClass.isS4On = YES;
        } else {
            publicClass.floatButton.hidden = YES;
            publicClass.isS4On = NO;
        }
        _s2.on = _s3.on = _s1.on = _s5.on = _s10.on = _s11.on = _s9.on = _s12.on = NO;
    } else if (sender.tag == 105) {
        if (sender.on) {
            [self showAnimation:3];
            [self getRemoveSingleFriendData];
            publicClass.floatButton.hidden = NO;
            publicClass.isS5On = YES;
        } else {
            publicClass.floatButton.hidden = YES;
            publicClass.isS5On = NO;
        }
        _s2.on = _s3.on = _s4.on = _s1.on = _s10.on = _s11.on = _s9.on = _s12.on = NO;
    } else if (sender.tag == 107) {
            if (sender.on) {
                [self showAnimation:3];
                [self getRemoveSingleFriendData];
                publicClass.floatButton.hidden = NO;
                publicClass.isS7On = YES;
            } else {
                publicClass.floatButton.hidden = YES;
                publicClass.isS7On = NO;
            }
            _s2.on = _s3.on = _s4.on = _s1.on = _s5.on = _s10.on = _s11.on = _s9.on = _s12.on = NO;
        
    } else if (sender.tag == 109) {
        if (sender.on) {
            [self showAnimation:0];
            publicClass.floatButton.hidden = NO;
            publicClass.isS9On = YES;
        } else {
            publicClass.floatButton.hidden = YES;
            publicClass.isS9On = NO;
        }
        _s2.on = _s3.on = _s4.on = _s1.on = _s5.on = _s10.on = _s11.on = _s12.on = NO;
    } else if (sender.tag == 110) {
        if (sender.on) {
            [self showAnimation:0];
            publicClass.floatButton.hidden = NO;
            publicClass.isS10On = YES;
        } else {
            publicClass.floatButton.hidden = YES;
            publicClass.isS10On = NO;
        }
        _s2.on = _s3.on = _s4.on = _s1.on = _s5.on = _s9.on = _s11.on = _s12.on = NO;
    } else if (sender.tag == 111) {
        if (sender.on) {
            [self showAnimation:0];
            publicClass.floatButton.hidden = NO;
            publicClass.isS11On = YES;
        } else {
            publicClass.floatButton.hidden = YES;
            publicClass.isS11On = NO;
        }
        _s2.on = _s3.on = _s4.on = _s1.on = _s5.on = _s9.on = _s10.on = _s12.on = NO;
    } else if (sender.tag == 112) {
        if (sender.on) {
            [self creatViewView];
            publicClass.floatButton.hidden = NO;
            publicClass.isS12On = YES;
        } else {
            publicClass.floatButton.hidden = YES;
            publicClass.isS12On = NO;
        }
        _s2.on = _s3.on = _s4.on = _s1.on = _s5.on = _s9.on = _s10.on = _s11.on = NO;
    } else if (sender.tag == 113) {
        if (sender.on) {
            [self creatLocationView];
            publicClass.isS13On = YES;
        } else {
            publicClass.isS13On = NO;
        }
        _s2.on = _s3.on = _s4.on = _s1.on = _s5.on = _s9.on = _s10.on = _s11.on = NO;
    }

}

- (void)showAnimation:(int)count {
    if (count <= 0){
        [self.navigationController popViewControllerAnimated:YES];
        [self executeCommand];
        return;
    }
    if (!_animationView) {
        _animationView = [[UIView alloc] init];
        _animationView.frame = CGRectMake(0, -64, self.view.frame.size.width, self.view.frame.size.height);
        _animationView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        [self.view addSubview:_animationView];
    }
    
    UILabel * _animationLabel = [[UILabel alloc] initWithFrame:_animationView.frame];
    _animationLabel.textAlignment = NSTextAlignmentCenter;
    _animationLabel.textColor = [UIColor redColor];
    _animationLabel.font = [UIFont boldSystemFontOfSize:220];
    _animationLabel.backgroundColor = [UIColor clearColor];
    _animationLabel.text = [NSString stringWithFormat:@"%d",count];
    [_animationView addSubview:_animationLabel];
    [UIView animateWithDuration:1
                          delay:0
                        options:2
                     animations:^{
                         _animationLabel.alpha = 0;
                         _animationLabel.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.5, 0.5);
                     }
                     completion:^(BOOL finished) {
                         [_animationLabel removeFromSuperview];
                         [self showAnimation:count -1];
                     }
     ];
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WeMediaTools"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    NSString * imageName ;
    NSString * titleString;
    if (indexPath.section == 0) {
        if (!_s1) {
            _s1 = [self creatSwitch];
            _s1.tag = 101;
        }
        _s1.on = publicClass.isS1On;
        [cell.contentView addSubview:_s1];
        imageName = @"ff_IconShake";
        titleString = @"摇一摇";
    }
    if (indexPath.section == 1) {
        if (!_s2) {
            _s2 = [self creatSwitch];
            _s2.tag = 102;
        }
        _s2.on = publicClass.isS2On;
        [cell.contentView addSubview:_s2];
        imageName = @"ff_IconShake";
        titleString = @"摇一摇并打招呼";
    }
    if (indexPath.section == 2) {
        if (!_s3) {
            _s3 = [self creatSwitch];
            _s3.tag = 103;
        }
        _s3.on = publicClass.isS3On;
        [cell.contentView addSubview:_s3];
        imageName = @"ff_IconLocationService";
        titleString = @"附近人";

    }
    if (indexPath.section == 3) {
        if (!_s4) {
            _s4 = [self creatSwitch];
            _s4.tag = 104;
        }
        _s4.on = publicClass.isS4On;
        [cell.contentView addSubview:_s4];
        imageName = @"Expression_53";
        titleString = @"通过好友请求";

    }
    if (indexPath.section == 4) {
        if (!_s5) {
            _s5 = [self creatSwitch];
            _s5.tag = 105;
        }
        _s5.on = publicClass.isS5On;
        [cell.contentView addSubview:_s5];
        imageName = @"Expression_52";
        titleString = @"移除单项好友";
    }
    if (indexPath.section == 5) {
        imageName = @"Expression_33";
        titleString = @"切换账号";
    }
    if (indexPath.section == 6) {
        if (!_s7) {
            _s7 = [self creatSwitch];
            _s7.tag = 107;
        }
        _s7.on = publicClass.isS7On;
        [cell.contentView addSubview:_s7];
        imageName = @"Expression_55";
        titleString = @"群内好友申请";
    }
    if (indexPath.section == 7) {
        imageName = @"Expression_56";
        titleString = @"制作小视频";
    }
    if (indexPath.section == 8) {
        if (!_s9) {
            _s9 = [self creatSwitch];
            _s9.tag = 109;
        }
        _s9.on = publicClass.isS9On;
        [cell.contentView addSubview:_s9];
        imageName = @"Expression_57";
        titleString = @"分享-好友";
    }
    if (indexPath.section == 9) {
        if (!_s10) {
            _s10 = [self creatSwitch];
            _s10.tag = 110;
        }
        _s10.on = publicClass.isS10On;
        [cell.contentView addSubview:_s10];

        imageName = @"Expression_58";
        titleString = @"分享-群组";
    }
    if (indexPath.section == 10) {
        if (!_s11) {
            _s11 = [self creatSwitch];
            _s11.tag = 111;
        }
        _s11.on = publicClass.isS11On;
        [cell.contentView addSubview:_s11];
        imageName = @"Expression_59";
        titleString = @"群发分组";
    }
    if (indexPath.section == 11) {
        if (!_s12) {
            _s12 = [self creatSwitch];
            _s12.tag = 112;
        }
        _s12.on = publicClass.isS12On;
        [cell.contentView addSubview:_s12];
        imageName = @"Expression_60";
        titleString = @"群内回复";
    }
    if (indexPath.section == 12) {
        if (!_s13) {
            _s13 = [self creatSwitch];
            _s13.tag = 113;
        }
        _s13.on = publicClass.isS13On;
        [cell.contentView addSubview:_s13];
        imageName = @"Expression_61";
        titleString = @"修改地址";
    }
    

    cell.imageView.image = [UIImage imageNamed:imageName];
    cell.textLabel.text = titleString;

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 5) {
        SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
        publicClass.isTmpUser = YES;
        AccountListController * alc = [[AccountListController alloc] init];
        UINavigationController * unc = [[UINavigationController alloc] initWithRootViewController:alc];
        [self presentViewController:unc animated:YES completion:^{}];
    }
    if (indexPath.section == 7) {
        [self buildVideoView];
    }

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 13;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 20.f;
    }
    return 10.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.f;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CLOSED_TOOLS_NOTIFICATION" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"saulTong";
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeToolsClicked:) name:@"CLOSED_TOOLS_NOTIFICATION" object:nil];
}

- (void)closeToolsClicked:(NSNotificationCenter *)sender {
    [self.tableView reloadData];
}


- (UISwitch *)creatSwitch
{
    UISwitch *switchButton = [[UISwitch alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 60, 5, 20, 10)];
    [switchButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    return switchButton;
}

- (void)buildInputView
{
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    if (!_myview) {
        _myview = [[UIView alloc] init];
        _myview.frame = CGRectMake(self.view.center.x - 150, 150, 300, publicClass.isS3On ? 180 : 110);
        _myview.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [_myview.layer setMasksToBounds:YES];
        [_myview.layer setCornerRadius:10.0];
        _myview.userInteractionEnabled = YES;
        [self.view addSubview:_myview];

        _textField = [[UITextField alloc] init];
        _textField.frame = CGRectMake(15, 15, 270, 40);
        [_textField.layer setMasksToBounds:YES];
        [_textField.layer setCornerRadius:10.0];
        _textField.placeholder = @"打招呼要说的内容!";
        _textField.backgroundColor = RGBA(248,248,255,1);
        [_myview addSubview:_textField];
        
        if (publicClass.isS3On) {
            
            for (int i = 0; i < 3; i++) {
                UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
                [button setFrame:CGRectMake(30 + (i * 90), 70, 60, 60)];
                [button setBackgroundColor:RGBA(176,224,230,1)];
                if (i == 0) {
                    [button setBackgroundColor:[UIColor redColor]];
                    [button setTitle:@"女生" forState:UIControlStateNormal];
                } else if (i == 1) {
                    [button setTitle:@"男生" forState:UIControlStateNormal];
                } else {
                    [button setTitle:@"全部" forState:UIControlStateNormal];
                }
                [button.layer setMasksToBounds:YES];
                [button.layer setCornerRadius:30.0];
                [button addTarget:self action:@selector(pressTypeButton:)forControlEvents:UIControlEventTouchUpInside];
                [_myview addSubview:button];
                button.tag = 111+i;
            }
        }
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(170, publicClass.isS3On ? 140 : 70, 100, 35)];
        [button setBackgroundColor:RGBA(176,224,230,1)];
        [button.layer setMasksToBounds:YES];
        [button.layer setCornerRadius:10.0];
        [button setTitle:@"done" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
        [_myview addSubview:button];
        
        UIButton * cancle = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancle setFrame:CGRectMake(30, publicClass.isS3On ? 140 : 70, 100, 35)];
        [cancle setBackgroundColor:RGBA(176,224,230,1)];
        [cancle.layer setMasksToBounds:YES];
        [cancle.layer setCornerRadius:10.0];
        [cancle setTitle:@"cancel" forState:UIControlStateNormal];
        [cancle addTarget:self action:@selector(pressButtoncancle:) forControlEvents:UIControlEventTouchUpInside];
        [_myview addSubview:cancle];
    }
}

- (void)pressTypeButton:(UIButton *)sender {
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    publicClass.nearbyType = sender.tag - 111;
    publicClass.tmpNearByUserNum = 0;
    UIButton * btn1 = (UIButton *)[self.view viewWithTag:111];
    UIButton * btn2 = (UIButton *)[self.view viewWithTag:112];
    UIButton * btn3 = (UIButton *)[self.view viewWithTag:113];
    if (sender.tag == 111) {
        [btn1 setBackgroundColor:[UIColor redColor]];
        [btn2 setBackgroundColor:RGBA(176,224,230,1)];
        [btn3 setBackgroundColor:RGBA (176,224,230,1)];
    } else if (sender.tag == 112) {
        [btn2 setBackgroundColor:[UIColor redColor]];
        [btn1 setBackgroundColor:RGBA(176,224,230,1)];
        [btn3 setBackgroundColor:RGBA(176,224,230,1)];
    } else if (sender.tag == 113) {
        [btn3 setBackgroundColor:[UIColor redColor]];
        [btn2 setBackgroundColor:RGBA(176,224,230,1)];
        [btn1 setBackgroundColor:RGBA(176,224,230,1)];
    }
}

- (void)pressButtoncancle:(UIButton *)sender{
    [_myview removeFromSuperview];
    _myview = nil;
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    if (publicClass.isS2On) {
        publicClass.floatButton.hidden = YES;
        _s2.on = publicClass.isS2On = NO;
    } else if (publicClass.isS3On) {
        publicClass.floatButton.hidden = YES;
        _s3.on = publicClass.isS3On = NO;
    }
}

- (void)pressButton:(UIButton *)sender
{
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    publicClass.sayHelloString = _textField.text;
    //NSLog(@"\n\n\n\n %@ _ %@",_textField.text,publicClass.sayHelloString);
    [_myview removeFromSuperview];
    _myview = nil;
    [self showAnimation:3];
}

- (void)getRemoveSingleFriendData {
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString * path = [paths objectAtIndex:0];
    NSString * filename = [path stringByAppendingPathComponent:@"removeFriendNumberList.plist"];
    NSDictionary * dic2 = [NSDictionary dictionaryWithContentsOfFile:filename];
    if (dic2) {
        if ([dic2 objectForKey:publicClass.removeFriendNumberKey]) {
            publicClass.dataNumber = [[dic2 objectForKey:publicClass.removeFriendNumberKey] integerValue];
        } else {
            publicClass.dataNumber = 0;
        }
    } else {
        publicClass.dataNumber = 0;
    }
    //NSLog(@"\n\n\n\n\n\n\n\n\n\n\n %lld",(long long)publicClass.dataNumber);
}


- (void)buildVideoView
{
    if (!_myview) {
        _myview = [[UIView alloc] init];
        _myview.frame = CGRectMake(10, 150, self.view.frame.size.width - 20, 120);
        _myview.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        [_myview.layer setMasksToBounds:YES];
        [_myview.layer setCornerRadius:10.0];
        _myview.userInteractionEnabled = YES;
        [self.view addSubview:_myview];
        
        _textField = [[UITextField alloc] init];
        _textField.frame = CGRectMake(5, 15, _myview.frame.size.width - 10, 45);
        [_textField.layer setCornerRadius:10.0];
        _textField.backgroundColor = [UIColor whiteColor];
        [_myview addSubview:_textField];
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(_textField.frame.size.width - 120, 75, 100, 35)];
        [button setBackgroundColor:[UIColor redColor]];
        [button.layer setMasksToBounds:YES];
        [button.layer setCornerRadius:10.0];
        [button setTitle:@"done" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(pressButtonVideo:) forControlEvents:UIControlEventTouchUpInside];
        [_myview addSubview:button];
        
        UIButton * cancle = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancle setFrame:CGRectMake(20, 75, 100, 35)];
        [cancle setBackgroundColor:[UIColor redColor]];
        [cancle.layer setMasksToBounds:YES];
        [cancle.layer setCornerRadius:10.0];
        [cancle setTitle:@"cancel" forState:UIControlStateNormal];
        [cancle addTarget:self action:@selector(pressButtonVideocancle:) forControlEvents:UIControlEventTouchUpInside];
        [_myview addSubview:cancle];
        
    }
}

- (void)pressButtonVideocancle:(UIButton *)sender {
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    publicClass.videoString = nil;
    _textField.text = nil;
    [_myview removeFromSuperview];
    _myview = nil;
    
}

- (void)pressButtonVideo:(UIButton *)sender {
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    publicClass.videoString = _textField.text;
    [_myview removeFromSuperview];
    _myview = nil;
}

- (void)creatViewView {
    UIView * view = [[UIView alloc] init];
    view.tag = 10086;
    view.frame = CGRectMake(0, 0, 300, 100);
    view.center = self.view.center;
    view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:view];
    UIButton * lBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [lBtn setTitle:@"取消" forState:UIControlStateNormal];
    lBtn.frame = CGRectMake(0, 60, 150, 40);
    [lBtn addTarget:self action:@selector(leftButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:lBtn];
    UIButton * rBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rBtn setTitle:@"确定" forState:UIControlStateNormal];
    rBtn.frame = CGRectMake(150, 60, 150, 40);
    [rBtn addTarget:self action:@selector(rightButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:rBtn];
    UITextField * textField = [[UITextField alloc] init];
    textField.tag = 10010;
    textField.frame = CGRectMake(15, 10, 270, 30);
    textField.keyboardType = UIKeyboardTypeNumberPad;
    textField.textAlignment = NSTextAlignmentCenter;
    textField.font = [UIFont systemFontOfSize:22];
    textField.backgroundColor = [UIColor lightTextColor];
    textField.placeholder = @"先打开一个单人的聊天页面";
    [view addSubview:textField];
}

- (void)creatLocationView {
    UIView * view = [[UIView alloc] init];
    view.tag = 10087;
    view.frame = CGRectMake(0, 0, 300, 100);
    view.center = self.view.center;
    view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:view];
    UIButton * lBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [lBtn setTitle:@"取消" forState:UIControlStateNormal];
    lBtn.frame = CGRectMake(0, 60, 150, 40);
    [lBtn addTarget:self action:@selector(leftButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:lBtn];
    UIButton * rBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rBtn setTitle:@"确定" forState:UIControlStateNormal];
    rBtn.frame = CGRectMake(150, 60, 150, 40);
    [rBtn addTarget:self action:@selector(rightLoButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:rBtn];
    UITextField * textField = [[UITextField alloc] init];
    textField.tag = 10011;
    textField.frame = CGRectMake(15, 10, 270, 30);
    textField.textAlignment = NSTextAlignmentCenter;
    textField.font = [UIFont systemFontOfSize:22];
    textField.backgroundColor = [UIColor lightTextColor];
    textField.placeholder = @"输入经纬度以,分割";
    [view addSubview:textField];
}

- (void)rightButtonClicked:(UIButton *)sender {
    UITextField * t = [self.view viewWithTag:10010];
    if (t.text.length > 0) {
        SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
        if (publicClass.logicController) {
            NSString * textFieldText = t.text;
            publicClass.senMessageCount = [textFieldText integerValue];
            UIView * view = [self.view viewWithTag:10086];
            [view removeFromSuperview];
            [self showAnimation:0];
        } else {
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"先去打开一个一对一的聊天页面，然后在开启此功能" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
            publicClass.floatButton.hidden = YES;
            publicClass.isS12On = NO;
            _s12.on = NO;
        }
    }
}

- (void)leftLoButtonClicked:(UIButton *)sender {
    UIView * view = [self.view viewWithTag:10086];
    [view removeFromSuperview];
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    publicClass.floatButton.hidden = YES;
    publicClass.isS12On = NO;
    _s12.on = NO;
}

- (void)rightLoButtonClicked:(UIButton *)sender {
    UITextField * t = [self.view viewWithTag:10011];
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    if (t.text.length > 0) {
        NSString * textFieldText = t.text;
        if ([textFieldText rangeOfString:@","].location != NSNotFound) {
            publicClass.locationArray = [textFieldText componentsSeparatedByString:@","];
        } else if ([textFieldText rangeOfString:@"，"].location != NSNotFound){
            publicClass.locationArray = [textFieldText componentsSeparatedByString:@"，"];
        } else {
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"输入经纬度有误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
            publicClass.isS13On = NO;
            _s13.on = NO;
        }
        UIView * view = [self.view viewWithTag:10087];
        [view removeFromSuperview];
        [self showAnimation:0];
    } else {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"输入经纬度有误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        publicClass.isS13On = NO;
        _s13.on = NO;

    }
}
- (void)leftButtonClicked:(UIButton *)sender {
    UIView * view = [self.view viewWithTag:10087];
    [view removeFromSuperview];
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    publicClass.isS13On = NO;
    _s13.on = NO;
}

@end
