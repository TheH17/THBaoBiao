//
//  THAddKeyWordView.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/27.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "THAddKeyWordView.h"
#import "THaddWordAndSiteView.h"
#import "MBProgressHUD.h"
#import "THKeyWordTool.h"
#import "THKeyWordResult.h"
#import "THUserTool.h"
#import "THUser.h"
#import "Masonry.h"

#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH [UIScreen mainScreen].bounds.size.width

@interface THAddKeyWordView()

@property (nonatomic, strong)UIButton *confirmBtn;

@property (nonatomic, strong) UITextField *wordTextField;

@end

@implementation THAddKeyWordView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
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
    textField.placeholder = @"请输入关键字";
    textField.backgroundColor = [UIColor whiteColor];
    textField.layer.borderColor = [UIColor colorWithRed:218/255.0 green:219/255.0 blue:220/255.0 alpha:1].CGColor;
    textField.layer.borderWidth = 1.0;
    textField.layer.cornerRadius = 10;
    textField.font = [UIFont systemFontOfSize:25];
    self.wordTextField = textField;
    [headerView addSubview:textField];
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
    
    UILabel *label = [[UILabel alloc]initWithFrame:midView.bounds];
    label.numberOfLines = 2;
    label.text = @"请根据您想要了解的招标信息，添加其行业的关键词";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:20];
    label.textColor = [UIColor colorWithRed:169/255.0 green:170/255.0 blue:171/255.0 alpha:1];
    [midView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.top.equalTo(midView);
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

-(void)confirm{
    [_wordTextField resignFirstResponder];
    
    NSString *str = _wordTextField.text;
    //判断是否输入为空
    if ([str isEqualToString:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"您还没有输入任何关键词" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    if ([THUserTool getUser]) {
        [self addRemoteWord:str];
    }else{
        [self addLocalWord:str];
    }
}

-(void)addRemoteWord:(NSString *)word{
    NSMutableArray *words = [[THUserTool getUser].keywordArray mutableCopy];

    //判断关键词是否已达到上限
    if (words.count == 8) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"关键词最多为8个，您已达到上限，若要添加请删除部分关键词" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
    [words addObject:word];
    
    MBProgressHUD * HUD = [MBProgressHUD showHUDAddedTo:self animated:YES];
    HUD.mode = MBProgressHUDModeText;
    HUD.labelText = @"正在添加数据...";
    HUD.margin = 10;
    HUD.yOffset = [UIScreen mainScreen].bounds.size.height/3.0;
    HUD.removeFromSuperViewOnHide = YES;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"keyword"] = [[words componentsJoinedByString:@","] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [THKeyWordTool sendWordWithParameters:params success:^(NSString *status, NSString *message) {
        [HUD hide:YES];
        if (![status isEqualToString:@"ok"]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"添加失败" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
            
            return;
        }
        
        [THUserTool updataKeyWordsWithArray:[words mutableCopy]];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"添加成功" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        
        [self cancel];
        
        [self addData];
        
    } failure:^(NSError *error) {
        [HUD hide:YES];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"添加失败请重试" message:@"网络故障请重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return;
    }];
    [self handTap];
}

-(void)addLocalWord:(NSString *)word{
    
    THKeyWordResult *result = [THKeyWordTool getWords];
    NSMutableArray *words = [result.words mutableCopy];
    
    //判断关键词是否已达到上限
    if (words.count == 8) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"关键词最多为8个，您已达到上限，若要添加请删除部分关键词" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
    [words addObject:word];
    result.words = [words mutableCopy];
    [THKeyWordTool saveWords:result];
    [self cancel];
    [self addData];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"添加成功" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}

-(void)addData{
    [self.delegate performSelector:@selector(successFulAddWord)];
}

-(void)cancel{
    [self.delegate performSelector:@selector(closeInputWord)];
}

-(void)handTap{
    [_wordTextField resignFirstResponder];
}

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
