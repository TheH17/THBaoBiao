//
//  THUserTool.h
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/10/9.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@class THUser;
@interface THUserTool : NSObject

+(THUser *)getUser;

+(void)saveUser:(THUser *)user;

//==============更新关键词和网站======================
+(void)updataKeyWordsWithString:(NSString *)wordString;

+(void)updataSitesWithArray:(NSArray *)sites;

+(void)updataKeyWordsWithArray:(NSArray *)words;

@end
