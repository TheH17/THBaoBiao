//
//  THProvince.h
//  THBaoBiao
//
//  Created by 李浩鹏 on 2017/1/10.
//  Copyright © 2017年 李浩鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface THProvince : NSObject<MJKeyValue>

@property (nonatomic, strong) NSString       *name;/**< 省名字*/
@property (nonatomic, strong) NSArray        * cities;/**< 该省包含的所有城市名称*/

/**
 *  初始化省份
 *
 *  @param name   省名字
 *  @param cities 省包含的所有城市名字
 *
 *  @return 初始化省份
 */
- (instancetype)initWithName:(NSString *)name
                      cities:(NSArray *)cities;

/**
 *  初始化省份
 *
 *  @param name   省名字
 *  @param cities 省包含的所有城市名字
 *
 *  @return 初始化省份
 */
+ (instancetype)provinceWithName:(NSString *)name
                          cities:(NSArray *)cities;

@end
