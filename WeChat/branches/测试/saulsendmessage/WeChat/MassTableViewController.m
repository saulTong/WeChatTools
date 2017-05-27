//
//  MassTableViewController.m
//  emptyProject
//
//  Created by saulTong on 2017/3/15.
//  Copyright © 2017年 saulTong. All rights reserved.
//

#import "MassTableViewController.h"
#import "../SaulWeChatPublicClass.h"
@interface MassTableViewController ()
{
    SaulWeChatPublicClass * publicClass;
}
@end

@implementation MassTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    publicClass = [SaulWeChatPublicClass sharedInstance];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];

}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section != 0) {
        return 5;
    }
    return 64.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section != 0) {
        return nil;
    }
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = [UIColor blackColor];
    view.frame = CGRectMake(0, 0, self.view.frame.size.width, 64.f);
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 20, 80, 30);
    [btn setTitle:@"退出" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pressBackButton) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    
    
    
    return view;
}

- (void)pressBackButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return [publicClass totalSectionWithArray:publicClass.friendArray];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    NSString * str = [NSString stringWithFormat:@"第%ld组好友",(long)indexPath.section + 1];
    
    cell.textLabel.text = str;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self pressBackButton];

    NSString * obj = [NSString stringWithFormat:@"%ld",(long)indexPath.section];
 
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MASS_SEND_MESSAGE" object:obj];

}



@end
