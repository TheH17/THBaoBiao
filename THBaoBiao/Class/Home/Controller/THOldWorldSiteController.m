//
//  THOldWorldSiteController.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/27.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "THOldWorldSiteController.h"
#import "THOldKeyWordView.h"
#import "THOldWebsiteView.h"

#import "THaddWordAndSiteView.h"
#import "MBProgressHUD.h"
#import "THWebsiteTool.h"
#import "THTHSiteResult.h"
#import "THKeyWordTool.h"
#import "THKeyWordResult.h"
#import "THUserTool.h"
#import "THUser.h"

#import "THKeyWordAndWebsiteController.h"
#import "THSite.h"

#import "Masonry.h"

#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height

@interface THOldWorldSiteController ()<THaddWordSiteDelegate,THOldSiteAddSiteDelegate,THOldWordAddWordDelegate>

@property (nonatomic, strong) THaddWordAndSiteView *addView;

@end

@implementation THOldWorldSiteController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:237/255.0 green:236/255.0 blue:235/255.0 alpha:1];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

-(void)setType:(int)type{
    _type = type;
    [self initDatas];
}

-(void)initDatas{
    THUser *user = [THUserTool getUser];
    if (user) {
        _datas = (_type == 0) ? [user.keywordArray mutableCopy]: [user.sites mutableCopy];
    }else{
        _datas = (_type == 0) ? [[THKeyWordTool getWords].words mutableCopy]: [NSArray array];
    }
    
    (self.datas.count == 0) ? [self showNoResult] : [self layoutUI];
    
    self.addView = [[THaddWordAndSiteView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height * 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _addView.type = _type;
    _addView.delegate = self;
    [self.view addSubview:_addView];
}

-(void)layoutUI{
    if (_type == 0) {
        THOldKeyWordView *oldKeyWordView = [[THOldKeyWordView alloc]initWithFrame:CGRectMake(0, 90, WIDTH, HEIGHT - 90) WithCount:self.datas.count];
        oldKeyWordView.wordList = _datas;
        oldKeyWordView.addWorddelegate = self;
        [self.view addSubview:oldKeyWordView];
    }else{
        THOldWebsiteView *oldWebsiteView = [[THOldWebsiteView alloc]initWithFrame:CGRectMake(0, 90, WIDTH, HEIGHT - 90) WithCount:self.datas.count];
        oldWebsiteView.siteList = _datas;
        oldWebsiteView.addSitedelegate = self;
        [self.view addSubview:oldWebsiteView];
    }
}

-(void)showNoResult{
    UILabel *infoLabel = [[UILabel alloc]init];
    infoLabel.textAlignment = NSTextAlignmentLeft;
    infoLabel.font = [UIFont systemFontOfSize:30];
    infoLabel.textColor = [UIColor colorWithRed:86/255.0 green:86/255.0 blue:87/255.0 alpha:1];
    infoLabel.textAlignment = NSTextAlignmentCenter;
    infoLabel.text = (_type == 0) ?  @"您还没有添加关键词" : @"您还没有添加新网站";
    [self.view addSubview:infoLabel];
    [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0.18*[UIScreen mainScreen].bounds.size.height);
        make.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(0.15*[UIScreen mainScreen].bounds.size.height);
    }];
}

#pragma mark oldSitedelegate
-(void)addNewSiteInOldPage{
    [UIView animateWithDuration:0.5 animations:^{
        [_addView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark oldWorddelegate
-(void)addNewWordInOldPage{
    [UIView animateWithDuration:0.5 animations:^{
        [_addView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        
    } completion:^(BOOL finished) {
        
    }];
}

-(void)deleteWebSite:(THSite *)site{
    MBProgressHUD * HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.mode = MBProgressHUDModeText;
    HUD.labelText = @"正在删除...";
    HUD.margin = 10;
    HUD.yOffset = [UIScreen mainScreen].bounds.size.height/3.0;
    HUD.removeFromSuperViewOnHide = YES;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"site_id"] = site.siteId;
    [THWebsiteTool deleteSiteWithParameters:params success:^(NSString *status, NSString *message) {
        [HUD hide:YES];
        if (![status isEqualToString:@"ok"]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"删除失败" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
            return;
        }
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"删除成功" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        [self getDatas];
    } failure:^(NSError *error) {
        [HUD hide:YES];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"删除失败" message:@"网络故障请重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        THLog(@"%@", error);
    }];
}

-(void)deleteWord:(NSString *)word{
    if ([THUserTool getUser]) {
        [self deleteRemoteWord:word];
    }else{
        [self deleteLocateWord:word];
    }
}

-(void)deleteRemoteWord:(NSString *)word{
    [self.datas removeObjectIdenticalTo:word];
    
    MBProgressHUD * HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.mode = MBProgressHUDModeText;
    HUD.labelText = @"正在删除数据...";
    HUD.margin = 10;
    HUD.yOffset = [UIScreen mainScreen].bounds.size.height/3.0;
    HUD.removeFromSuperViewOnHide = YES;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"keyword"] = [[self.datas componentsJoinedByString:@","] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [THKeyWordTool sendWordWithParameters:params success:^(NSString *status, NSString *message) {
        [HUD hide:YES];
        if (![status isEqualToString:@"ok"]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"删除失败" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
            return;
        }
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"删除成功" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        [self getDatas];
    } failure:^(NSError *error) {
        [HUD hide:YES];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"添加失败" message:@"网络故障请重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return;
    }];
}

-(void)deleteLocateWord:(NSString *)word{
    THKeyWordResult *result = [THKeyWordTool getWords];
    NSMutableArray *words = [result.words mutableCopy];
    [words removeObject:word];
    
    result.words = [words mutableCopy];
    [THKeyWordTool saveWords:result];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"删除成功" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
    [self initUI];
}

#pragma mark addviewdelegate
-(void)closeAddWordSiteView{
    [UIView animateWithDuration:0.5 animations:^{
        [_addView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height * 2, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        
    } completion:^(BOOL finished) {
        
    }];
}

-(void)successFulAddData{
    [self initUI];
}

-(void)getDatas{
    MBProgressHUD * HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.mode = MBProgressHUDModeText;
    HUD.labelText = @"正在更新数据...";
    HUD.margin = 10;
    HUD.yOffset = [UIScreen mainScreen].bounds.size.height/3.0;
    HUD.removeFromSuperViewOnHide = YES;
    if (_type == 1) {
        [THWebsiteTool getSiteWithSuccess:^() {
            [HUD hide:YES];
            [self initUI];
        } failure:^(NSError *error) {
            [HUD hide:YES];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"数据加载失败请返回上一界面重试" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
            THLog(@"%@", error);
        }];
    }else{
        [THKeyWordTool getWordWithSuccess:^(NSString *status) {
            [HUD hide:YES];
            [self initUI];
        } failure:^(NSError *error) {
            [HUD hide:YES];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"数据加载失败请返回上一界面重试" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
            THLog(@"%@", error);
        }];
    }
    
}

-(void)initUI{
    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }
    [self initDatas];
    [self.col initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
