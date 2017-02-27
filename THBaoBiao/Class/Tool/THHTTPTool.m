//
//  THHTTPTool.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/28.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "THHTTPTool.h"
#import "AFNetworking.h"

@implementation THHTTPTool

+ (void)GET:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure{
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    [mgr GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

//post请求用于请求oauth授权
+(void)POST:(NSString *)URLString
 parameters:(NSMutableDictionary *)parameters
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure{
    
//    NSError *parseError = nil;
//    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:&parseError];
//    
//    NSString *data = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncod ing];
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    //申明返回的结果是json类型
//    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
//    //申明请求的数据是json类型
//    mgr.requestSerializer=[AFJSONRequestSerializer serializer];
    
    [mgr.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [mgr POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSHTTPURLResponse * responses = (NSHTTPURLResponse *)task.response;
        
        NSLog(@"%ld",(long)responses.statusCode);
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
}


@end
