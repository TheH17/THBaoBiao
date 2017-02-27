//
//  THKeyWordTool.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/26.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "THKeyWordTool.h"
#import "THHTTPTool.h"
#import "THUserTool.h"
#import "THUser.h"
#import "THKeyWordResult.h"

#define THWordsFileName [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"userKwyWords.dat"]

@implementation THKeyWordTool


static THKeyWordResult *words;

+(void)getWordWithSuccess:(void (^)(NSString *))success failure:(void (^)(NSError *))failure{
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    THUser *user = [THUserTool getUser];
//    params[@"user_id"] = user.id;
    [THHTTPTool GET:@"http://120.25.162.238:8080/baobiaoshiro/user/getKeywords" parameters:nil success:^(id responseObject) {
        
        if ([responseObject[@"status"] isEqualToString:@"ok"]) {
            if ([responseObject[@"keywords"] isEqual:[NSNull null]]){
                [THUserTool updataKeyWordsWithString:nil];
            }else{
                [THUserTool updataKeyWordsWithString:responseObject[@"keywords"]];
            }
        }else{
            if (![self getWords]) {
                [THUserTool updataKeyWordsWithString:nil];
            }
        }
        
        THLog(@"添加网站：%@", responseObject[@"status"]);
        if (success) {
            success(responseObject[@"status"]);
        }
    } failure:^(NSError *error) {
        if (![self getWords]) {
            [THUserTool updataKeyWordsWithString:nil];
        }
        THLog(@"添加关键字：%@", error);
        if (failure) {
            failure(error);
        }
    }];
    
}

+(void)sendWordWithParameters:(NSMutableDictionary *)parameters success:(void (^)(NSString *, NSString *))success failure:(void (^)(NSError *))failure{
    
    [THHTTPTool POST:@"http://120.25.162.238:8080/baobiaoshiro/user/keywords" parameters:parameters success:^(id responseObject) {
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

+(THKeyWordResult *)getWords{

    words = [NSKeyedUnarchiver unarchiveObjectWithFile:THWordsFileName];
    
    if (!words) {
        THKeyWordResult *result = [THKeyWordResult new];
        result.words = [NSArray array];
        result.localPage = @"0";
        return result;
    }

    return words;
}

+(void)saveWords:(THKeyWordResult *)words{
    //合并的写法
    //模型归档必须要遵守协议
    [NSKeyedArchiver archiveRootObject:words toFile:THWordsFileName];
}

+(NSString *)getWordString{
    return [[self getWords].words componentsJoinedByString:@","];
}

@end
