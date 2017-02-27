//
//  THLocationData.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 2017/1/15.
//  Copyright © 2017年 李浩鹏. All rights reserved.
//

#import "THLocationData.h"

#define LATITUDE @"latitude"
#define LONGITUDE @"longitude"
#define ACCURACY @"theAccuracy"
#define LOCATIONCOUNTRY @"LocationCountry"
#define LOCATIONCITY @"LocationCity"
#define LOCATIONAREA @"LocationArea"

@implementation THLocationData

+(instancetype)locationDataWithDict:(NSMutableDictionary *)dict{
    THLocationData *data = [[self alloc]init];
    [data setValuesForKeysWithDictionary:dict];
    return data;
}

//归档的时候调用的协议里面的方法
//告诉系统哪个属性需要归档
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_latitude forKey:LATITUDE];
    [aCoder encodeObject:_longitude forKey:LONGITUDE];
    [aCoder encodeObject:_theAccuracy forKey:ACCURACY];
    [aCoder encodeObject:_LocationProvince forKey:LOCATIONCOUNTRY];
    [aCoder encodeObject:_LocationCity forKey:LOCATIONCITY];
    [aCoder encodeObject:_LocationArea forKey:LOCATIONAREA];
}

//归档的时候调用的协议里面的方法
//告诉系统哪个属性需要归档
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        _latitude = [aDecoder decodeObjectForKey:LATITUDE];
        _longitude = [aDecoder decodeObjectForKey:LONGITUDE];
        _theAccuracy = [aDecoder decodeObjectForKey:ACCURACY];
        _LocationProvince = [aDecoder decodeObjectForKey:LOCATIONCOUNTRY];
        _LocationCity = [aDecoder decodeObjectForKey:LOCATIONCITY];
        _LocationArea = [aDecoder decodeObjectForKey:LOCATIONAREA];
    }
    return self;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
