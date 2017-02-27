//
//  THInfoData.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/21.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "THInfoData.h"

#define THInfoDataId @"info_dataId"
#define THInfoUrlKey @"info_url"
#define THMirrorUrlKey @"info_mirror_url"
#define THInfoCodeKey @"info_code"
#define THInfoNameKey @"info_name"
#define THInfoCategoryKey @"info_category"
#define THInfoOrderIndexKey @"info_order_index"
#define THInfoFetchTimeKey @"info_fetch_time"
#define THInfoTextValueKey @"info_text_value"
#define THInfoHtmlValueKey @"info_html_value"
#define THInfoDateValueKey @"info_date_value"
#define THInfoNumValueKey @"info_num_value"
#define THInfoServerNumKey @"info_server_num"
#define THInfoDaminKey @"info_damain"
#define THInfoUrlIdKey @"info_url_id"
#define THInfoLocationKey @"info_location"
#define THInfoIsCheckKey @"info_isCheck"

@implementation THInfoData

-(instancetype)init{
    self = [super init];
    _isCheckValue = [NSNumber numberWithBool:NO];
    return self;
}

//归档的时候调用的协议里面的方法
//告诉系统哪个属性需要归档
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_id forKey:THInfoDataId];
    [aCoder encodeObject:_url forKey:THInfoUrlKey];
    [aCoder encodeObject:_mirrorUrl forKey:THMirrorUrlKey];
    [aCoder encodeObject:_code forKey:THInfoCodeKey];
    [aCoder encodeObject:_name forKey:THInfoNameKey];
    [aCoder encodeObject:_category forKey:THInfoCategoryKey];
    [aCoder encodeObject:_orderIndex forKey:THInfoOrderIndexKey];
    [aCoder encodeObject:_fetchTime forKey:THInfoFetchTimeKey];
    [aCoder encodeObject:_textValue forKey:THInfoTextValueKey];
    [aCoder encodeObject:_htmlValue forKey:THInfoHtmlValueKey];
    [aCoder encodeObject:_dateValue forKey:THInfoDateValueKey];
    [aCoder encodeObject:_numValue forKey:THInfoNumValueKey];
    [aCoder encodeObject:_serverNum forKey:THInfoServerNumKey];
    [aCoder encodeObject:_damain forKey:THInfoDaminKey];
    [aCoder encodeObject:_urlId forKey:THInfoUrlIdKey];
    [aCoder encodeObject:_location forKey:THInfoLocationKey];
    [aCoder encodeObject:_isCheckValue forKey:THInfoIsCheckKey];
}

//归档的时候调用的协议里面的方法
//告诉系统哪个属性需要归档
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        _id = [aDecoder decodeObjectForKey:THInfoDataId];
        _url = [aDecoder decodeObjectForKey:THInfoUrlKey];
        _mirrorUrl = [aDecoder decodeObjectForKey:THMirrorUrlKey];
        _code = [aDecoder decodeObjectForKey:THInfoCodeKey];
        _name = [aDecoder decodeObjectForKey:THInfoNameKey];
        _category = [aDecoder decodeObjectForKey:THInfoCategoryKey];
        _orderIndex = [aDecoder decodeObjectForKey:THInfoOrderIndexKey];
        _fetchTime = [aDecoder decodeObjectForKey:THInfoFetchTimeKey];
        _textValue = [aDecoder decodeObjectForKey:THInfoTextValueKey];
        _htmlValue = [aDecoder decodeObjectForKey:THInfoHtmlValueKey];
        _dateValue = [aDecoder decodeObjectForKey:THInfoDateValueKey];
        _numValue = [aDecoder decodeObjectForKey:THInfoNumValueKey];
        _serverNum = [aDecoder decodeObjectForKey:THInfoServerNumKey];
        _damain = [aDecoder decodeObjectForKey:THInfoDaminKey];
        _urlId = [aDecoder decodeObjectForKey:THInfoUrlIdKey];
        _location = [aDecoder decodeObjectForKey:THInfoLocationKey];
        _isCheckValue = [aDecoder decodeObjectForKey:THInfoIsCheckKey];
    }
    return self;
}

//用于防止字典中有的元素model中没有
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
