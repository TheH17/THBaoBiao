//
//  THMoreInfoController.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 2016/12/6.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "THMoreInfoController.h"
#import "Masonry.h"
#import "THUserTool.h"
#import "THUser.h"
#import "THLoginTool.h"
#import "MBProgressHUD.h"
#import "THLoginController.h"
#import "THChangePController.h"
#import "THRootTool.h"

#define H_WIDTH [UIScreen mainScreen].bounds.size.width
#define H_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface THMoreInfoController ()<UIAlertViewDelegate>

@end

@implementation THMoreInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:237/255.0 green:236/255.0 blue:235/255.0 alpha:1];
    [self.navigationController setTitle:@"更多"];
    self.title = @"更多";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self layoutUI];
}

-(void)layoutUI{
    THUser *user = [THUserTool getUser];
    //1
    UIView *firstView = [[UIView alloc]init];
    firstView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:firstView];
    [firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(0.09*H_HEIGHT);
        make.top.mas_equalTo(90);
    }];
    //账号
    UILabel *accountLabel = [UILabel new];
    [firstView addSubview:accountLabel];
    accountLabel.textAlignment = NSTextAlignmentLeft;
    accountLabel.font = [UIFont systemFontOfSize:25];
    if (user.username) {
        NSString *username = [user.phonenum stringByReplacingCharactersInRange:NSMakeRange(3, 5) withString:@"*****"];
        accountLabel.text = [NSString stringWithFormat:@"账号：%@", username];
    }else{
        accountLabel.text = [NSString stringWithFormat:@"账号：%@", @"未登录"];
    }
    
    [accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.and.height.equalTo(firstView);
        make.left.equalTo(firstView).with.offset(0.0267*H_WIDTH);
        make.right.equalTo(firstView).with.offset(-0.0267*H_WIDTH);
    }];
    
    //分割线
    UIView *sepView = [UIView new];
    [self.view addSubview:sepView];
    sepView.backgroundColor = [UIColor grayColor];
    [sepView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.and.width.equalTo(self.view);
        make.top.equalTo(firstView.mas_bottom);
        make.height.mas_equalTo(0.5);
    }];
    //2
    UIView *secondView = [UIView new];
    [self.view addSubview:secondView];
    secondView.backgroundColor = [UIColor whiteColor];
    [secondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.width.and.height.equalTo(firstView);
        make.top.equalTo(sepView.mas_bottom);
    }];
    //密码
    UILabel *passLabel = [UILabel new];
    [secondView addSubview:passLabel];
    passLabel.textAlignment = NSTextAlignmentLeft;
    passLabel.font = [UIFont systemFontOfSize:25];
    passLabel.text = @"密码：********";
    [passLabel sizeToFit];
    [passLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(secondView);
        make.left.equalTo(secondView).with.offset(0.0267*H_WIDTH);
    }];
    //修改密码
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [secondView addSubview:btn];
    [btn setTitle:@"修改密码" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor colorWithRed:252/255.0 green:187/255.0 blue:21/255.0 alpha:1];
    btn.layer.cornerRadius = 3;
    btn.titleLabel.font = [UIFont systemFontOfSize:20];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(changePass) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(secondView).with.offset(0.015*H_HEIGHT);
        make.bottom.equalTo(secondView).with.offset(-0.015*H_HEIGHT);
        make.right.equalTo(secondView).with.offset(-0.0267*H_WIDTH);
        make.width.mas_equalTo(0.32*H_WIDTH);
    }];
    
    //3
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:button];
    [button setTitle:@"注销账号" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor colorWithRed:254/255.0 green:117/255.0 blue:34/255.0 alpha:1];
    button.layer.cornerRadius = 5;
    button.titleLabel.font = [UIFont systemFontOfSize:20];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(0.053*H_WIDTH);
        make.right.equalTo(self.view).with.offset(-0.053*H_WIDTH);
        make.bottom.equalTo(self.view).with.offset(-0.09*H_HEIGHT);
        make.height.mas_equalTo(0.09*H_HEIGHT);
    }];
    
}

-(void)changePass{
    THChangePController *vc = [[THChangePController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)logout{
    MBProgressHUD * HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.mode = MBProgressHUDModeText;
    HUD.labelText = @"正在注销...";
    HUD.margin = 10;
    HUD.yOffset = [UIScreen mainScreen].bounds.size.height/3.0;
    HUD.removeFromSuperViewOnHide = YES;
    [THLoginTool logoutWithSuccess:^(NSString *status, NSString *message) {
        [HUD hide:YES];
        if (![status isEqualToString:@"ok"]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"注销失败" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
            return;
        }
        [self successfulLogout];
    } failure:^(NSError *error) {
        [HUD hide:YES];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"注销失败" message:@"网络故障请重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [THRootTool changeRootControllerToLogin:self];
    }else{
        [alertView removeFromSuperview];
    }
}
-(void)successfulLogout{
    [THUserTool saveUser:nil];
    [self.delegate reInitUIWhenLogout];
    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }
    [self layoutUI];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您以注销是否前往登录界面" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"现在去登录", nil];
    
    [alertView show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
