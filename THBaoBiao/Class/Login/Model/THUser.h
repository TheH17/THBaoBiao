//
//  THUser.h
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/10/5.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface THUser : NSObject<NSCoding>


//==================服务器返回数据======================
@property (nonatomic, strong) NSNumber *id;

@property (nonatomic, strong) NSNumber *industry;

@property (nonatomic, strong) NSArray *sites;

@property (nonatomic, copy) NSString *keyword;

@property (nonatomic, copy) NSString *vip;

@property (nonatomic, copy) NSString *password;

@property (nonatomic, copy) NSString *corporation;

@property (nonatomic, copy) NSString *phonenum;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *salt;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, copy) NSString *loginTime;

//==================本地生成数据=======================
@property (nonatomic, strong) NSArray *keywordArray;

@property (nonatomic, strong) NSDate *expiresDate;

@property (nonatomic, copy) NSString *localPage;

@property (nonatomic, copy) NSString *isCheck;

@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *area;
@property (nonatomic, copy) NSString *useLocate;
+(instancetype)userWithDict:(NSDictionary *)resultDict;

-(void)setValue:(id)value forUndefinedKey:(NSString *)key;

@end
