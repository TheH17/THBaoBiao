//
//  THSite.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/10/10.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "THSite.h"

#define THsitenameKey @"sitename"
#define THstartUrlKey @"startUrl"

#define THsiteidKey @"siteid"
#define THsiteuseridKey @"siteuserid"
#define THsiteIdKey @"siteID"


@implementation THSite

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}


-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_sitename forKey:THsitenameKey];
    [aCoder encodeObject:_startUrl forKey:THstartUrlKey];
    [aCoder encodeObject:_siteId forKey:THsiteidKey];
    [aCoder encodeObject:_userId forKey:THsiteuseridKey];
    [aCoder encodeObject:_id forKey:THsiteIdKey];
}

//归档的时候调用的协议里面的方法
//告诉系统哪个属性需要归档
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        _sitename = [aDecoder decodeObjectForKey:THsitenameKey];
        _startUrl = [aDecoder decodeObjectForKey:THstartUrlKey];
        _siteId = [aDecoder decodeObjectForKey:THsiteidKey];
        _userId = [aDecoder decodeObjectForKey:THsiteuseridKey];
        _id = [aDecoder decodeObjectForKey:THsiteIdKey];
    }
    return self;
}

@end
