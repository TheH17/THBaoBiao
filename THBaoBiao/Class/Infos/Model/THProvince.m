//
//  THProvince.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 2017/1/10.
//  Copyright © 2017年 李浩鹏. All rights reserved.
//

#import "THProvince.h"

@implementation THProvince

+(instancetype)provinceWithName:(NSString *)name cities:(NSArray *)cities{
    return [[self alloc]initWithName:name cities:cities];
}

-(instancetype)initWithName:(NSString *)name cities:(NSArray *)cities{
    if (self = [super init]) {
        _name = name;
        _cities = cities;
    }
    return self;
}

@end
