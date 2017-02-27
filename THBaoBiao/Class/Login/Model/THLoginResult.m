//
//  THLoginResult.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 2016/12/6.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "THLoginResult.h"
#import "THSite.h"

@implementation THLoginResult

//实现该方法就能自动吧数组中的字典转换成对应的模型
+(NSDictionary *)mj_objectClassInArray{
    return @{@"sites" : [THSite class]};
}

-(NSArray *)sites{
    if (!_sites) {
        _sites = [NSArray array];
    }
    return _sites;
}

@end
