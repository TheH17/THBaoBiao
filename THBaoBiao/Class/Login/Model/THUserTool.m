//
//  THUserTool.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/10/9.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "THUserTool.h"
#import "THUser.h"

#define THAccountFileName [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"userAccount.dat"]

@implementation THUserTool

static THUser *_user;

+(THUser *)getUser{
    _user = [NSKeyedUnarchiver unarchiveObjectWithFile:THAccountFileName];
    
//    // 获得系统的时区
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    //获取0时区的时间
//    NSDate *date = [NSDate date];
//    // 获得系统的时区与标准的时间差
//    NSTimeInterval time = [zone secondsFromGMTForDate:date];
//    //获取当前时区的时间
//    NSDate *nowDate = [date dateByAddingTimeInterval:time];
//    //当前时间和有效时间比较是否过期
//    if ([nowDate compare:_user.expiresDate] == NSOrderedDescending) {
//        //过期则返回nil，需要重新登录
//        return nil;
//    }
    return _user;
}

+(void)saveUser:(THUser *)user{
    //合并的写法
    //模型归档必须要遵守协议
    [NSKeyedArchiver archiveRootObject:user toFile:THAccountFileName];
}


//==============更新关键词和网站======================
+(void)updataKeyWordsWithString:(NSString *)wordString{
    THUser *user = [self getUser];
    user.keyword = wordString;
    if (wordString) {
        user.keywordArray = [wordString componentsSeparatedByString:@","];
    }else{
        user.keywordArray = [NSArray array];
    }
    [self saveUser:user];
}

+(void)updataKeyWordsWithArray:(NSArray *)words{
    THUser *user = [self getUser];
    user.keywordArray = words;
    user.keyword = [words componentsJoinedByString:@","];
    [self saveUser:user];
}

+(void)updataSitesWithArray:(NSArray *)sites{
    THUser *user = [self getUser];
    user.sites = [sites mutableCopy];
    [self saveUser:user];
}

@end
