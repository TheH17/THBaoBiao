//
//  THProfileHeaderView.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/20.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "THProfileHeaderView.h"
#import "THUser.h"
#import "THUserTool.h"
#import "Masonry.h"
#import "THLoginController.h"
#import "THInfoTool.h"
#import "THWebsiteTool.h"
#import "THKeyWordTool.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface THProfileHeaderView()

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, strong) UIImageView *userImage;

@property (nonatomic, strong) THUser *user;

@property (nonatomic, copy) NSString *phonenum;

//@property (nonatomic, copy) NSString *password;

@end

@implementation THProfileHeaderView

-(THUser *)user{
    if (!_user) {
        _user = [THUserTool getUser];
    }
    return _user;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
//        _phonenum = [[NSUserDefaults standardUserDefaults] objectForKey:@"phonenum"];
//        _password = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
        [self layoutUI];
        self.backgroundColor = [UIColor colorWithRed:0/255.0 green:30/255.0 blue:176/255.0 alpha:1];
    }
    return self;
}

-(void)layoutUI{
    //1
    self.userImage = [[UIImageView alloc]init];
    //WithFrame:CGRectMake(20, (HEIGHT - 80)/2, 80, 80)
    [_userImage setImage:[UIImage imageNamed:@"个人中心-头像"]];
    _userImage.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_userImage];
    [_userImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).with.offset(0.0267*WIDTH);
        make.height.and.width.mas_equalTo(self.frame.size.height - 0.0533*WIDTH);
    }];
    
    //2
    UIImageView *vipView = [[UIImageView alloc]init];
    //WithFrame:CGRectMake(120, 35, 16, 16)
    [vipView setImage:[UIImage imageNamed:@"VIP-开通"]];
    vipView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:vipView];
    CGFloat marginY = (self.frame.size.height - 0.09*HEIGHT)/3;
    [vipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(marginY + 0.0105*HEIGHT);
        make.left.equalTo(_userImage.mas_right).with.offset(0.0267*WIDTH);
        make.height.and.width.mas_equalTo(0.024*HEIGHT);
    }];
    
    //3
    UILabel *infoLabel = [[UILabel alloc]init];
    //WithFrame:CGRectMake(120, 60, 170, 30)
    infoLabel.textColor = [UIColor colorWithRed:137/255.0 green:160/255.0 blue:255/255.0 alpha:1];
    infoLabel.textAlignment = NSTextAlignmentLeft;
    infoLabel.font = [UIFont systemFontOfSize:17];
    infoLabel.text = [NSString stringWithFormat:@"欢迎使用保标系统"];
    [infoLabel sizeToFit];
    [self addSubview:infoLabel];
    [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vipView.mas_bottom).with.offset(marginY);
        make.left.equalTo(vipView);
//        make.height.and.width.mas_equalTo(0.045*HEIGHT);
    }];
    
    //4
    UILabel *userLabel = [[UILabel alloc]init];
    //WithFrame:CGRectMake(145, 27, 150, 30)
    userLabel.textAlignment = NSTextAlignmentLeft;
    userLabel.textColor = [UIColor whiteColor];
    userLabel.font = [UIFont systemFontOfSize:20];
    [userLabel sizeToFit];
    if (self.user) {
        userLabel.text = [NSString stringWithFormat:@"%@", self.user.phonenum];
    }else{
        userLabel.text = @"未登录";
    }
    [self addSubview:userLabel];
    [userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(vipView);
        make.left.equalTo(vipView.mas_right).with.offset(0.04*WIDTH);
    }];
    
//    //5
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
////    button.frame = CGRectMake(280, 38, 80, 40);
//    button.backgroundColor = [UIColor colorWithRed:252/255.0 green:187/255.0 blue:21/255.0 alpha:1];
//    button.layer.cornerRadius = 3;
//    [button setTitle:@"注销" forState:UIControlStateNormal];
//    button.titleLabel.textAlignment = NSTextAlignmentCenter;
//    button.titleLabel.textColor = [UIColor whiteColor];
//    [button addTarget:self action:@selector(logoutBtnClick) forControlEvents:UIControlEventTouchDown];
//    [self addSubview:button];
//    [button mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self).with.offset(0.02*HEIGHT);
//        make.width.mas_equalTo(0.2133*WIDTH);
//        make.right.equalTo(self).with.offset(-0.0267*WIDTH);
//        make.height.mas_equalTo(0.06*HEIGHT);
//    }];
    
    //6
    UIButton *changInfoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    button.frame = CGRectMake(280, 38, 80, 40);
    changInfoBtn.backgroundColor = [UIColor colorWithRed:252/255.0 green:187/255.0 blue:21/255.0 alpha:1];
    changInfoBtn.layer.cornerRadius = 3;
    [changInfoBtn setTitle:@"修改" forState:UIControlStateNormal];
    changInfoBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    changInfoBtn.titleLabel.textColor = [UIColor whiteColor];
    [changInfoBtn addTarget:self action:@selector(changeInfo:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:changInfoBtn];
    [changInfoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.width.mas_equalTo(0.2133*WIDTH);
        make.right.equalTo(self).with.offset(-0.0267*WIDTH);
        make.height.mas_equalTo(0.06*HEIGHT);
    }];
}

-(void)changeInfo:(UIButton *)sender{
    if (![THUserTool getUser]) {
        [self.delegate changeInfo:sender];
        return;
    }
    if ([sender.titleLabel.text isEqualToString:@"修改"]) {
        [self.delegate changeInfo:sender];
        [sender setTitle:@"保存" forState:UIControlStateNormal];
    }else{
        [self.delegate saveInfo];
        [sender setTitle:@"修改" forState:UIControlStateNormal];
    }
}

//-(void)logoutBtnClick{
//    [THInfoTool saveInfoDataResult:nil];
//    [THUserTool saveUser:nil];
//    [THKeyWordTool saveWords:nil];
//    [THWebsiteTool saveSites:nil];
//    [UIView animateWithDuration:1.0 animations:^{
//        //登陆注册接口
//        THLoginController *loginVc = [[THLoginController alloc]init];
//        THKeyWindow.rootViewController = loginVc;
//    }];
//    
//}

@end
