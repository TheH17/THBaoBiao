//
//  THChangeInfoTool.h
//  THBaoBiao
//
//  Created by 李浩鹏 on 2016/11/16.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface THChangeInfoTool : NSObject

+(void)saveInfoWithParameters:(NSMutableDictionary *)parameters success:(void (^)(NSString *, NSString *))success failure:(void (^)(NSError *))failure;

@end
