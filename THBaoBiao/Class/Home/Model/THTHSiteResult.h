//
//  THTHSiteResult.h
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/10/10.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface THTHSiteResult : NSObject<MJKeyValue>

@property (nonatomic, strong) NSArray *sites;
-(void)setValue:(id)value forUndefinedKey:(NSString *)key;

@end
