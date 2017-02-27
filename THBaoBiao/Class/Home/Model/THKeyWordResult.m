//
//  THKeyWordResult.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/10/10.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "THKeyWordResult.h"

#define THKeyWordArrayKey @"wordArray"
#define THKeyWordLocalPageKey @"wordlocalPage"

#define THKeyWordProvinceKey @"KeyWordProvince"
#define THKeyWordCityKey @"KeyWordCity"
#define THKeyWordAreaKey @"KeyWordArea"
#define THKeyWordUseLocateKey @"KeyWorduseLocate"

@implementation THKeyWordResult

+(instancetype)keyWordResultWithString:(NSString *)string{
    THKeyWordResult *wordResult = [[self alloc]init];
    wordResult.words = [[string componentsSeparatedByString:@","] copy];
    wordResult.localPage = @"0";
    wordResult.province = nil;
    wordResult.city = nil;
    wordResult.area = nil;
    wordResult.useLocate = @"NO";
    return wordResult;
}

+(instancetype)keyWordResultWithEmptyString{
    THKeyWordResult *wordResult = [[self alloc]init];
    wordResult.words = [NSArray array];
    wordResult.localPage = @"0";
    wordResult.province = nil;
    wordResult.city = nil;
    wordResult.area = nil;
    wordResult.useLocate = @"NO";
    return wordResult;
}

-(NSArray *)words{
    if (_words.count == 1 && [_words[0] isEqualToString:@""]) {
        _words = [NSArray array];
    }
    return _words;
}

//归档的时候调用的协议里面的方法
//告诉系统哪个属性需要归档
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_words forKey:THKeyWordArrayKey];
    [aCoder encodeObject:_localPage forKey:THKeyWordLocalPageKey];
    [aCoder encodeObject:_province forKey:THKeyWordProvinceKey];
    [aCoder encodeObject:_city forKey:THKeyWordCityKey];
    [aCoder encodeObject:_area forKey:THKeyWordAreaKey];
    [aCoder encodeObject:_useLocate forKey:THKeyWordUseLocateKey];
}

//归档的时候调用的协议里面的方法
//告诉系统哪个属性需要归档
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        _words = [aDecoder decodeObjectForKey:THKeyWordArrayKey];
        _localPage = [aDecoder decodeObjectForKey:THKeyWordLocalPageKey];
        _province = [aDecoder decodeObjectForKey:THKeyWordProvinceKey];
        _city = [aDecoder decodeObjectForKey:THKeyWordCityKey];
        _area = [aDecoder decodeObjectForKey:THKeyWordAreaKey];
        _useLocate = [aDecoder decodeObjectForKey:THKeyWordUseLocateKey];
    }
    return self;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
