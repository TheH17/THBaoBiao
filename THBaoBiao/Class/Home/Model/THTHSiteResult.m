//
//  THTHSiteResult.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/10/10.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "THTHSiteResult.h"
#import "THSite.h"

@implementation THTHSiteResult

//实现该方法就能自动吧数组中的字典转换成对应的模型
+(NSDictionary *)mj_objectClassInArray{
    return @{@"sites" : [THSite class]};
}

-(NSArray *)sites{
    if (!_sites) {
        _sites = [NSArray array];
    }
    return _sites;
}

////归档的时候调用的协议里面的方法
////告诉系统哪个属性需要归档
//-(void)encodeWithCoder:(NSCoder *)aCoder{
////    [aCoder encodeObject:_sitenames forKey:THsitenamesKey];
//    [aCoder encodeObject:_sites forKey:THsitesKey];
//}
//
////归档的时候调用的协议里面的方法
////告诉系统哪个属性需要归档
//-(instancetype)initWithCoder:(NSCoder *)aDecoder{
//    if (self = [super init]) {
////        _sitenames = [aDecoder decodeObjectForKey:THsitenamesKey];
//        _sites = [aDecoder decodeObjectForKey:THsitesKey];
//    }
//    return self;
//}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
