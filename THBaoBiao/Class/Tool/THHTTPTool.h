//
//  THHTTPTool.h
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/28.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface THHTTPTool : NSObject

+ (void)GET:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure;

//post请求用于请求oauth授权
+(void)POST:(NSString *)URLString
 parameters:(NSMutableDictionary *)parameters
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure;


@end
