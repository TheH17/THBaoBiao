//
//  THOptionBtn.h
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/17.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THOptionBtn : UIButton

@property (nonatomic, assign) int type;

-(instancetype)initWithFrame:(CGRect)frame WithType:(int)type;

@end
