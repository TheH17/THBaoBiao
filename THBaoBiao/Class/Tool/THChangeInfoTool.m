//
//  THChangeInfoTool.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 2016/11/16.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "THChangeInfoTool.h"
#import "THHTTPTool.h"

@implementation THChangeInfoTool

+(void)saveInfoWithParameters:(NSMutableDictionary *)parameters success:(void (^)(NSString *, NSString *))success failure:(void (^)(NSError *))failure{
    [THHTTPTool POST:@"http://120.25.162.238:8080/baobiaoshiro/user/infoIOS" parameters:parameters success:^(id responseObject) {
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

@end
