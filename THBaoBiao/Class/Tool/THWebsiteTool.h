//
//  THWebsiteTool.h
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/27.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@class THTHSiteResult;
@interface THWebsiteTool : NSObject

+(void)getSiteWithSuccess:(void (^)())success failure:(void (^)(NSError *))failure;

+(void)sendSiteWithParameters:(NSMutableDictionary *)parameters success:(void (^)(NSString *))success failure:(void (^)(NSError *))failure;

+(void)deleteSiteWithParameters:(NSMutableDictionary *)parameters success:(void (^)(NSString *, NSString *))success failure:(void (^)(NSError *))failure;

+(THTHSiteResult *)getSites;

+(void)saveSites:(THTHSiteResult *)sites;

@end
