//
//  THSearchView.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/21.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "THSearchView.h"
#import "Masonry.h"

@interface THSearchView()

@property (nonatomic, strong) UITextField *textField;

@end

@implementation THSearchView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self layoutUI];
        self.backgroundColor = [UIColor colorWithRed:243/255.0 green:244/255.0 blue:246/255.0 alpha:1];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handTap)];
        tap.numberOfTapsRequired = 1;
        [self addGestureRecognizer:tap];
    }
    return self;
}
-(void)handTap{
    [self.textField resignFirstResponder];
}

-(void)btnClick{
    [self.textField resignFirstResponder];
    [self.delegate searchFromResultWithKeyWord:self.textField.text];
}

-(void)layoutUI{
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    UITextField *textField = [[UITextField alloc]init];
    textField.font = [UIFont systemFontOfSize:20];
    textField.layer.borderWidth = 1.5;
    textField.layer.cornerRadius = 5;
    textField.layer.borderColor = [UIColor colorWithRed:225/255.0 green:226/255.0 blue:227/255.0 alpha:1].CGColor;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.placeholder = @"在结果中精确搜索";
    [self addSubview:textField];
    _textField = textField;
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(0.0267*width);
        make.top.equalTo(self).with.offset(0.015*height);
        make.bottom.equalTo(self).with.offset(-0.015*height);
        make.width.mas_equalTo(0.7733*width);
    }];
    
    //创建左边的图标
    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search"]];
    //图片过于集中在左边，为了左右都留下间隙
    imgView.width += 10;
    imgView.contentMode = UIViewContentModeCenter;
    textField.leftView = imgView;
    textField.leftViewMode = UITextFieldViewModeAlways;

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.layer.borderWidth = 0;
    [button setTitle:@"确定" forState:UIControlStateNormal];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:20];
    [button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchDown];
    [self addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(textField.mas_right).with.offset(0.04*width);
        make.top.equalTo(self).with.offset(0.02255*height);
        make.bottom.equalTo(self).with.offset(-0.02255*height);
        make.width.mas_equalTo(0.1333*width);
    }];
}

@end
