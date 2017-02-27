//
//  THInfoTool.h
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/10/5.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@class THInfoResult;
@interface THInfoTool : NSObject

+(void)getInfoWithType:(int)type maxId:(int)maxId parameters:(NSMutableDictionary *)parameters success:(void (^)(NSString *, NSString *))success failure:(void (^)(NSError *))failure;

+(THInfoResult *)getInfoDataResult;

+(void)saveInfoDataResult:(THInfoResult *)data;

+(void)saveHistoryInfoDataResult:(THInfoResult *)data;

+(THInfoResult *)getHistoryInfoDataResult;

@end
