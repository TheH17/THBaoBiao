//
//  THInfoResult.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/10/6.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "THInfoResult.h"
#import "THInfoData.h"

#define THInfoArrayKey @"infosArray"

@implementation THInfoResult

//实现该方法就能自动吧数组中的字典转换成对应的模型
+(NSDictionary *)mj_objectClassInArray{
    return @{@"data" : [THInfoData class]};
}

//归档的时候调用的协议里面的方法
//告诉系统哪个属性需要归档
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_data forKey:THInfoArrayKey];
}

//归档的时候调用的协议里面的方法
//告诉系统哪个属性需要归档
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        _data = [aDecoder decodeObjectForKey:THInfoArrayKey];
    }
    return self;
}

@end
