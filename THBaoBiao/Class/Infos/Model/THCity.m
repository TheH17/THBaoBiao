//
//  THCity.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 2017/1/10.
//  Copyright © 2017年 李浩鹏. All rights reserved.
//

#import "THCity.h"

@implementation THCity

+(instancetype)cityWithName:(NSString *)name areas:(NSArray *)areas{
    return [[self alloc]initWithName:name areas:areas];
}

-(instancetype)initWithName:(NSString *)name areas:(NSArray *)areas{
    if (self = [super init]) {
        _name = name;
        _areas = areas;
    }
    return self;
}

@end
