//
//  THKeyWordResult.h
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/10/10.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface THKeyWordResult : NSObject<NSCoding>

@property (nonatomic, strong) NSArray *words;
@property (nonatomic, copy) NSString *localPage;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *area;
@property (nonatomic, copy) NSString *useLocate;
+(instancetype)keyWordResultWithString:(NSString *)string;
+(instancetype)keyWordResultWithEmptyString;
-(void)setValue:(id)value forUndefinedKey:(NSString *)key;
@end
