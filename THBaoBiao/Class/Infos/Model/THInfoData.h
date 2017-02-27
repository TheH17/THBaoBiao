//
//  THInfoData.h
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/21.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface THInfoData : NSObject<MJKeyValue,NSCoding>

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *category;

@property (nonatomic, copy) NSString *numValue;

@property (nonatomic, copy) NSString *serverNum;

@property (nonatomic, copy) NSString *urlId;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *mirrorUrl;

@property (nonatomic, copy) NSString *textValue;

@property (nonatomic, copy) NSString *damain;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *location;

@property (nonatomic, copy) NSString *orderIndex;

@property (nonatomic, copy) NSString *htmlValue;

@property (nonatomic, copy) NSString *fetchTime;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSDate *dateValue;
//==============本地生成=================
@property (nonatomic, weak) NSNumber *isCheckValue;

@end

