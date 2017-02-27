//
//  THLoginTool.h
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/28.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@class THUser;
@interface THLoginTool : NSObject

+(void)loginWithParameters:(NSMutableDictionary *)parameters success:(void (^)(NSString *, NSString *))success failure:(void (^)(NSError *))failure;

+(void)signUpWithParameters:(NSMutableDictionary *)parameters success:(void (^)(NSString *, NSString *))success failure:(void (^)(NSError *))failure;

+(void)findPassWithParameters:(NSMutableDictionary *)parameters success:(void (^)(NSString *, NSString *))success failure:(void (^)(NSError *))failure;

+(void)sendCheckCodeWithParameters:(NSMutableDictionary *)parameters success:(void (^)(NSString *, NSString *))success failure:(void (^)(NSError *))failure;

+(void)logoutWithSuccess:(void (^)(NSString *, NSString *))success failure:(void (^)(NSError *))failure;

+(void)changePassWithParameters:(NSMutableDictionary *)parameters success:(void (^)(NSString *, NSString *))success failure:(void (^)(NSError *))failure;

@end
