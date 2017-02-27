//
//  THLocationTool.h
//  THBaoBiao
//
//  Created by 李浩鹏 on 2017/1/15.
//  Copyright © 2017年 李浩鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
@class THLocationData;
@interface THLocationTool : NSObject
+(THLocationData *)getLocationData;

+(void)saveLocationData:(THLocationData *)data;
@end
