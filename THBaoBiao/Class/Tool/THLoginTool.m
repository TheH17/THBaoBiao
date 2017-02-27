//
//  THLoginTool.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/28.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "THLoginTool.h"
#import "THHTTPTool.h"
#import "MJExtension.h"
#import "THUser.h"
#import "THUserTool.h"

#import "THKeyWordTool.h"
#import "THKeyWordResult.h"

@implementation THLoginTool

+(void)loginWithParameters:(NSMutableDictionary *)parameters success:(void (^)(NSString *, NSString *))success failure:(void (^)(NSError *))failure{
    [THHTTPTool POST:THLoginUrl parameters:parameters success:^(id responseObject) {
        if (success) {
            
            NSString *status = responseObject[@"status"];
            
            if ([status isEqualToString:@"ok"]) {
                
                THUser *user = [THUser userWithDict:responseObject];
                THKeyWordResult *result = [THKeyWordTool getWords];
                user.province = result.province;
                user.city = result.city;
                user.area = result.area;
                user.useLocate = result.useLocate;
                user.password = parameters[@"password"];
                [THUserTool saveUser:user];
                
                if (result.words.count > 0) {
                    [THUserTool updataKeyWordsWithArray:[THKeyWordTool getWords].words];
                }
                [THKeyWordTool saveWords:nil];
            }
            
            if (success) {
                success(responseObject[@"status"], responseObject[@"message"]);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)signUpWithParameters:(NSMutableDictionary *)parameters success:(void (^)(NSString *, NSString *))success failure:(void (^)(NSError *))failure{
    [THHTTPTool POST:THSignUpUrl parameters:parameters success:^(id responseObject) {
        
        THLog(@"注册%@", responseObject[@"Message"]);
        if (success) {
            success(responseObject[@"status"], responseObject[@"message"]);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)findPassWithParameters:(NSMutableDictionary *)parameters success:(void (^)(NSString *, NSString *))success failure:(void (^)(NSError *))failure{
    [THHTTPTool POST:THFindPassUrl parameters:parameters success:^(id responseObject) {
        
        THLog(@"注册%@", responseObject[@"Message"]);
        if (success) {
            success(responseObject[@"status"], responseObject[@"message"]);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)sendCheckCodeWithParameters:(NSMutableDictionary *)parameters success:(void (^)(NSString *, NSString *))success failure:(void (^)(NSError *))failure{
    [THHTTPTool POST:THCheckCodeUrl parameters:parameters success:^(id responseObject) {
        THLog(@"验证吗%@", responseObject[@"status"]);
        if (success) {
            success(responseObject[@"status"], responseObject[@"message"]);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)logoutWithSuccess:(void (^)(NSString *, NSString *))success failure:(void (^)(NSError *))failure{
    [THHTTPTool POST:THLogoutUrl parameters:nil success:^(id responseObject) {
        if (success) {
            success(responseObject[@"status"], responseObject[@"message"]);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)changePassWithParameters:(NSMutableDictionary *)parameters success:(void (^)(NSString *, NSString *))success failure:(void (^)(NSError *))failure{
    [THHTTPTool POST:THChangePassUrl parameters:parameters success:^(id responseObject) {
        if (success) {
            success(responseObject[@"status"], responseObject[@"message"]);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
