//
//  THInfoListView.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/21.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "THInfoListView.h"
#import "THInfoHeaderView.h"
#import "THInfoTool.h"
#import "THInfoResult.h"
#import "THInfoData.h"
#import "THUserTool.h"
#import "THUser.h"

#import "THInfoListCell.h"
#import "MJRefresh.h"
#import "NSDate+THLocalDate.h"

#import "THKeyWordTool.h"
#import "THKeyWordResult.h"

@interface THInfoListView()<UITableViewDataSource, UITableViewDelegate, THInfoHeaderDelegate>

@property (nonatomic, strong) NSArray *infoArray;
@property (nonatomic, strong) UITableView *infoTableView;
@property (nonatomic, copy) NSString *keyWord;
@property (nonatomic, assign) BOOL open;
@property (nonatomic, assign) int showDataId;
@property (nonatomic, copy) NSString *showDataTime;
@property (nonatomic, assign) int minDataId;
@property (nonatomic, assign) int maxDataId;

@end

@implementation THInfoListView

static NSString * const reuseIdentifier = @"InfoListViewCell";

-(NSArray *)infoArray{
    if (!_infoArray) {
        _infoArray = [NSArray array];
    }
    return _infoArray;
}

-(void)scrollToIndexPath:(NSIndexPath *)indexPath{
    [self.infoTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _open = YES;
        [self loadInfo];
        [self layoutUI];
        self.backgroundColor = [UIColor colorWithRed:230/255.0 green:231/255.0 blue:232/255.0 alpha:1];
    }
    return self;
}

-(void)loadInfo{
    _infoArray = [THInfoTool getInfoDataResult].data;
    self.minDataId = [((THInfoData *)[_infoArray lastObject]).id intValue];
    self.maxDataId = [((THInfoData *)[_infoArray firstObject]).id intValue];
}

-(void)layoutUI{
    UITableView *infoList = [[UITableView alloc]initWithFrame:self.bounds];
    infoList.backgroundColor = [UIColor whiteColor];
    infoList.dataSource = self;
    infoList.delegate = self;
    self.infoTableView = infoList;
    [self addSubview:infoList];
    [self.infoTableView addFooterWithTarget:self action:@selector(loadMoreDatas)];
    [self.infoTableView addHeaderWithTarget:self action:@selector(freshSearch)];
}

-(void)freshSearch{
    
    NSString *keyword = (_keyWord) ? _keyWord : [self.delegate getLocalKeyWord];
    
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
    
    [THInfoTool getInfoWithType:0 maxId:self.maxDataId parameters:params success:^(NSString *status, NSString *message) {
        [self.infoTableView headerEndRefreshing];
        if (![status isEqualToString:@"ok"]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"数据加载失败请重试" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
            return;
        }
        if ([message isEqualToString:@"已经是最新信息"]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
            return;
        }
        [self updataWithKeyword:keyword];
    } failure:^(NSError *error) {
        [self.infoTableView headerEndRefreshing];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"失败" message:@"数据加载失败，请重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        NSLog(@"%@", error);
    }];
    
}

-(void)updataWithKeyword:(NSString *)keyword{
    _keyWord = keyword;
    if (!keyword || [keyword isEqualToString:@""]) {
        [self reInitData];
        return;
    }
    THInfoResult *result = [THInfoTool getInfoDataResult];
    NSArray *orginArray = result.data;
    NSMutableArray *tempArray = [NSMutableArray array];
    for (THInfoData *data in orginArray) {
        if ([data.name rangeOfString:keyword].location != NSNotFound) {
            [tempArray addObject:data];
        }
    }
    result.data = [tempArray mutableCopy];
    [THInfoTool saveInfoDataResult:result];
    [self reInitData];
}

-(void)reInitData{
    [self loadInfo];
    [self.infoTableView reloadData];
}

-(void)loadMoreDatas{
    THUser *user = [THUserTool getUser];
    
    if (user) {
        int p = [user.localPage intValue];
        if (self.minDataId < self.showDataId) {
            user.localPage = [NSString stringWithFormat:@"%d", p+1];
            [THUserTool saveUser:user];
            [self.infoTableView reloadData];
            [self.infoTableView footerEndRefreshing];
        }else{
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            //得到最小的dataid
            params[@"data_id"] = [NSString stringWithFormat:@"%d", self.showDataId];
            //将字符串转换为时间戳
            NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString *string = [self.showDataTime stringByReplacingOccurrencesOfString:@"T" withString:@" "];;
            //下面得到的时间是标准时间，需要转换成本地时间
            NSDate *date = [NSDate getLocalDateWithDate:[dateFormat dateFromString:string]];
            //转换为时间戳
            long long int showDataTime=(long long int)[date timeIntervalSince1970] * 1000;
            params[@"time"] = [NSString stringWithFormat:@"%lld", showDataTime];
            
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
            
            [THInfoTool getInfoWithType:1 maxId:-1 parameters:params success:^(NSString *status, NSString *message) {
                [self.infoTableView footerEndRefreshing];
                if (![status isEqualToString:@"ok"]) {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"数据加载失败请重试" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alertView show];
                    return;
                }
                if ([message isEqualToString:@"没有信息!!!"]) {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"没有最新信息" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alertView show];
                    return;
                }
                user.localPage = [NSString stringWithFormat:@"%d", p+1];
                [THUserTool saveUser:user];
                if (self.keyWord || ![self.keyWord isEqualToString:@""]) {
                    [self updataWithKeyword:self.keyWord];
                }else{
                    [self reInitData];
                }
            } failure:^(NSError *error) {
                [self.infoTableView footerEndRefreshing];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"数据加载失败请重试" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertView show];
            }];
        }
    }else{//user不存在
        THKeyWordResult *result = [THKeyWordTool getWords];
        int p = [result.localPage intValue];
        if (self.minDataId < self.showDataId) {
            result.localPage = [NSString stringWithFormat:@"%d", p+1];
            [THKeyWordTool saveWords:result];
            [self.infoTableView reloadData];
            [self.infoTableView footerEndRefreshing];
        }else{
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            //得到最小的dataid
            params[@"data_id"] = [NSString stringWithFormat:@"%d", self.showDataId];
            //将字符串转换为时间戳
            NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString *string = [self.showDataTime stringByReplacingOccurrencesOfString:@"T" withString:@" "];;
            //下面得到的时间是标准时间，需要转换成本地时间
            NSDate *date = [NSDate getLocalDateWithDate:[dateFormat dateFromString:string]];
            //转换为时间戳
            long long int showDataTime=(long long int)[date timeIntervalSince1970] * 1000;
            params[@"time"] = [NSString stringWithFormat:@"%lld", showDataTime];
            
            [THInfoTool getInfoWithType:1 maxId:-1 parameters:params success:^(NSString *status, NSString *message) {
                [self.infoTableView footerEndRefreshing];
                if (![status isEqualToString:@"ok"]) {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"数据加载失败请重试" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alertView show];
                    return;
                }
                if ([message isEqualToString:@"没有信息!!!"]) {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"没有新信息" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alertView show];
                    return;
                }
                result.localPage = [NSString stringWithFormat:@"%d", p+1];
                [THKeyWordTool saveWords:result];
                if (self.keyWord || ![self.keyWord isEqualToString:@""]) {
                    [self updataWithKeyword:self.keyWord];
                }else{
                    [self reInitData];
                }
            } failure:^(NSError *error) {
                [self.infoTableView footerEndRefreshing];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"数据加载失败请重试" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertView show];
            }];
        }
    }
    
    
}

#pragma mark dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
    
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (!self.open) return 0;
    
    THUser *user = [THUserTool getUser];
    int p;
    if (user) {
        p = [[THUserTool getUser].localPage intValue];
    }else{
        p = [[THKeyWordTool getWords].localPage intValue];
    }
    
    if ((p+1)*THInfoPageCount < _infoArray.count) {
        return (p+1)*THInfoPageCount;
    }else{
        return _infoArray.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    THInfoListCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[THInfoListCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    }else{
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
    }
    THInfoData *data = self.infoArray[indexPath.row];
    [cell setData:data];
    cell.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:243/255.0 alpha:1];

    self.showDataId = [data.id intValue];
    self.showDataTime = data.fetchTime;
    return cell;
}
#pragma mark delegate
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    THInfoHeaderView *view = [THInfoHeaderView headerViewFromTableView:tableView];
    view.delegate = self;
    view.open = self.open;
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    THInfoListCell *cell = [self.infoTableView cellForRowAtIndexPath:indexPath];
    [cell setColorWhenClick];
    THInfoResult *result = [THInfoTool getInfoDataResult];
    result.data = self.infoArray;
    [THInfoTool saveInfoDataResult:result];
    [self.delegate loadWebViewWithUrlString:cell.urlText mirrorUrlString:cell.mirrorUrl indexPath:indexPath];
    
    THInfoResult *historyResult = [THInfoTool getHistoryInfoDataResult];
    NSMutableArray *array = [historyResult.data mutableCopy];
    [array addObject:[cell getData]];
    historyResult.data = [array mutableCopy];
    [THInfoTool saveHistoryInfoDataResult:historyResult];
}

#pragma mark headerdelegate
-(void)headerViewDidClick{
    self.open = !self.open;
    if (self.open) {
        self.infoTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [self.infoTableView addFooterWithTarget:self action:@selector(loadMoreDatas)];
    }else{
        self.infoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.infoTableView removeFooter];
    }
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
    [_infoTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
}

@end
