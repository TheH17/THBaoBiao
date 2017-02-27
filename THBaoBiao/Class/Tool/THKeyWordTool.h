//
//  THKeyWordTool.h
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/26.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@class THKeyWordResult;
@interface THKeyWordTool : NSObject

+(void)getWordWithSuccess:(void (^)(NSString *))success failure:(void (^)(NSError *))failure;

+(void)sendWordWithParameters:(NSMutableDictionary *)parameters success:(void (^)(NSString *, NSString *))success failure:(void (^)(NSError *))failure;

//+(void)deleteWordWithParameters:(id)parameters success:(void (

+(THKeyWordResult *)getWords;

+(void)saveWords:(THKeyWordResult *)words;

+(NSString *)getWordString;

@end
