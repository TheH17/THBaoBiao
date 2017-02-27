//
//  THHotView.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/16.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "THHotView.h"
#import "Masonry.h"

@interface THHotView()

@property (nonatomic, copy) NSString *lastInfo;
@property (nonatomic, copy) NSString *hotInfo;

@property (nonatomic, strong) UIImageView *hotView;
@property (nonatomic, strong) UIImageView *lastView;

@end

@implementation THHotView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self layoutUI];
    }
    return self;
}

-(void)addPic{
    UIImageView *firstView = [[UIImageView alloc]init];
    [firstView setImage:[UIImage imageNamed:@"hotPoint"]];
    firstView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:firstView];
    [firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.height.equalTo(self);
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width / 4 - 10);
    }];
    
    CGFloat y = (self.bounds.size.height - 2 * 25) / 3;
    UIImageView *secondView = [[UIImageView alloc]init];
    [secondView setImage:[UIImage imageNamed:@"last"]];
    secondView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:secondView];
    _lastView = secondView;
    [secondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(y);
        make.left.equalTo(firstView.mas_right).with.offset(15);
        make.height.mas_equalTo(@25);
        make.width.mas_equalTo(@30);
    }];
    
    UIImageView *thirdView = [[UIImageView alloc]init];
    [thirdView setImage:[UIImage imageNamed:@"hot"]];
    thirdView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:thirdView];
    [thirdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(secondView.mas_bottom).with.offset(y);
        make.left.equalTo(firstView.mas_right).with.offset(15);
        make.height.mas_equalTo(@25);
        make.width.mas_equalTo(@30);
    }];
    _hotView = thirdView;
}

-(void)addLabel{
    UILabel *lastLabel = [[UILabel alloc]init];
    lastLabel.text = @"滚动信息示例文字...";
    lastLabel.textAlignment = NSTextAlignmentLeft;
    lastLabel.font = [UIFont systemFontOfSize:0.022*[UIScreen mainScreen].bounds.size.height];
    [self addSubview:lastLabel];
    [lastLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lastView);
        make.left.equalTo(_lastView.mas_right).with.offset(15);
        make.right.equalTo(self);
        make.height.equalTo(_lastView);
    }];
    
    UILabel *hotLabel = [[UILabel alloc]init];
    hotLabel.text = @"滚动信息示例文字示例文字...";
    hotLabel.textAlignment = NSTextAlignmentLeft;
    hotLabel.font = [UIFont systemFontOfSize:0.022*[UIScreen mainScreen].bounds.size.height];
    [self addSubview:hotLabel];
    [hotLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_hotView);
        make.left.equalTo(lastLabel);
        make.right.equalTo(self);
        make.height.equalTo(_hotView);
    }];
    
}

-(void)layoutUI{
    [self addPic];
    [self addLabel];
}

@end
