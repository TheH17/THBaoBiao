//
//  THWebsiteTool.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/27.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "THWebsiteTool.h"
#import "THHTTPTool.h"
#import "THUserTool.h"
#import "THUser.h"
#import "MJExtension.h"
#import "THTHSiteResult.h"

#define THSitesFileName [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"userSiteWords.dat"]

@implementation THWebsiteTool

+(void)getSiteWithSuccess:(void (^)())success failure:(void (^)(NSError *))failure{
    
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    THUser *user = [THUserTool getUser];
//    params[@"user_id"] = user.UserID;
    
    [THHTTPTool GET:@"http://120.25.162.238:8080/baobiaoshiro/site/query" parameters:nil success:^(id responseObject) {
        
        NSString *status = responseObject[@"status"];
        
        if ([status isEqualToString:@"ok"]){
            THTHSiteResult *siteResult = [THTHSiteResult mj_objectWithKeyValues:responseObject];
            
            [THUserTool updataSitesWithArray:siteResult.sites];
        }
        
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (![self getSites]) {
//            //通信失败也要创建一个result为了后续的逻辑
//            THTHSiteResult *siteResult = [THTHSiteResult siteResultWithEmpty];
//            [self saveSites:siteResult];
            [THUserTool updataSitesWithArray:[NSArray array]];
        }
        THLog(@"添加网站：%@", error);
        if (failure) {
            failure(error);
        }
    }];

}

+(void)sendSiteWithParameters:(NSMutableDictionary *)parameters success:(void (^)(NSString *))success failure:(void (^)(NSError *))failure{
    
    [THHTTPTool POST:@"http://120.25.162.238:8080/baobiaoshiro/site/add" parameters:parameters success:^(id responseObject) {
        THLog(@"添加网站%@", responseObject);
        if (success) {
            success(responseObject[@"status"]);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)deleteSiteWithParameters:(NSMutableDictionary *)parameters success:(void (^)(NSString *, NSString *))success failure:(void (^)(NSError *))failure{
    
//    THUser *user = [THUserTool getUser];
//    parameters[@"user_id"] = user.UserID;
    
    [THHTTPTool POST: @"http://120.25.162.238:8080/baobiaoshiro/site/delete" parameters:parameters success:^(id responseObject) {
        THLog(@"添加关键字%@", responseObject);
        if (success) {
            success(responseObject[@"status"], responseObject[@"message"]);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

static THTHSiteResult *sites;

+(THTHSiteResult *)getSites{

    sites = [NSKeyedUnarchiver unarchiveObjectWithFile:THSitesFileName];

    return sites ;
}

+(void)saveSites:(THTHSiteResult *)sites{
    //合并的写法
    //模型归档必须要遵守协议
    [NSKeyedArchiver archiveRootObject:sites toFile:THSitesFileName];
}

@end
