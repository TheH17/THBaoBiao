//
//  THUser.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/10/5.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "THUser.h"

#import "THLoginResult.h"
#import "NSDate+THLocalDate.h"

#define THUserIDKey @"userID"
#define THUserIndustryKey @"userIndustry"
#define THUserSitesKey @"userSites"
#define THUserKeyWordKey @"userKeyWord"
#define THUserKeywordArrayKey @"userKeyWordArray"
#define THUserVipKey @"userVip"
#define THUserPassKey @"userPass"
#define THUserCorporationKey @"userCorporation"
#define THUserPhonenumKey @"userphonenum"
#define THUserNameKey @"userName"
#define THUserSaltKey @"usersalt"
#define THUserEmailKey @"userEmail"
#define THUserLoginTimeKey @"userLoginTime"
#define THUserLocalPageKey @"userLocalPage"
#define THUserIsCheckKey @"userischeck"
#define THUserExpiresDateKey @"userexpiresDate"

#define THUserProvinceKey @"userProvince"
#define THUserCityKey @"userCity"
#define THUserAreaKey @"userArea"
#define THUserUseLocateKey @"UseruseLocate"

@implementation THUser

-(NSArray *)sites{
    if (!_sites) {
        _sites = [NSArray array];
    }
    return _sites;
}

-(NSArray *)keywordArray{
    if (_keywordArray.count == 1 && [_keywordArray[0] isEqualToString:@""]) {
        _keywordArray = [NSArray array];
    }
    return _keywordArray;
}

+(instancetype)userWithDict:(NSDictionary *)resultDict{
    THUser *user = [[self alloc] init];
    [user setValuesForKeysWithDictionary:resultDict[@"user"]];
    
    //========设置有效时间=============
    // 获得零时区下的有效时间
    NSDate *tmpDate = [NSDate dateWithTimeIntervalSinceNow:THExpiresDay * 24 * 60 * 60];
    //得到本地时区下的时间
    user.expiresDate = [NSDate getLocalDateWithDate:tmpDate];
    
    //=========设置网站===============
    THLoginResult *result = [THLoginResult mj_objectWithKeyValues:resultDict];
    user.sites = [result.sites mutableCopy];
    //========设置关键词=============
    if (!user.keyword||[user.keyword isEqual:[NSNull null]]||[user.keyword isEqualToString:@""]){
        user.keywordArray = [NSArray array];
    }else{
        user.keywordArray = [[user.keyword componentsSeparatedByString:@","] copy];
    }
    //========设置其他信息=============
    user.localPage = @"0";
    user.isCheck = @"NO";
    user.province = nil;
    user.city = nil;
    user.area = nil;
    user.useLocate = @"NO";
    return user;
}

//归档的时候调用的协议里面的方法
//告诉系统哪个属性需要归档
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_id forKey:THUserIDKey];
    [aCoder encodeObject:_industry forKey:THUserIndustryKey];
    [aCoder encodeObject:_sites forKey:THUserSitesKey];
    [aCoder encodeObject:_keyword forKey:THUserKeyWordKey];
    [aCoder encodeObject:_keywordArray forKey:THUserKeywordArrayKey];
    [aCoder encodeObject:_vip forKey:THUserVipKey];
    [aCoder encodeObject:_password forKey:THUserPassKey];
    [aCoder encodeObject:_corporation forKey:THUserCorporationKey];
    [aCoder encodeObject:_phonenum forKey:THUserPhonenumKey];
    [aCoder encodeObject:_username forKey:THUserNameKey];
    [aCoder encodeObject:_salt forKey:THUserSaltKey];
    [aCoder encodeObject:_email forKey:THUserEmailKey];
    [aCoder encodeObject:_loginTime forKey:THUserLoginTimeKey];
    [aCoder encodeObject:_localPage forKey:THUserLocalPageKey];
    [aCoder encodeObject:_isCheck forKey:THUserIsCheckKey];
    [aCoder encodeObject:_expiresDate forKey:THUserExpiresDateKey];
    [aCoder encodeObject:_province forKey:THUserProvinceKey];
    [aCoder encodeObject:_city forKey:THUserCityKey];
    [aCoder encodeObject:_area forKey:THUserAreaKey];
    [aCoder encodeObject:_useLocate forKey:THUserUseLocateKey];
}

//归档的时候调用的协议里面的方法
//告诉系统哪个属性需要归档
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        _id = [aDecoder decodeObjectForKey:THUserIDKey];
        _industry = [aDecoder decodeObjectForKey:THUserIndustryKey];
        _sites = [aDecoder decodeObjectForKey:THUserSitesKey];
        _keyword = [aDecoder decodeObjectForKey:THUserKeyWordKey];
        _keywordArray = [aDecoder decodeObjectForKey:THUserKeywordArrayKey];
        _vip = [aDecoder decodeObjectForKey:THUserVipKey];
        _password = [aDecoder decodeObjectForKey:THUserPassKey];
        _corporation = [aDecoder decodeObjectForKey:THUserCorporationKey];
        _phonenum = [aDecoder decodeObjectForKey:THUserPhonenumKey];
        _username = [aDecoder decodeObjectForKey:THUserNameKey];
        _salt = [aDecoder decodeObjectForKey:THUserSaltKey];
        _email = [aDecoder decodeObjectForKey:THUserEmailKey];
        _loginTime = [aDecoder decodeObjectForKey:THUserLoginTimeKey];
        _localPage = [aDecoder decodeObjectForKey:THUserLocalPageKey];
        _isCheck = [aDecoder decodeObjectForKey:THUserIsCheckKey];
        _expiresDate = [aDecoder decodeObjectForKey:THUserExpiresDateKey];
        _province = [aDecoder decodeObjectForKey:THUserProvinceKey];
        _city = [aDecoder decodeObjectForKey:THUserCityKey];
        _area = [aDecoder decodeObjectForKey:THUserAreaKey];
        _useLocate = [aDecoder decodeObjectForKey:THUserUseLocateKey];
    }
    return self;
}

//用于防止字典中有的元素model中没有
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
