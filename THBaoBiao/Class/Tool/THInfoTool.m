//
//  THInfoTool.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/10/5.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "THInfoTool.h"
#import "THHTTPTool.h"
#import "THInfoResult.h"
#import "THInfoData.h"
#import "THUserTool.h"
#import "THUser.h"
#import "THKeyWordTool.h"
#import "THKeyWordResult.h"

#define THInfoDataFileName [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"infoData.dat"]
#define THInfoDataHistoryFileName [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"historyInfoData.dat"]

@implementation THInfoTool

+(void)getInfoWithType:(int)type maxId:(int)maxId parameters:(NSMutableDictionary *)parameters success:(void (^)(NSString *, NSString *))success failure:(void (^)(NSError *))failure{

    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//设定时间格式,这里可以设置成自己需要的格式
    
    NSDate *date =[dateFormat dateFromString:@"2000-01-01 00:00:01"];
    
    long long int currentTime=(long long int)[date timeIntervalSince1970] * 1000;
    
    parameters[@"fromTime"] = [NSString stringWithFormat:@"%lld", currentTime];
    
    NSString *url;
    THUser *user = [THUserTool getUser];
    if (user) {
        parameters[@"words"] = [[THUserTool getUser].keyword stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        parameters[@"own"] = @"false";
        url = @"http://120.25.162.238:8080/baobiaoshiro/site/data";
        
        //设置page
        if (type == 0) {
            user.localPage = @"0";
        }
        [THUserTool saveUser:user];
        
    }else{
        THKeyWordResult *result = [THKeyWordTool getWords];
        parameters[@"words"] = [[result.words componentsJoinedByString:@","] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        url = @"http://120.25.162.238:8080/baobiaoshiro/site/anon";
        if (type == 0) {
            result.localPage = @"0";
        }
    }
    
    [THHTTPTool POST:url parameters:parameters success:^(id responseObject) {
        
        NSString *status = responseObject[@"status"];
        
        if ([status isEqualToString:@"ok"]){
            
            NSArray *array = responseObject[@"data"];
            if (array.count == 0) {
                if (success) {
                    success(responseObject[@"status"], @"没有信息!!!");
                }
                return;
            }
            
            THInfoResult *infoResult = [THInfoResult mj_objectWithKeyValues:responseObject];
            
            if (maxId != -1 && [((THInfoData *)[infoResult.data firstObject]).id isEqualToString:[NSString stringWithFormat:@"%d", maxId]]) {
                if (success) {
                    success(responseObject[@"status"], @"已经是最新信息");
                }
            }else{
                //成功的到数据,数据转模型,分成两种type分别对应点击搜索和上拉搜索
                if (type == 0) {
                    [self saveInfoDataResult:infoResult];
                }else{
                    THInfoResult *infoOriginResult = [self getInfoDataResult];
                    NSMutableArray *muArray = [infoOriginResult.data mutableCopy];
                    [muArray addObjectsFromArray:infoResult.data];
                    infoOriginResult.data = [NSArray arrayWithArray:muArray];
                    [self saveInfoDataResult:infoOriginResult];
                }
            }
        }
        if (success) {
            success(responseObject[@"status"], nil);
        }
        
        
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

static THInfoResult *data;

+(void)saveInfoDataResult:(THInfoResult *)data{
    [NSKeyedArchiver archiveRootObject:data toFile:THInfoDataFileName];
}

+(THInfoResult *)getInfoDataResult{
    data = [NSKeyedUnarchiver unarchiveObjectWithFile:THInfoDataFileName];
    if (!data) {
        data = [THInfoResult new];
        data.data = [NSArray array];
    }
    return data ;
}

+(void)saveHistoryInfoDataResult:(THInfoResult *)data{
    [NSKeyedArchiver archiveRootObject:data toFile:THInfoDataHistoryFileName];
}

+(THInfoResult *)getHistoryInfoDataResult{
    data = [NSKeyedUnarchiver unarchiveObjectWithFile:THInfoDataHistoryFileName];
    if (!data) {
        data = [THInfoResult new];
        data.data = [NSArray array];
    }
    return data ;
}

@end
