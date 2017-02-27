//
//  THCity.h
//  THBaoBiao
//
//  Created by 李浩鹏 on 2017/1/10.
//  Copyright © 2017年 李浩鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface THCity : NSObject

@property (nonatomic ,strong) NSString * name;/**< 城市名*/
@property (nonatomic ,strong) NSArray  * areas;/**< 城市包含的所有地区*/

/**
 *  初始化城市
 *
 *  @param name  城市名字
 *  @param areas 城市包含的地区
 *
 *  @return 初始化城市
 */
- (instancetype)initWithName:(NSString *)name
                       areas:(NSArray *)areas;

/**
 *  初始化城市
 *
 *  @param cityName 城市名字
 *  @param areas    城市包含的地区
 *
 *  @return 初始化城市
 */
+ (instancetype)cityWithName:(NSString *)name
                       areas:(NSArray *)areas;

@end
