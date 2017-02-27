
//
//  THAddWebSiteView.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/27.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "THAddWebSiteView.h"
#import "THaddWordAndSiteView.h"

#import "THWebsiteTool.h"
#import "THTHSiteResult.h"
#import "MBProgressHUD.h"
#import "Masonry.h"
#import "THHTTPTool.h"

//#import "THUserTool.h"
//#import "THUser.h"
//#import "THLoginController.h"

#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH [UIScreen mainScreen].bounds.size.width

@interface THAddWebSiteView()

@property (nonatomic, strong)UIButton *confirmBtn;
@property (nonatomic, strong)UITextView *urlNameTextview;
@property (nonatomic, strong)UITextField *urlTextField;
@property (nonatomic, strong)UIButton *checkBtn;
@property (nonatomic, assign) BOOL isTrue;

@end

@implementation THAddWebSiteView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.isTrue = YES;
        self.backgroundColor = [UIColor whiteColor];
        [self layoutUI];
    }
    return self;
}

-(void)layoutUI{
    //监听键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor colorWithRed:245/255.0 green:246/255.0 blue:247/255.0 alpha:1];
    [self addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(self);
        make.height.mas_equalTo(0.1199*HEIGHT);
    }];
    
    UITextField *textField = [[UITextField alloc]init];
    textField.placeholder = @"请输入网址";
    textField.backgroundColor = [UIColor whiteColor];
    textField.layer.borderColor = [UIColor colorWithRed:218/255.0 green:219/255.0 blue:220/255.0 alpha:1].CGColor;
    textField.layer.borderWidth = 1.0;
    textField.layer.cornerRadius = 10;
    textField.font = [UIFont systemFontOfSize:25];
    [headerView addSubview:textField];
    self.urlTextField = textField;
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView).with.offset(10);
        make.left.equalTo(headerView).with.offset(20);
        make.right.equalTo(headerView).with.offset(-20);
        make.bottom.equalTo(headerView).with.offset(-10);
    }];
    
    
    UIView *midView = [[UIView alloc]init];
    midView.layer.borderWidth =1.0;
    midView.layer.borderColor = [UIColor colorWithRed:220/255.0 green:219/255.0 blue:221/255.0 alpha:1].CGColor;
    [self addSubview:midView];
    [midView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_bottom);
        make.left.and.right.equalTo(self);
        make.height.equalTo(self).with.offset(-0.2399*HEIGHT);
    }];
    
    UILabel *checkLabel = [[UILabel alloc]init];
    checkLabel.text = @"请确保您的网站是否有效";
    checkLabel.textAlignment = NSTextAlignmentLeft;
    checkLabel.font = [UIFont systemFontOfSize:20];
//    [checkLabel sizeToFit];
//    checkLabel.backgroundColor = [UIColor redColor];
    checkLabel.textColor = [UIColor colorWithRed:142/255.0 green:143/255.0 blue:144/255.0 alpha:1];
    [midView addSubview:checkLabel];
    [checkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0.0375*HEIGHT);
        make.left.equalTo(midView).with.offset(0.0267*WIDTH);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(0.64*WIDTH);
    }];

//    UIButton *checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    checkBtn.backgroundColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:230/255.0 alpha:1];
//    [checkBtn setTitle:@"验证" forState:UIControlStateNormal];
//    [checkBtn setTitle:@"正在验证" forState:UIControlStateSelected];
//    [checkBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [checkBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
//    checkBtn.layer.cornerRadius = 7;
//    [checkBtn addTarget:self action:@selector(check) forControlEvents:UIControlEventTouchUpInside];
//    [midView addSubview:checkBtn];
//    _checkBtn = checkBtn;
//    [checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(checkLabel.mas_right).with.offset(0.013*WIDTH);
//        make.top.mas_equalTo(0.0375*HEIGHT);
//        make.height.mas_equalTo(0.06*HEIGHT);
//        make.right.equalTo(midView).with.offset(-0.0267*HEIGHT);
//    }];

    UILabel *infoLabel = [[UILabel alloc]init];
    infoLabel.text = @"中文注释";
    infoLabel.textAlignment = NSTextAlignmentLeft;
    infoLabel.font = [UIFont systemFontOfSize:25];
    infoLabel.textColor = [UIColor blackColor];
    [infoLabel sizeToFit];
    [midView addSubview:infoLabel];
    [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(checkLabel);
        make.top.equalTo(checkLabel.mas_bottom).with.offset(0.015*HEIGHT);
//        make.height.mas_equalTo(0.045*HEIGHT);
//        make.width.mas_equalTo(0.1574*HEIGHT);
    }];

    UILabel *infoLabel2 = [[UILabel alloc]init];
    infoLabel2.text = @"（优先显示）";
    infoLabel2.textAlignment = NSTextAlignmentLeft;
    infoLabel2.font = [UIFont systemFontOfSize:17];
    infoLabel2.textColor = [UIColor colorWithRed:142/255.0 green:143/255.0 blue:144/255.0 alpha:1];
    [infoLabel2 sizeToFit];
    [midView addSubview:infoLabel2];
    [infoLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(infoLabel.mas_right).with.offset(-0.0267*WIDTH);
        make.top.equalTo(infoLabel).with.offset(0.015*HEIGHT);
//        make.height.mas_equalTo(0.045*HEIGHT);
//        make.width.mas_equalTo(0.2249*HEIGHT);
    }];

    UITextView *textview = [[UITextView alloc] init];
    textview.layer.borderWidth = 1.0;
    textview.layer.cornerRadius = 10;
    textview.layer.borderColor = [UIColor colorWithRed:220/255.0 green:219/255.0 blue:221/255.0 alpha:1].CGColor;
    textview.backgroundColor=[UIColor whiteColor]; //背景色
    textview.scrollEnabled = YES;    //当文字超过视图的边框时是否允许滑动，默认为“YES”
    textview.editable = YES;        //是否允许编辑内容，默认为“YES”
    textview.font=[UIFont fontWithName:@"Arial" size:18.0]; //设置字体名字和字体大小;
    textview.returnKeyType = UIReturnKeyDefault;//return键的类型
    textview.keyboardType = UIKeyboardTypeDefault;//键盘类型
    textview.textAlignment = NSTextAlignmentLeft; //文本显示的位置默认为居左
    textview.dataDetectorTypes = UIDataDetectorTypeAll; //显示数据类型的连接模式（如电话号码、网址、地址等）
    textview.textColor = [UIColor blackColor];
    [midView addSubview:textview];
    self.urlNameTextview = textview;
    [textview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(midView).with.offset(0.0267*WIDTH);
        make.top.equalTo(infoLabel.mas_bottom).with.offset(0.0225*HEIGHT);
        make.right.equalTo(midView).with.offset(-0.0267*WIDTH);
        make.bottom.equalTo(midView.mas_bottom).with.offset(-0.015*HEIGHT);
    }];
    
    UIView *footerView = [[UIView alloc]init];
    footerView.backgroundColor = [UIColor whiteColor];
    [self addSubview:footerView];    
    [footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(midView.mas_bottom);
        make.left.and.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
    
    self.confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.backgroundColor = [UIColor colorWithRed:29/255.0 green:80/255.0 blue:247/255.0 alpha:1];
    [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _confirmBtn.layer.cornerRadius = 7;
    [_confirmBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:_confirmBtn];
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footerView).with.offset(0.053*WIDTH);
        make.top.equalTo(footerView).with.offset(0.015*HEIGHT);
        make.width.mas_equalTo((self.frame.size.width-0.16*WIDTH)/2);
        make.height.mas_equalTo(0.09*HEIGHT);
    }];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.backgroundColor = [UIColor colorWithRed:233/255.0 green:234/255.0 blue:235/255.0 alpha:1];
    [cancelBtn setTitle:@"返回" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancelBtn.layer.cornerRadius = 7;
    [cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_confirmBtn.mas_right).with.offset(0.053*WIDTH);
        make.top.width.and.height.equalTo(_confirmBtn);
    }];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handTap)];
    tap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tap];

}

//-(void)check{
////    self.checkBtn.selected = !self.checkBtn.selected;
//    if ([self.urlTextField.text isEqualToString:@""]) {
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入网址" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alertView show];
//        self.checkBtn.selected = !self.checkBtn.selected;
//        return;
//    }
//}

-(void)confirm{
    if ([_urlTextField.text isEqualToString:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"您还没有输入任何网站" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
    MBProgressHUD * HUD = [MBProgressHUD showHUDAddedTo:self animated:YES];
    HUD.mode = MBProgressHUDModeText;
    HUD.labelText = @"正在添加数据...";
    HUD.margin = 10;
    HUD.yOffset = [UIScreen mainScreen].bounds.size.height/3.0;
    HUD.removeFromSuperViewOnHide = YES;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"url"] = _urlTextField.text;
    params[@"sitename"] = [_urlNameTextview.text stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [THWebsiteTool sendSiteWithParameters:params success:^(NSString *status) {
        [HUD hide:YES];
        if (![status isEqualToString:@"ok"]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"添加失败请重试" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
            return;
        }
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"添加成功" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
//        THaddWordAndSiteView *fView = (THaddWordAndSiteView *)self.fatherView;
//        [fView.delegate performSelector:@selector(closeAddWordSiteView)];
        [self cancel];
        
        [self addData];
        
    } failure:^(NSError *error) {
        [HUD hide:YES];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"添加失败请重试" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return;
    }];
    [self handTap];
}

-(void)addData{
    MBProgressHUD * HUD = [MBProgressHUD showHUDAddedTo:self animated:YES];
    HUD.mode = MBProgressHUDModeText;
    HUD.labelText = @"正在更新数据...";
    HUD.margin = 10;
    HUD.yOffset = [UIScreen mainScreen].bounds.size.height/3.0;
    HUD.removeFromSuperViewOnHide = YES;
    
    [THWebsiteTool getSiteWithSuccess:^() {
        [HUD hide:YES];
        [self.delegate performSelector:@selector(successFulAddWeb)];
        
    } failure:^(NSError *error) {
        [HUD hide:YES];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"网站数据更新失败" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        THLog(@"%@", error);
    }];
    
}

-(void)cancel{
    [self.delegate performSelector:@selector(closeInputSite)];
}

-(void)handTap{
    [_urlTextField resignFirstResponder];
    [_urlNameTextview resignFirstResponder];
}

//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if (buttonIndex == 0) {
//        [alertView removeFromSuperview];
//    }else{
//        
//        [alertView removeFromSuperview];
//        THLoginController *vc = [[THLoginController alloc]init];
//        [UIView animateWithDuration:0.3 animations:^{
//            THKeyWindow.rootViewController = vc;
//        }];
//    }
//}

//键盘出现
-(void)keyboardDidShow:(NSNotification *)noti{
    NSDictionary *userInfo = [noti userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    //比较高度，视图是否需要上移动
    CGRect keyboardRect = [aValue CGRectValue];
    CGPoint point = [_confirmBtn convertPoint:CGPointZero toView:self.fatherView];
    if ([UIScreen mainScreen].bounds.size.height-keyboardRect.size.height<point.y+50) {
        //键盘遮挡住了输入框
        [UIView animateWithDuration:0.3 animations:^{
            //
            CGRect rect = self.fatherView.bounds;
            rect.origin.y = -[UIScreen mainScreen].bounds.size.height+keyboardRect.size.height+point.y+50;
            [self.fatherView setBounds:rect];
        }];
        
    }
    
}

//键盘消失
-(void)keyboardDidHide:(NSNotification *)noti{
    //恢复
    [UIView animateWithDuration:0.3 animations:^{
        [self.fatherView setBounds:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    }];
    
}

@end
