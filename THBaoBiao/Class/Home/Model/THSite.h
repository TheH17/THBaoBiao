//
//  THSite.h
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/10/10.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface THSite : NSObject<MJKeyValue, NSCoding>

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *startUrl;

@property (nonatomic, copy) NSString *siteId;

@property (nonatomic, copy) NSString *sitename;

-(void)setValue:(id)value forUndefinedKey:(NSString *)key;

@end
