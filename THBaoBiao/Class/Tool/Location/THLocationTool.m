//
//  THLocationTool.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 2017/1/15.
//  Copyright © 2017年 李浩鹏. All rights reserved.
//

#import "THLocationTool.h"
#import "THLocationData.h"

#define THLocationFileName [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"userLocationData.dat"]

@implementation THLocationTool
static THLocationData *_data;

+(THLocationData *)getLocationData{
    _data = [NSKeyedUnarchiver unarchiveObjectWithFile:THLocationFileName];
    return _data;
}

+(void)saveLocationData:(THLocationData *)data{
    [NSKeyedArchiver archiveRootObject:data toFile:THLocationFileName];
}

@end
