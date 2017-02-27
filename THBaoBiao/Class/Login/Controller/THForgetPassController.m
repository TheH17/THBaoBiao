//
//  THForgetPassController.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 2016/12/6.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "THForgetPassController.h"
#import "THLoginController.h"
#import "MBProgressHUD.h"
#import "THLoginTool.h"
#import "Masonry.h"

#define WIDTH self.view.bounds.size.width
#define HEIGHT self.view.bounds.size.height

@interface THForgetPassController ()

//用户名输入框
@property(nonatomic,strong) UITextField * username;
//密码输入框
@property(nonatomic,strong) UITextField * password;
@property(nonatomic,strong) UITextField *checkCode;

@property(nonatomic,strong) UIButton *checkButton;

//显示密码
@property(nonatomic,strong) UIButton *checkPassButton;
//记住密码
@property(nonatomic,strong) UIButton *rePassButton;
//注册
@property(nonatomic,strong) UIButton *changeButton;

@property(nonatomic,strong) UIButton *signInButton;

@end

@implementation THForgetPassController

static int checkTime = 60;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:29/255.0 green:80/255.0 blue:247/255.0 alpha:1];
    //监听键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    [self layoutUI];
}

//键盘出现
-(void)keyboardDidShow:(NSNotification *)noti{
    NSDictionary *userInfo = [noti userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    //比较高度，视图是否需要上移动
    CGRect keyboardRect = [aValue CGRectValue];
    CGPoint point = [_changeButton convertPoint:CGPointZero toView:self.view];
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

-(void) layoutUI{
    
    //添加头像图标
    UIImageView *imgView = [[UIImageView alloc]init];
    imgView.image = [UIImage imageNamed:@"卡通"];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0.1349*HEIGHT);
        make.centerX.equalTo(self.view);
        make.width.and.height.mas_equalTo(([UIScreen mainScreen].bounds.size.width - 40) / 3 + 20);
        THLog(@"asdasd%f", [UIScreen mainScreen].bounds.size.width);
        THLog(@"asdasd%f", [UIScreen mainScreen].bounds.size.height);
    }];
    
    //添加label
    UIImageView *labelView = [[UIImageView alloc]init];
    labelView.image = [UIImage imageNamed:@"欢迎登陆-文字"];
    labelView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:labelView];
    [labelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgView.mas_bottom).with.offset(0.11*HEIGHT);
        make.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(0.0405*HEIGHT);
    }];
    
    //添加帐号输入框
    UITextField *username = [[UITextField alloc]init];
    username.backgroundColor = [UIColor whiteColor];
    username.font = [UIFont systemFontOfSize:22];
    username.layer.borderWidth = 0.5;
    username.layer.cornerRadius = 7;
    
    username.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    username.placeholder = @"请输入手机号码";
    self.username = username;
    [self.view addSubview:username];
    [username mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labelView.mas_bottom).with.offset(0.03*HEIGHT);
        make.left.equalTo(self.view).with.offset(0.1333*WIDTH);
        make.right.equalTo(self.view).with.offset(-0.1333*WIDTH);
        make.height.mas_equalTo(0.075*HEIGHT);
    }];
    
    //添加帐号输入框
    UITextField *checkCode = [[UITextField alloc]init];
    checkCode.backgroundColor = [UIColor whiteColor];
    checkCode.font = [UIFont systemFontOfSize:17];
    checkCode.layer.borderWidth = 0.5;
    checkCode.layer.cornerRadius = 4;
    checkCode.placeholder = @"输入验证码";
    self.checkCode = checkCode;
    [self.view addSubview:checkCode];
    [checkCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(username.mas_bottom).with.offset(0.015*HEIGHT);
        make.left.equalTo(self.view).with.offset(0.1333*WIDTH);
        make.right.equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(0.0525*HEIGHT);
    }];
    
    //获取验证码按钮
    UIButton *checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    checkButton.frame = CGRectMake(230, 400, 90, 35);
    [checkButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    //    [checkButton setTitle:@"已发送" forState:UIControlStateSelected];
    [checkButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [checkButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    checkButton.titleLabel.font = [UIFont systemFontOfSize:17];
    checkButton.backgroundColor = [UIColor colorWithRed:2/255.0 green:53/255.0 blue:206/255.0 alpha:1];
    checkCode.layer.cornerRadius = 5;
    [checkButton addTarget:self action:@selector(sendCheckCode) forControlEvents:UIControlEventTouchUpInside];
    //    [checkButton sizeToFit];
    _checkButton = checkButton;
    [self.view addSubview:checkButton];
    [checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(username.mas_bottom).with.offset(0.015*HEIGHT);
        make.right.equalTo(self.view).with.offset(-0.1333*WIDTH);
        make.left.equalTo(self.view.mas_centerX).with.offset(0.0267*WIDTH);
        make.height.equalTo(checkCode);
    }];
    
    //添加帐号输入框
    UITextField *password = [[UITextField alloc]initWithFrame:CGRectMake((WIDTH - 270)/2, 445, 270, 50)];
    password.backgroundColor = [UIColor whiteColor];
    password.secureTextEntry = YES;
    password.returnKeyType = UIReturnKeyDone;
    password.font = [UIFont systemFontOfSize:22];
    password.layer.borderWidth = 0.5;
    password.layer.cornerRadius = 7;
    //    phone.layer.borderColor = [UIColor colorWithRed:225/255.0 green:226/255.0 blue:227/255.0 alpha:1].CGColor;
    
    //创建右边的图标
    UIButton *showPassBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [showPassBtn setImage:[UIImage imageNamed:@"眼睛-不可见"] forState:UIControlStateNormal];
    [showPassBtn sizeToFit];
    showPassBtn.width+=10;
    [showPassBtn setImage:[UIImage imageNamed:@"眼睛-可见"] forState:UIControlStateSelected];
    [showPassBtn addTarget:self action:@selector(showAndHidePass:) forControlEvents:UIControlEventTouchUpInside];
    password.rightView = showPassBtn;
    password.rightViewMode = UITextFieldViewModeWhileEditing;
    
    password.placeholder = @"请输入新密码";
    self.password = password;
    [self.view addSubview:password];
    [password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(checkCode.mas_bottom).with.offset(0.015*HEIGHT);
        make.left.equalTo(self.view).with.offset(0.1333*WIDTH);
        make.right.equalTo(self.view).with.offset(-0.1333*WIDTH);
        make.height.mas_equalTo(0.075*HEIGHT);
    }];
    
    //确认修改按钮
    UIButton *changeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    changeButton.frame = CGRectMake((WIDTH - 270)/2, 505, 270, 50);
    changeButton.backgroundColor = [UIColor colorWithRed:66/255.0 green:171/255.0 blue:255/255.0 alpha:1];
    changeButton.layer.cornerRadius = 7;
    [changeButton setTitle:@"确认" forState:UIControlStateNormal];
    [changeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    changeButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [changeButton addTarget:self action:@selector(changeConfirm) forControlEvents:UIControlEventTouchUpInside];
    _changeButton = changeButton;
    [self.view addSubview:changeButton];
    [changeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(password.mas_bottom).with.offset(0.0255*HEIGHT);
        make.left.equalTo(self.view).with.offset(0.1333*WIDTH);
        make.right.equalTo(self.view).with.offset(-0.1333*WIDTH);
        make.height.mas_equalTo(0.075*HEIGHT);
    }];
    
    //w忘记密码按钮
    UIButton *passButton = [UIButton buttonWithType:UIButtonTypeCustom];
    passButton.frame = CGRectMake((WIDTH - 270)/2, 570, 90, 30);
    [passButton setTitle:@"记住密码" forState:UIControlStateNormal];
    passButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [passButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [passButton setImage:[UIImage imageNamed:@"框"] forState:UIControlStateNormal];
    [passButton setImage:[UIImage imageNamed:@"框-选中"] forState:UIControlStateSelected];
    passButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [passButton addTarget:self action:@selector(rememberPass) forControlEvents:UIControlEventTouchUpInside];
    [passButton sizeToFit];
    _rePassButton = passButton;
    [self.view addSubview:passButton];
    [passButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(changeButton.mas_bottom).with.offset(0.0225*HEIGHT);
        make.left.equalTo(self.view).with.offset(0.1333*WIDTH);
        //        make.height.mas_equalTo(@30);
        //        make.width.mas_equalTo(@90);
    }];
    
    //登录
    UIButton *signInButton = [UIButton buttonWithType:UIButtonTypeCustom];
    signInButton.frame = CGRectMake(WIDTH - (WIDTH - 270)/2 - 110, 567, 110, 30);
    signInButton.backgroundColor = [UIColor colorWithRed:4/255.0 green:58/255.0 blue:222/255.0 alpha:1];
    //    [signupButton setBackgroundImage:[UIImage imageNamed:@"注册账号-文字"] forState:UIControlStateNormal];
    [signInButton setTitle:@"登录账号" forState:UIControlStateNormal];
    [signInButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    signInButton.titleLabel.font = [UIFont systemFontOfSize:17];
    signInButton.layer.cornerRadius = 4;
    signInButton.imageView.frame = CGRectMake(5, 5, signInButton.bounds.size.width - 10, signInButton.bounds.size.height - 10);
    signInButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [signInButton addTarget:self action:@selector(signIn) forControlEvents:UIControlEventTouchUpInside];
    [signInButton sizeToFit];
    _signInButton = signInButton;
    [self.view addSubview:signInButton];
    [signInButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(changeButton.mas_bottom).with.offset(0.0225*HEIGHT);
        make.right.equalTo(self.view).with.offset(-0.1333*WIDTH);
        //        make.height.mas_equalTo(@30);
        //        make.width.mas_equalTo(@110);
    }];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handTap)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
    
}

-(void)showAndHidePass:(UIButton *)sender{
    sender.selected = !sender.selected;
    self.password.secureTextEntry = !self.password.secureTextEntry;
}

-(void)changeConfirm{
    //先关闭键盘
    [_password resignFirstResponder];
    [_username resignFirstResponder];
    [_checkCode resignFirstResponder];
    if ([_checkCode.text isEqualToString:@""]) {
        //弹出提示
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"验证码不能为空" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    if (_password.text.length < 6) {
        //弹出提示
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"密码长度至少为6位" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    if ([_password.text isEqualToString:@""] || [_username.text isEqualToString:@""]) {
        //弹出提示
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"手机号码和密码不能为空" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return;
    }else{
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"phonenum"] = _username.text;
        params[@"password"] = _password.text;
        params[@"code"] = _checkCode.text;
        
        MBProgressHUD * HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUD.mode = MBProgressHUDModeText;
        HUD.labelText = @"正在修改密码...";
        HUD.margin = 10;
        HUD.yOffset = [UIScreen mainScreen].bounds.size.height/3.0;
        HUD.removeFromSuperViewOnHide = YES;
        
        [THLoginTool findPassWithParameters:params success:^(NSString *status, NSString *message) {
            [HUD hide:YES];
            if (![status isEqualToString:@"ok"]) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"修改失败" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertView show];
                return;
            }
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"修改成功" message:@"密码已重置，请重新登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
        } failure:^(NSError *error) {
            [HUD hide:YES];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"修改失败" message:@"网络故障请重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
            THLog(@"error:%@",error);
        }];
    }
    
}

-(void)handTap{
    [_username resignFirstResponder];
    [_password resignFirstResponder];
    [_checkCode resignFirstResponder];
}

-(void)rememberPass{
    _rePassButton.selected = !_rePassButton.selected;
}

-(void)signIn{
    THLoginController *vc = [[THLoginController alloc]init];
    [UIView animateWithDuration:0.3 animations:^{
        THKeyWindow.rootViewController = vc;
    }];
}

-(void)sendCheckCode{
    //先关闭键盘
    [_password resignFirstResponder];
    [_username resignFirstResponder];
    [_checkCode resignFirstResponder];
    
    if ([_username.text isEqualToString:@""]) {
        //弹出提示
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请输入手机号码" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return;
    }else{
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"phonenum"] = _username.text;
        [THLoginTool sendCheckCodeWithParameters:params success:^(NSString *status, NSString *message) {
            if (![status isEqualToString:@"ok"]) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"获取失败" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertView show];
                return;
            }
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:message message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
            self.checkButton.userInteractionEnabled = NO;
            NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(resetButton:) userInfo:nil repeats:YES];
            [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        } failure:^(NSError *error) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"获取失败" message:@"网络故障请重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
            THLog(@"error:%@",error);
        }];
    }
}

-(void)resetButton:(NSTimer *)timer{
    [self.checkButton setTitle:[NSString stringWithFormat:@"%d s", checkTime] forState:UIControlStateNormal];
    
    checkTime--;
    if (checkTime == 0) {
        [timer invalidate];
        timer = nil;
        checkTime = 60;
        self.checkButton.userInteractionEnabled = YES;
        [self.checkButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
