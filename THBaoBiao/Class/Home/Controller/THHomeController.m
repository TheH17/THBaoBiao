//
//  THHomeController.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/15.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "THHomeController.h"

#import "THScrollView.h"
#import "THHotView.h"
#import "THOptionView.h"
#import "THKeyWordAndWebsiteController.h"
#import "MBProgressHUD.h"
#import "THInfoTool.h"
#import "THInfoResult.h"
#import "THIntroController.h"

#import "THUserTool.h"
#import "THUser.h"
#import "THKeyWordTool.h"
#import "THKeyWordResult.h"

#define H_WIDTH [UIScreen mainScreen].bounds.size.width
#define H_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface THHomeController ()<THOptionDelegate, THScrollDelegate>

//图片数组
@property (nonatomic, strong) NSMutableArray *images;

@property (nonatomic, strong) THScrollView *scrollView;
@property (nonatomic, strong) THHotView *hotView;
@property (nonatomic, strong) THOptionView *optionList;

@end

@implementation THHomeController

-(NSMutableArray *)images{
    if (!_images) {
        _images = [NSMutableArray array];
        [_images addObject:@"ad_01"];
        [_images addObject:@"ad_02"];
        [_images addObject:@"ad_03"];
    }
    return _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:230/255.0 green:231/255.0 blue:232/255.0 alpha:1];
    [self layoutUI];
    //默认值为yes，系统将会自动的调整scrollView的位置来达到它认为“合理”的位置
    self.automaticallyAdjustsScrollViewInsets=NO;
    //界面加载自动搜索一次
    [self autoSearch];
}

//添加滚动显示区域
-(void)addScrollView{
    THScrollView *scrollView = [[THScrollView alloc]initWithFrame:CGRectMake(0, 90, H_WIDTH, 0.209*[UIScreen mainScreen].bounds.size.height)];
    [self.view addSubview:scrollView];
    _scrollView = scrollView;
    _scrollView.delegate = self;
    scrollView.imgs = self.images;
}
//添加热点显示部分
-(void)addHotView{
    THHotView *hotView = [[THHotView alloc]initWithFrame:CGRectMake(0, _scrollView.height + _scrollView.y, H_WIDTH, 0.097*[UIScreen mainScreen].bounds.size.height)];
    _hotView = hotView;
    [self.view addSubview:hotView];
}

//添加控制区域
-(void)addOptionView{
    CGFloat optionY = _hotView.y + _hotView.height;
    THOptionView *optionList = [[THOptionView alloc]initWithFrame:CGRectMake(0, optionY, H_WIDTH, H_HEIGHT - optionY - 60)];
    optionList.delegate = self;
    _optionList = optionList;
    [self.view addSubview:optionList];
}

//设置ui
-(void)layoutUI{
    [self addScrollView];
    [self addHotView];
    [self addOptionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark THScrollDelegate
-(void)didClickImg:(long)type{
    
    THIntroController *vc = [[THIntroController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark THOptionDelegate
-(void)addKeyWord{
    THKeyWordAndWebsiteController *vc = [[THKeyWordAndWebsiteController alloc]init];
    vc.type = 0;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)addNewWebSite{
    THKeyWordAndWebsiteController *vc = [[THKeyWordAndWebsiteController alloc]init];
    vc.type = 1;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)autoSearch{
    THUser *user = [THUserTool getUser];
    if (user) {
        if (!user.isCheck || [THUserTool getUser].keywordArray.count == 0) {
            return;
        }
    }else{
        if([THKeyWordTool getWords].words.count == 0){
            return;
        }
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (user) {
        if ([user.useLocate isEqualToString:@"YES"]) {
            if (![user.area isEqualToString:@"全部"]) {
                params[@"city"] = user.area;
            }else if (![user.city isEqualToString:@"全部"]){
                params[@"city"] = user.area;
            }else if (![user.province isEqualToString:@"全部"]){
                params[@"city"] = user.province;
            }
        }
    }else{
        THKeyWordResult *result = [THKeyWordTool getWords];
        if ([result.useLocate isEqualToString:@"YES"]) {
            if (![result.area isEqualToString:@"全部"]) {
                params[@"city"] = result.area;
            }else if (![result.city isEqualToString:@"全部"]){
                params[@"city"] = result.area;
            }else if (![result.province isEqualToString:@"全部"]){
                params[@"city"] = result.province;
            }
        }
    }
    [THInfoTool getInfoWithType:0 maxId:-1 parameters:params success:^(NSString *status, NSString *message) {} failure:^(NSError *error) {}];
    
}

-(void)startSearch{
    
    THUser *user = [THUserTool getUser];
    if (user) {
        if ([THUserTool getUser].keywordArray.count == 0) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"您暂未添加任何关键词，无法进行搜索" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
            return;
        }
        
    }else{
        if([THKeyWordTool getWords].words.count == 0){
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"您暂未添加任何关键词，无法进行搜索" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
            return;
        }
        
    }
    
    MBProgressHUD * HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.mode = MBProgressHUDModeText;
    HUD.labelText = @"正在搜索请稍等...";
    HUD.margin = 10;
    HUD.yOffset = [UIScreen mainScreen].bounds.size.height/3.0;
    HUD.removeFromSuperViewOnHide = YES;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (user) {
        if ([user.useLocate isEqualToString:@"YES"]) {
            if (![user.area isEqualToString:@"全部"]) {
                params[@"city"] = user.area;
            }else if (![user.city isEqualToString:@"全部"]){
                params[@"city"] = user.area;
            }else if (![user.province isEqualToString:@"全部"]){
                params[@"city"] = user.province;
            }
        }
    }else{
        THKeyWordResult *result = [THKeyWordTool getWords];
        if ([result.useLocate isEqualToString:@"YES"]) {
            if (![result.area isEqualToString:@"全部"]) {
                params[@"city"] = result.area;
            }else if (![result.city isEqualToString:@"全部"]){
                params[@"city"] = result.area;
            }else if (![result.province isEqualToString:@"全部"]){
                params[@"city"] = result.province;
            }
        }
    }
    
    [THInfoTool getInfoWithType:0 maxId:-1 parameters:params success:^(NSString *status, NSString *message) {
        [HUD hide:YES];
        if (![status isEqualToString:@"ok"]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"数据加载失败请重试" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
            return;
        }
        if ([message isEqualToString:@"没有信息!!!"]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"没有任何信息，请替换地点或关键词" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
            return;
        }
        
        THUser *user = [THUserTool getUser];
        if (user) {
            user.isCheck = @"YES";
            [THUserTool saveUser:user];
        }
        
        self.tabBarController.selectedIndex = 1;
    } failure:^(NSError *error) {
        [HUD hide:YES];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"数据加载失败" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        NSLog(@"%@", error);
    }];
}

@end
