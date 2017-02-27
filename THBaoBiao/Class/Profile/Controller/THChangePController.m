//
//  THChangePController.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 2016/12/7.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "THChangePController.h"
#import "THUserTool.h"
#import "THUser.h"
#import "Masonry.h"
#import "MBProgressHUD.h"
#import "THLoginTool.h"
#import "THRootTool.h"

#define H_WIDTH [UIScreen mainScreen].bounds.size.width
#define H_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface THChangePController ()<UIAlertViewDelegate>

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UITextField *oldPass;
//@property (nonatomic, strong) UIButton *codeBtn;

@property (nonatomic, strong) UITextField *pass;

@property (nonatomic, strong) UITextField *aPass;

@property (nonatomic, strong) UIButton *confirmBtn;

@end

@implementation THChangePController

//static int checkTime = 60;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setTitle:@"修改密码"];
    self.title = @"修改密码";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //监听键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handTap)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
    
    [self layoutUI];
}

-(void)layoutUI{
    THUser *user = [THUserTool getUser];
    //0
    UIView *titleView = [[UIView alloc]init];
    titleView.backgroundColor = [UIColor colorWithRed:231/255.0 green:235/255.0 blue:237/255.0 alpha:1];
    [self.view addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(0.09*H_HEIGHT);
        make.top.mas_equalTo(90);
    }];
    //标题
    UILabel *titleLabel = [UILabel new];
    [titleView addSubview:titleLabel];
    _titleLabel = titleLabel;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textColor = [UIColor blackColor];
    NSString *username = [user.phonenum stringByReplacingCharactersInRange:NSMakeRange(3, 5) withString:@"*****"];
    titleLabel.text = [NSString stringWithFormat:@"用户：%@", username];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.top.and.bottom.equalTo(titleView);
    }];
    
    //1
    UIView *firstView = [UIView new];
    [self.view addSubview:firstView];
    firstView.backgroundColor = [UIColor whiteColor];
    [firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.width.and.height.equalTo(titleView);
        make.top.equalTo(titleView.mas_bottom);
    }];
    //验证码输入框
    UITextField *oldPass = [[UITextField alloc]init];
    [firstView addSubview:oldPass];
    _oldPass = oldPass;
    oldPass.secureTextEntry = YES;
    oldPass.backgroundColor = [UIColor whiteColor];
    oldPass.font = [UIFont systemFontOfSize:17];
    oldPass.textColor = [UIColor blackColor];
    oldPass.layer.borderWidth = 0;
    oldPass.placeholder = @"请输入旧密码";
    [oldPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(firstView);
        make.left.equalTo(firstView).with.offset(0.0267*H_WIDTH);
        make.right.equalTo(firstView.mas_centerX).with.offset(-0.0267*H_WIDTH);
    }];
    //创建右边的图标
    UIButton *showOPassBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [showOPassBtn setImage:[UIImage imageNamed:@"眼睛-不可见"] forState:UIControlStateNormal];
    [showOPassBtn sizeToFit];
    showOPassBtn.width+=10;
    [showOPassBtn setImage:[UIImage imageNamed:@"眼睛-可见"] forState:UIControlStateSelected];
    [showOPassBtn addTarget:self action:@selector(showAndHideOPass:) forControlEvents:UIControlEventTouchUpInside];
    oldPass.rightView = showOPassBtn;
    oldPass.rightViewMode = UITextFieldViewModeWhileEditing;
//    //验证码获取按钮
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [firstView addSubview:btn];
//    _codeBtn = btn;
//    [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
//    btn.backgroundColor = [UIColor colorWithRed:172/255.0 green:173/255.0 blue:174/255.0 alpha:1];
//    btn.layer.cornerRadius = 5;
//    btn.titleLabel.font = [UIFont systemFontOfSize:20];
//    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
//    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(sendCode) forControlEvents:UIControlEventTouchUpInside];
//    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(firstView).with.offset(0.015*H_HEIGHT);
//        make.bottom.equalTo(firstView).with.offset(-0.015*H_HEIGHT);
//        make.right.equalTo(firstView).with.offset(-0.0267*H_WIDTH);
//        make.left.equalTo(firstView.mas_centerX).with.offset(0.04*H_WIDTH);
//    }];
    
    //分割线
    UIView *sepView1 = [UIView new];
    [self.view addSubview:sepView1];
    sepView1.backgroundColor = [UIColor colorWithRed:222/255.0 green:224/255.0 blue:222/255.0 alpha:1];
    [sepView1 mas_makeConstraints:^(MASConstraintMaker *make) {
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
        make.top.equalTo(sepView1.mas_bottom);
    }];
    //验证码输入框
    UITextField *pass = [[UITextField alloc]init];
    [secondView addSubview:pass];
    _pass = pass;
    pass.secureTextEntry = YES;
    pass.backgroundColor = [UIColor whiteColor];
    pass.font = [UIFont systemFontOfSize:17];
    pass.textColor = [UIColor blackColor];
    pass.layer.borderWidth = 0;
    pass.placeholder = @"新密码：6-14位，建议数字，字母，符号组合";
    [pass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(secondView);
        make.left.equalTo(secondView).with.offset(0.0267*H_WIDTH);
        make.right.equalTo(secondView).with.offset(-0.0267*H_WIDTH);
    }];
    //创建右边的图标
    UIButton *showPassBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [showPassBtn setImage:[UIImage imageNamed:@"眼睛-不可见"] forState:UIControlStateNormal];
    [showPassBtn sizeToFit];
    showPassBtn.width+=10;
    [showPassBtn setImage:[UIImage imageNamed:@"眼睛-可见"] forState:UIControlStateSelected];
    [showPassBtn addTarget:self action:@selector(showAndHidePass:) forControlEvents:UIControlEventTouchUpInside];
    pass.rightView = showPassBtn;
    pass.rightViewMode = UITextFieldViewModeWhileEditing;
    
    //分割线
    UIView *sepView2 = [UIView new];
    [self.view addSubview:sepView2];
    sepView2.backgroundColor = [UIColor colorWithRed:222/255.0 green:224/255.0 blue:222/255.0 alpha:1];;
    [sepView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.and.width.equalTo(self.view);
        make.top.equalTo(secondView.mas_bottom);
        make.height.mas_equalTo(0.5);
    }];
    
    //3
    UIView *thirdView = [UIView new];
    [self.view addSubview:thirdView];
    thirdView.backgroundColor = [UIColor whiteColor];
    [thirdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.width.and.height.equalTo(secondView);
        make.top.equalTo(sepView2.mas_bottom);
    }];
    
    //验证码输入框
    UITextField *aPass = [[UITextField alloc]init];
    [thirdView addSubview:aPass];
    _aPass = aPass;
    aPass.secureTextEntry = YES;
    aPass.backgroundColor = [UIColor whiteColor];
    aPass.font = [UIFont systemFontOfSize:17];
    aPass.textColor = [UIColor blackColor];
    aPass.layer.borderWidth = 0;
    aPass.placeholder = @"新密码：请重复输入新密码";
    [aPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(thirdView);
        make.left.equalTo(thirdView).with.offset(0.0267*H_WIDTH);
        make.right.equalTo(thirdView).with.offset(-0.0267*H_WIDTH);
    }];
    //创建右边的图标
    UIButton *showAPassBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [showAPassBtn setImage:[UIImage imageNamed:@"眼睛-不可见"] forState:UIControlStateNormal];
    [showAPassBtn sizeToFit];
    showAPassBtn.width+=10;
    [showAPassBtn setImage:[UIImage imageNamed:@"眼睛-可见"] forState:UIControlStateSelected];
    [showPassBtn addTarget:self action:@selector(showAndHideAPass:) forControlEvents:UIControlEventTouchUpInside];
    aPass.rightView = showAPassBtn;
    aPass.rightViewMode = UITextFieldViewModeWhileEditing;
    
    //分割线
    UIView *sepView3 = [UIView new];
    [self.view addSubview:sepView3];
    sepView3.backgroundColor = [UIColor colorWithRed:222/255.0 green:224/255.0 blue:222/255.0 alpha:1];;
    [sepView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.and.width.equalTo(self.view);
        make.top.equalTo(thirdView.mas_bottom);
        make.height.mas_equalTo(0.5);
    }];
    
    //确认按钮
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:confirmBtn];
    _confirmBtn = confirmBtn;
    [confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    confirmBtn.backgroundColor = [UIColor colorWithRed:61/255.0 green:184/255.0 blue:23/255.0 alpha:1];
    confirmBtn.layer.cornerRadius = 3;
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:25];
    confirmBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sepView3).with.offset(0.045*H_HEIGHT);
        make.left.equalTo(self.view).with.offset(0.0267*H_WIDTH);
        make.right.equalTo(self.view).with.offset(-0.0267*H_WIDTH);
        make.height.equalTo(firstView);
    }];
    
    //帮助label
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"收不到验证码?"];
    NSRange strRange = {0,[str length]};
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:152/255.0 green:153/255.0 blue:154/255.0 alpha:1] range:strRange];  //设置颜色
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    
    UIButton *helpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:helpBtn];
    [[helpBtn titleLabel] setFont:[UIFont systemFontOfSize:17]];
    [helpBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [helpBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];      //btn左对齐
    [helpBtn setAttributedTitle:str forState:UIControlStateNormal];
    [helpBtn addTarget:self action:@selector(helpClick) forControlEvents:UIControlEventTouchUpInside];
    [helpBtn sizeToFit];
    [helpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).with.offset(-0.0267*H_WIDTH);
        make.top.equalTo(confirmBtn.mas_bottom).with.offset(0.015*H_HEIGHT);
    }];
    
}

-(void)showAndHideOPass:(UIButton *)sender{
    sender.selected = !sender.selected;
    self.oldPass.secureTextEntry = !self.oldPass.secureTextEntry;
}

-(void)showAndHidePass:(UIButton *)sender{
    sender.selected = !sender.selected;
    self.pass.secureTextEntry = !self.pass.secureTextEntry;
}

-(void)showAndHideAPass:(UIButton *)sender{
    sender.selected = !sender.selected;
    self.aPass.secureTextEntry = !self.aPass.secureTextEntry;
}

-(void)helpClick{
    THLog(@"helpforcode");
}

-(void)handTap{
    [_oldPass resignFirstResponder];
    [_pass resignFirstResponder];
    [_aPass resignFirstResponder];
}

//-(void)sendCode{
//    //先关闭键盘
//    [_oldPass resignFirstResponder];
//    [_pass resignFirstResponder];
//    [_aPass resignFirstResponder];
//    
////    if ([_codeText.text isEqualToString:@""]) {
////        //弹出提示
////        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请输入验证码" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
////        [alertView show];
////        return;
////    }else{
////        NSMutableDictionary *params = [NSMutableDictionary dictionary];
////        params[@"phonenum"] = [THUserTool getUser].phonenum;
////        [THLoginTool sendCheckCodeWithParameters:params success:^(NSString *status, NSString *message) {
////            if (![status isEqualToString:@"ok"]) {
////                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"获取失败" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
////                [alertView show];
////                return;
////            }
////            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:message message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
////            [alertView show];
////            self.codeBtn.userInteractionEnabled = NO;
//            NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(resetButton:) userInfo:nil repeats:YES];
//            [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
////        } failure:^(NSError *error) {
////            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"获取失败" message:@"网络故障请重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
////            [alertView show];
////            THLog(@"error:%@",error);
////        }];
////    }
//}

//-(void)resetButton:(NSTimer *)timer{
//    [self.codeBtn setTitle:[NSString stringWithFormat:@"重新获取(%d)", checkTime] forState:UIControlStateNormal];
//    
//    checkTime--;
//    if (checkTime == 0) {
//        [timer invalidate];
//        timer = nil;
//        checkTime = 60;
//        self.codeBtn.userInteractionEnabled = YES;
//        [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
//    }
//}

-(void)confirm{
    //先关闭键盘
    [_oldPass resignFirstResponder];
    [_pass resignFirstResponder];
    [_aPass resignFirstResponder];
    if ([_oldPass.text isEqualToString:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请输入旧密码" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    if ([_pass.text isEqualToString:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请输入新密码" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    if (_pass.text.length < 6) {
        //弹出提示
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"密码长度至少为6位" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    if (![_pass.text isEqualToString:_aPass.text]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"失败" message:@"两次输入的密码不一致，请核对后输入" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    MBProgressHUD * HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.mode = MBProgressHUDModeText;
    HUD.labelText = @"正在修改密码...";
    HUD.margin = 10;
    HUD.yOffset = [UIScreen mainScreen].bounds.size.height/3.0;
    HUD.removeFromSuperViewOnHide = YES;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"oldPassword"] = _oldPass.text;
    params[@"newPassword"] = _aPass.text;
    
    [THLoginTool changePassWithParameters:params success:^(NSString *status, NSString *message) {
        [HUD hide:YES];
        if (![status isEqualToString:@"ok"]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"修改失败" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
        }else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"修改成功" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
        }
    } failure:^(NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"修改失败" message:@"网络故障请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return;
    }];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [THUserTool saveUser:nil];
    [THRootTool changeRootControllerToLogin:self];
}

//键盘出现
-(void)keyboardDidShow:(NSNotification *)noti{
    NSDictionary *userInfo = [noti userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    //比较高度，视图是否需要上移动
    CGRect keyboardRect = [aValue CGRectValue];
    CGPoint point = [_confirmBtn convertPoint:CGPointZero toView:self.view];
    if ([UIScreen mainScreen].bounds.size.height-keyboardRect.size.height<point.y+50) {
        //键盘遮挡住了输入框
        [UIView animateWithDuration:0.3 animations:^{
            //
            CGRect rect = self.view.bounds;
            rect.origin.y = -[UIScreen mainScreen].bounds.size.height+keyboardRect.size.height+point.y+50;
            [self.view setBounds:rect];
        }];
        
    }
    
}

//键盘消失
-(void)keyboardDidHide:(NSNotification *)noti{
    //恢复
    [UIView animateWithDuration:0.3 animations:^{
        [self.view setBounds:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
