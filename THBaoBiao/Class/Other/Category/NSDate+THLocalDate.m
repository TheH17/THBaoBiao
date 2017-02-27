//
//  NSDate+THLocalDate.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 2016/12/24.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "NSDate+THLocalDate.h"

@implementation NSDate (THLocalDate)

+(NSDate *)getLocalDateWithDate:(NSDate *)date{
    // 获得系统的时区
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    // 获得系统的时区与标准的时间差
    NSTimeInterval time = [zone secondsFromGMTForDate:date];
    // 得到真正的有效时间（本地时区下的）
    return [date dateByAddingTimeInterval:time];
}

@end
