//
//  THCustomBtn.h
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/26.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THCustomBtn : UIButton

/*
 type = 1;上图片下文字，type = 2；左图片，右文字；type=3，右图片，左文字
 */
@property(nonatomic,assign) int type;
@property(nonatomic,assign) int index;


//公开的初始化方法
-(id)initWithIndex:(int)index type:(int)type;

@end
