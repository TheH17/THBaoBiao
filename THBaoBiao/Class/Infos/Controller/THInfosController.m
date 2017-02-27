//
//  THInfosController.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/12.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "THInfosController.h"
#import "THSearchView.h"
#import "THInfoListView.h"
#import "THWebViewController.h"
#import "THInfoTool.h"
#import "THInfoResult.h"
#import "THInfoData.h"
#import "MBProgressHUD.h"
#import "THKeyWordResult.h"
#import "THKeyWordTool.h"

#import "THUserTool.h"
#import "THUser.h"
#import "THRootTool.h"
#import "THLocationView.h"
#import "THAddressPickerView.h"
#import "UIBarButtonItem+THBarItem.h"
#import "THLocationTool.h"
#import "THLocationData.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface THInfosController ()<THSearchViewDelegate, THLocationDelegate, THAddressPickerViewDelegate, THInfoListDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) THSearchView *searchView;

@property (nonatomic, strong) THInfoListView *infoList;

@property (nonatomic, strong) THLocationView *locationTitle;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic , copy) NSString *keyword;

@property (nonatomic, strong) THAddressPickerView *addressView;

@end

@implementation THInfosController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:230/255.0 green:231/255.0 blue:232/255.0 alpha:1];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:nil andSelectedImage:nil andTitle:@"定位" andTarget:self Action:@selector(useLocate) forControlEvents:UIControlEventTouchUpInside];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }
    [self layoutUI];
    if (self.indexPath) {
        [self.infoList scrollToIndexPath:self.indexPath];
        self.indexPath = nil;
    }
}

-(void)layoutUI{
    [self addSearchView];
    [self addLocationTitleView];
    [self addInfoView];
    self.addressView = [[THAddressPickerView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height * 2, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _addressView.delegate = self;
    [self.view addSubview:_addressView];
}

-(void)addInfoView{
    CGRect frame = self.locationTitle.frame;
    CGFloat y = frame.size.height+frame.origin.y;
    THInfoListView *infoList = [[THInfoListView alloc]initWithFrame:CGRectMake(0, y, WIDTH, self.view.frame.size.height - y - 60)];
    _infoList = infoList;
    infoList.delegate = self;
    [self.view addSubview:infoList];
}

-(void)addLocationTitleView{
    CGRect frame = self.searchView.frame;
    CGFloat y = frame.size.height+frame.origin.y;
    THLocationView *view = [[THLocationView alloc]initWithFrame:CGRectMake(0, y, WIDTH, 0.06*HEIGHT)];
    view.delegate = self;
    _locationTitle = view;
    [self.view addSubview:view];
    
}

-(void)addSearchView{
    THSearchView *searchView = [[THSearchView alloc]initWithFrame:CGRectMake(0, 90, WIDTH, 0.1049*HEIGHT)];
    searchView.delegate = self;
    _searchView = searchView;
    [self.view addSubview:searchView];
}

#pragma mark THSearchViewDelegate
-(void)searchFromResultWithKeyWord:(NSString *)keyword{
    
//    if ([THInfoTool getInfoDataResult].data.count == 0){
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"本地没有信息，请先搜索" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alertView show];
//        return;
//    }
    _keyword = keyword;
    MBProgressHUD * HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.mode = MBProgressHUDModeText;
    HUD.labelText = @"正在搜索请稍等...";
    HUD.margin = 10;
    HUD.yOffset = [UIScreen mainScreen].bounds.size.height/3.0;
    HUD.removeFromSuperViewOnHide = YES;
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    THUser *user = [THUserTool getUser];
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
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"没有信息，请更换地点或者关键词" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
            return;
        }
        [self.infoList updataWithKeyword:keyword];
    } failure:^(NSError *error) {
        [HUD hide:YES];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"失败" message:@"数据加载失败，请重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        NSLog(@"%@", error);
    }];
    
}

#pragma mark THLocationDelegate
-(void)showAddressPickView{
    [self.view bringSubviewToFront:_addressView];
    
    THLocationData *data = [THLocationTool getLocationData];
    [_addressView moveToProvince:data.LocationProvince City:data.LocationCity Area:data.LocationArea];
    
    [UIView animateWithDuration:0.5 animations:^{
        [_addressView setFrame:CGRectMake(0, -60, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark THAddressPickerViewDelegate
-(void)closeAddressView{
    [self.locationTitle cancelLoacation];
    [UIView animateWithDuration:0.5 animations:^{
        [_addressView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height * 2, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        
    } completion:^(BOOL finished) {
        
    }];
}

-(void)useLocationAuto{
    [self closeAddressView];
    THLocationData *data = [THLocationTool getLocationData];
    [self.locationTitle setProvince:data.LocationProvince city:data.LocationCity area:data.LocationArea];
    [self searchWithProvince:data.LocationProvince City:data.LocationCity Area:data.LocationArea];
}
#pragma mark 导航栏
-(void)useLocate{
    [_addressView resetLocate];
    THLocationData *data = [THLocationTool getLocationData];
    if (data) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"已为您定位到当前地点是%@%@%@，是否使用此地点", data.LocationProvince , data.LocationCity, data.LocationArea] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"使用此地点", nil];
        [alertView show];
        return;
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"无法定位到您的地点，请手动选择或稍后再试" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        NSString *btnTitle = [alertView buttonTitleAtIndex:buttonIndex];
        if ([btnTitle isEqualToString:@"现在去登录"]) {
            [THRootTool changeRootControllerToLogin:self];
        }else if([btnTitle isEqualToString:@"使用此地点"]){
            THLocationData *data = [THLocationTool getLocationData];
            [self.locationTitle setProvince:data.LocationProvince city:data.LocationCity area:data.LocationArea];
            [self searchWithProvince:data.LocationProvince City:data.LocationCity Area:data.LocationArea];
        }
    }else{
        
    }
}

//选择地区确定
-(void)selectedProvince:(NSString *)province City:(NSString *)city Area:(NSString *)area{
//    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"hint" message:[NSString stringWithFormat:@"p:%@ c:%@ a:%@", province, city, area] delegate:self cancelButtonTitle:@"cancel" otherButtonTitles: nil];
//    [alertView show];
    [self.locationTitle setProvince:province city:city area:area];
    [self searchWithProvince:province City:city Area:area];
}

-(void)searchWithProvince:(NSString *)province City:(NSString *)city Area:(NSString *)area{
    
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
    if (![area isEqualToString:@"全部"]) {
        params[@"city"] = area;
    }else if (![city isEqualToString:@"全部"]){
        params[@"city"] = area;
    }else if (![province isEqualToString:@"全部"]){
        params[@"city"] = province;
    }
    
    [THInfoTool getInfoWithType:0 maxId:-1 parameters:params success:^(NSString *status, NSString *message) {
        [HUD hide:YES];
        if (![status isEqualToString:@"ok"]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"数据加载失败请重试" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
            return;
        }
        if ([message isEqualToString:@"没有信息!!!"]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"没有信息，请更换地点或者关键词" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
            return;
        }
        [self.infoList updataWithKeyword:self.keyword];
    } failure:^(NSError *error) {
        [HUD hide:YES];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"数据加载失败" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        NSLog(@"%@", error);
    }];
}

#pragma mark THInfoListDelegate
-(NSString *)getLocalKeyWord{
    return self.keyword;
}

-(void)loadWebViewWithUrlString:(NSString *)string mirrorUrlString:(NSString *)mirrorUrl indexPath:(NSIndexPath *)indexPath{
    
    if (![THUserTool getUser]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"失败" message:@"您还没有登录无法使用此功能" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"现在去登录", nil];
        
        [alertView show];
        return;
    }
    
    THWebViewController *col = [[THWebViewController alloc]init];
    col.urlString = string;
    col.mirrorUrlString = mirrorUrl;
    col.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:col animated:YES];
    self.indexPath = indexPath;
}

@end
