//
//  THChargeFooterView.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/19.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "THChargeFooterView.h"
#import "Masonry.h"

@implementation THChargeFooterView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self layoutUI];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)layoutUI{
    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor colorWithRed:254/255.0 green:117/255.0 blue:34/255.0 alpha:1];
//    button.frame = CGRectMake(20, 10, self.frame.size.width - 40, self.frame.size.height - 20);
    button.layer.cornerRadius = 5;
    [button setTitle:@"立即充值" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:20];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(chargebtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(0.03*h);
        make.right.equalTo(self).with.offset(-0.03*h);
        make.top.equalTo(self).with.offset(0.015*h);
        make.bottom.equalTo(self).with.offset(-0.015*h);
    }];
}

-(void)chargebtnClick{
    if ([_delegate respondsToSelector:@selector(chargeNow)]) {
        [_delegate performSelector:@selector(chargeNow)];
    }
}

@end
