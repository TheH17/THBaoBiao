//
//  NSArray+THLocationPick.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 2017/1/16.
//  Copyright © 2017年 李浩鹏. All rights reserved.
//

#import "NSArray+THLocationPick.h"

@implementation NSArray (THLocationPick)

- (id)objectAtIndexCheck:(NSUInteger)index
{
//    if (index >= [self count]) {
//        return nil;
//    }
//    
//    id value = [self objectAtIndex:index];
//    if (value == [NSNull null]) {
//        return nil;
//    }
//    return value;
    if (index >= [self count]) {
        return [self objectAtIndex:[self count]];
    }else{
        return [self objectAtIndex:index];
    }
}

@end
