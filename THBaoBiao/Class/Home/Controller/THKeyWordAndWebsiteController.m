//
//  THKeyWordAndWebsiteController.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/27.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "THKeyWordAndWebsiteController.h"

#import "THCustomBtn.h"
#import "THOldWorldSiteController.h"
#import "THaddWordAndSiteView.h"
#import "MBProgressHUD.h"
#import "Masonry.h"
#import "THUserTool.h"
#import "THUser.h"

#import "THKeyWordResult.h"
#import "THTHSiteResult.h"
#import "THKeyWordTool.h"
#import "THWebsiteTool.h"
#import "THRootTool.h"

#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH [UIScreen mainScreen].bounds.size.width

@interface THKeyWordAndWebsiteController ()<THaddWordSiteDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) NSArray *dataList;

@property (nonatomic, strong) THaddWordAndSiteView *addView;

@end

@implementation THKeyWordAndWebsiteController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:237/255.0 green:236/255.0 blue:235/255.0 alpha:1];
    [self.navigationController setTitle:@"保标"];
    self.title = @"保标";
    self.automaticallyAdjustsScrollViewInsets = NO;
}

-(void)setType:(int)type{
    _type = type;
    [self initDatas];
}

-(void)initDatas{
    THUser *user = [THUserTool getUser];
    if (user) {
        _dataList = (_type == 0) ? [user.keywordArray mutableCopy] : [user.sites mutableCopy];
    }else{
        _dataList = (_type == 0) ? [[THKeyWordTool getWords].words mutableCopy] : [NSArray array];
    }
    [self layoutUI];
}


-(void)layoutUI{
    THCustomBtn  *newWordBtn = [[THCustomBtn alloc]initWithIndex:1 type:_type];
    [newWordBtn addTarget:self action:@selector(newBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:newWordBtn];
    [newWordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.mas_equalTo(@90);
        make.height.mas_equalTo(0.09*HEIGHT);
    }];
    
    THCustomBtn  *oldWordBtn = [[THCustomBtn alloc]initWithIndex:2 type:_type];
    [oldWordBtn addTarget:self action:@selector(oldBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:oldWordBtn];
    
    [oldWordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(20);
        make.right.equalTo(self.view).with.offset(-20);
        make.top.equalTo(newWordBtn.mas_bottom).with.offset(15);
        make.height.mas_equalTo(0.09*HEIGHT);
    }];
    
    UILabel *countLabel = [[UILabel alloc]init];
    countLabel.font = [UIFont systemFontOfSize:20];
    countLabel.textColor = [UIColor blackColor];
    countLabel.textAlignment = NSTextAlignmentCenter;
    countLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.dataList.count];
    [oldWordBtn addSubview:countLabel];
    
    [countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(oldWordBtn.mas_top).with.offset(0.022*[UIScreen mainScreen].bounds.size.height);
        make.right.equalTo(oldWordBtn.mas_right);
        make.width.mas_equalTo(0.1067*WIDTH);
        make.height.mas_equalTo(@30);
    }];
    
    self.addView = [[THaddWordAndSiteView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height * 2, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _addView.type = _type;
    _addView.delegate = self;
    [self.view addSubview:_addView];
}

#pragma mark -代理方法用于关闭添加的view
-(void)closeAddWordSiteView{
    [UIView animateWithDuration:0.5 animations:^{
        [_addView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height * 2, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        
    } completion:^(BOOL finished) {

    }];
}

-(void)successFulAddData{
    [self initUI];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [THRootTool changeRootControllerToLogin:self];
    }else{
        [alertView removeFromSuperview];
    }
}

-(void)newBtnClick{
    if (_type == 1) {
        if(![THUserTool getUser]){
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"失败" message:@"您还没有登录无法使用此功能" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"现在去登录", nil];
            
            [alertView show];
            return;
        }
    }
    [UIView animateWithDuration:0.5 animations:^{
        [_addView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        
    } completion:^(BOOL finished) {
        
    }];
}

-(void)oldBtnClick{
    THOldWorldSiteController *vc = [[THOldWorldSiteController alloc]init];
    vc.type = _type;
    vc.col = self;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)initUI{
    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }
    [self initDatas];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
