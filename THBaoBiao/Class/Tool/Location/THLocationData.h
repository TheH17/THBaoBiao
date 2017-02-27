//
//  THLocationData.h
//  THBaoBiao
//
//  Created by 李浩鹏 on 2017/1/15.
//  Copyright © 2017年 李浩鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface THLocationData : NSObject<NSCoding>

@property (nonatomic, copy) NSString *LocationArea;
@property (nonatomic, copy) NSString *LocationCity;
@property (nonatomic, copy) NSString *LocationProvince;
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, copy) NSString *theAccuracy;

+(instancetype)locationDataWithDict:(NSMutableDictionary *)dict;
-(void)setValue:(id)value forUndefinedKey:(NSString *)key;
@end
