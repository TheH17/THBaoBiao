//
//  THLoginController.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/23.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "THLoginController.h"
#import "MBProgressHUD.h"

#import "THSignUpController.h"
#import "THForgetPassController.h"

#import "THLoginTool.h"
#import "THRootTool.h"

#import "Masonry.h"
#import "AppDelegate.h"

#define WIDTH self.view.bounds.size.width
#define HEIGHT self.view.bounds.size.height

@interface THLoginController ()<UITextFieldDelegate>

//用户名输入框
@property(nonatomic,strong) UITextField * username;
//密码输入框
@property(nonatomic,strong) UITextField * password;

@property(nonatomic,strong) UIButton *loginButton;

//@property(nonatomic,strong) UIButton *rePassButton;
@property(nonatomic,strong) UIButton *forgetPassButton;
@property(nonatomic,strong) UIButton *signupButton;

@end

@implementation THLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:29/255.0 green:80/255.0 blue:247/255.0 alpha:1];
    //监听键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    [self layoutUI];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    UIViewController *vc = THKeyWindow.rootViewController;
    
    THKeyWindow.rootViewController = self;
    
    [vc removeFromParentViewController];
    NSLog(@"当前的根控制器为：%@",self.view.window.rootViewController);
}

//键盘出现
-(void)keyboardDidShow:(NSNotification *)noti{
    NSDictionary *userInfo = [noti userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    //比较高度，视图是否需要上移动
    CGRect keyboardRect = [aValue CGRectValue];
    CGPoint point = [_loginButton convertPoint:CGPointZero toView:self.view];
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


-(void)layoutUI{
    //添加头像图标
    UIImageView *imgView = [[UIImageView alloc]init];
    imgView.image = [UIImage imageNamed:@"卡通"];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
//    imgView.layer.cornerRadius = imgView.frame.size.width/2.0;
    [self.view addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0.1349*HEIGHT);
        make.centerX.equalTo(self.view);
        make.width.and.height.mas_equalTo(([UIScreen mainScreen].bounds.size.width - 40) / 3 + 20);
        NSLog(@"asdasd%f", [UIScreen mainScreen].bounds.size.width);
        NSLog(@"asdasd%f", [UIScreen mainScreen].bounds.size.height);
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
    
    //添加输入框
    UITextField *phone = [[UITextField alloc]init];
    phone.backgroundColor = [UIColor whiteColor];
    phone.font = [UIFont systemFontOfSize:22];
    phone.layer.borderWidth = 0.5;
    phone.layer.cornerRadius = 7;
    phone.clearButtonMode = UITextFieldViewModeWhileEditing;
    phone.placeholder = @"请输入手机号码";
    self.username = phone;
    [self.view addSubview:phone];
    [phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labelView.mas_bottom).with.offset(0.03*HEIGHT);
        make.left.equalTo(self.view).with.offset(0.1333*WIDTH);
        make.right.equalTo(self.view).with.offset(-0.1333*WIDTH);
        make.height.mas_equalTo(0.075*HEIGHT);
    }];
    
    //添加输入框
    UITextField *password = [[UITextField alloc]init];
    password.backgroundColor = [UIColor whiteColor];
    password.secureTextEntry = YES;
    password.returnKeyType = UIReturnKeyDone;
    password.font = [UIFont systemFontOfSize:22];
    password.layer.borderWidth = 0.5;
    password.layer.cornerRadius = 7;
    password.placeholder = @"请输入登录密码";
    self.password = password;
    [self.view addSubview:password];
    [password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phone.mas_bottom).with.offset(0.015*HEIGHT);
        make.left.equalTo(self.view).with.offset(0.1333*WIDTH);
        make.right.equalTo(self.view).with.offset(-0.1333*WIDTH);
        make.height.mas_equalTo(0.075*HEIGHT);
    }];
    
    //创建右边的图标
    UIButton *showPassBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [showPassBtn setImage:[UIImage imageNamed:@"眼睛-不可见"] forState:UIControlStateNormal];
    [showPassBtn sizeToFit];
    showPassBtn.width+=10;
    [showPassBtn setImage:[UIImage imageNamed:@"眼睛-可见"] forState:UIControlStateSelected];
    [showPassBtn addTarget:self action:@selector(showAndHidePass:) forControlEvents:UIControlEventTouchUpInside];
    password.rightView = showPassBtn;
    password.rightViewMode = UITextFieldViewModeWhileEditing;
//    [showPassBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(phone.mas_bottom).with.offset(35);
//        make.right.equalTo(self.view).with.offset(-67);
//        make.height.mas_equalTo(@20);
//    }];
    
    
//    //推荐人
//    UITextField *rePhone = [[UITextField alloc]init];
//    rePhone.backgroundColor = [UIColor whiteColor];
//    rePhone.font = [UIFont systemFontOfSize:17];
//    rePhone.layer.borderWidth = 0.5;
//    rePhone.layer.cornerRadius = 4;
//    rePhone.placeholder = @"输入推荐手机号";
//    self.rePhone = rePhone;
//    [self.view addSubview:rePhone];
//    [rePhone mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(password.mas_bottom).with.offset(0.015*HEIGHT);
//        make.left.equalTo(self.view).with.offset(0.1333*WIDTH);
//        make.right.equalTo(password.mas_right).with.offset(-0.3*WIDTH);
//        make.height.mas_equalTo(0.0524*HEIGHT);
//    }];
//    
//    UIButton *reSelectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [reSelectedButton setTitle:@"推荐人" forState:UIControlStateNormal];
//    [reSelectedButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    reSelectedButton.titleLabel.font = [UIFont systemFontOfSize:17];
//    [reSelectedButton setImage:[UIImage imageNamed:@"未选择推荐人"] forState:UIControlStateNormal];
//    [reSelectedButton setImage:[UIImage imageNamed:@"选择推荐人"] forState:UIControlStateSelected];
//    [reSelectedButton addTarget:self action:@selector(reSelected) forControlEvents:UIControlEventTouchUpInside];
//    _reSelectedButton = reSelectedButton;
//    [reSelectedButton sizeToFit];
//    [self.view addSubview:reSelectedButton];
//    [reSelectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(password.mas_bottom).with.offset(0.015*HEIGHT);
////        make.left.equalTo(rePhone.mas_right).with.offset(0.0267*WIDTH);
//        make.right.equalTo(password);
////        make.height.mas_equalTo(0.0525*HEIGHT);
//    }];
    
    //登录按钮
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.backgroundColor = [UIColor colorWithRed:66/255.0 green:171/255.0 blue:255/255.0 alpha:1];
    loginButton.layer.cornerRadius = 7;
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    _loginButton = loginButton;
    [self.view addSubview:loginButton];
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(password.mas_bottom).with.offset(0.0255*HEIGHT);
        make.left.equalTo(self.view).with.offset(0.1333*WIDTH);
        make.right.equalTo(self.view).with.offset(-0.1333*WIDTH);
        make.height.mas_equalTo(0.075*HEIGHT);
    }];
    
    //w忘记密码按钮
//    UIButton *passButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [passButton setTitle:@"记住密码" forState:UIControlStateNormal];
//    passButton.titleLabel.font = [UIFont systemFontOfSize:15];
//    [passButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [passButton setImage:[UIImage imageNamed:@"框"] forState:UIControlStateNormal];
//    [passButton setImage:[UIImage imageNamed:@"框-选中"] forState:UIControlStateSelected];
//    passButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    [passButton addTarget:self action:@selector(rememberPass) forControlEvents:UIControlEventTouchUpInside];
//    [passButton sizeToFit];
//    _rePassButton = passButton;
//    [self.view addSubview:passButton];
//    [passButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(loginButton.mas_bottom).with.offset(0.0225*HEIGHT);
//        make.left.equalTo(self.view).with.offset(0.1333*WIDTH);
//    }];
    UIButton *passButton = [UIButton buttonWithType:UIButtonTypeCustom];
    passButton.backgroundColor = [UIColor colorWithRed:4/255.0 green:58/255.0 blue:222/255.0 alpha:1];
    [passButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    [passButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    passButton.titleLabel.font = [UIFont systemFontOfSize:17];
    passButton.layer.cornerRadius = 4;
    passButton.imageView.frame = CGRectMake(5, 5, passButton.bounds.size.width - 10, passButton.bounds.size.height - 10);
    passButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [passButton addTarget:self action:@selector(forgetPass) forControlEvents:UIControlEventTouchUpInside];
    [passButton sizeToFit];
    _forgetPassButton = passButton;
    [self.view addSubview:passButton];
    [passButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginButton.mas_bottom).with.offset(0.0225*HEIGHT);
        make.left.equalTo(self.view).with.offset(0.1333*WIDTH);
    }];
    
    
    //注册
    UIButton *signupButton = [UIButton buttonWithType:UIButtonTypeCustom];
    signupButton.backgroundColor = [UIColor colorWithRed:4/255.0 green:58/255.0 blue:222/255.0 alpha:1];
//    [signupButton setBackgroundImage:[UIImage imageNamed:@"注册账号-文字"] forState:UIControlStateNormal];
    [signupButton setTitle:@"注册账号" forState:UIControlStateNormal];
    [signupButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    signupButton.titleLabel.font = [UIFont systemFontOfSize:17];
    signupButton.layer.cornerRadius = 4;
    signupButton.imageView.frame = CGRectMake(5, 5, signupButton.bounds.size.width - 10, signupButton.bounds.size.height - 10);
    signupButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [signupButton addTarget:self action:@selector(signUp) forControlEvents:UIControlEventTouchUpInside];
    [signupButton sizeToFit];
    _signupButton = signupButton;
    [self.view addSubview:signupButton];
    [signupButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginButton.mas_bottom).with.offset(0.0225*HEIGHT);
        make.right.equalTo(self.view).with.offset(-0.1333*WIDTH);
//        make.height.mas_equalTo(0.045*HEIGHT);
//        make.width.mas_equalTo(0.1649*WIDTH);
    }];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handTap)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
    
}

-(void)showAndHidePass:(UIButton *)sender{
    sender.selected = !sender.selected;
    self.password.secureTextEntry = !self.password.secureTextEntry;
}

-(void)handTap{
    [_username resignFirstResponder];
    [_password resignFirstResponder];
}

-(void)signUp{
    THSignUpController *vc = [[THSignUpController alloc]init];
    [UIView animateWithDuration:0.3 animations:^{
        THKeyWindow.rootViewController = vc;
    }];
    
}

//-(void)rememberPass{
//    _rePassButton.selected = !_rePassButton.selected;
//}

-(void)forgetPass{
    THForgetPassController *vc = [[THForgetPassController alloc]init];
    [UIView animateWithDuration:0.3 animations:^{
        THKeyWindow.rootViewController = vc;
    }];
}

-(void)login{
    //先关闭键盘
    [_password resignFirstResponder];
    [_username resignFirstResponder];
    
    if ([_password.text isEqualToString:@""] || [_username.text isEqualToString:@""]) {
        //弹出提示
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"手机号码和密码不能为空" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return;
    }else{
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"phonenum"] = _username.text;
        params[@"password"] = _password.text;
        params[@"askForSites"] = @"true";
        
        MBProgressHUD * HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUD.mode = MBProgressHUDModeText;
        HUD.labelText = @"正在登录...";
        HUD.margin = 10;
        HUD.yOffset = [UIScreen mainScreen].bounds.size.height/3.0;
        HUD.removeFromSuperViewOnHide = YES;
        
        [THLoginTool loginWithParameters:params success:^(NSString *status, NSString *message) {
            [HUD hide:YES];
            if (![status isEqualToString:@"ok"]) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"登录失败" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertView show];
                return;
            }
            [self enterApp];
        } failure:^(NSError *error) {
            [HUD hide:YES];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"登录失败" message:@"网络故障请重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];NSLog(@"error:%@",error);
            return;
            
        }];
    }
}

-(void)enterApp{
    [THRootTool chooseRootColForWindow:THKeyWindow];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
