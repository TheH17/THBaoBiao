//
//  THInfoHeaderView.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/22.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "THInfoHeaderView.h"
#import "Masonry.h"

@interface THInfoHeaderView()

@property (nonatomic, strong) UIButton *nameView;
@property (nonatomic, strong) UIImageView *arrowView;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation THInfoHeaderView

static NSString * const reuseIdentifier = @"InfoListViewHeader";

+(instancetype)headerViewFromTableView:(UITableView *)tableView{
    THInfoHeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseIdentifier];
    if (!view) {
        view = [[THInfoHeaderView alloc]initWithReuseIdentifier:reuseIdentifier];
    }
    return view;
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self layoutUI];
        self.contentView.layer.borderWidth = 0.3;
        self.contentView.layer.borderColor = [UIColor colorWithRed:220/255.0 green:221/255.0 blue:222/255.0 alpha:1].CGColor;
    }
    return self;
}

-(void)layoutUI{
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    //1
    UIButton *nameView = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:nameView];
    
//    [nameView setTitle:@"招标信息" forState:UIControlStateNormal];
//    [nameView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    //设置图片旋转的时候可以保持不变形
//    
//    nameView.imageView.contentMode =  UIViewContentModeScaleAspectFit;
//    
//    nameView.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    nameView.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
//    nameView.titleEdgeInsets = UIEdgeInsetsMake(0, 40, 0, 0);
    [nameView setBackgroundColor:[UIColor whiteColor]];
    [nameView addTarget:self action:@selector(nameClick) forControlEvents:UIControlEventTouchUpInside];
    self.nameView = nameView;
    [nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.and.bottom.equalTo(self);
    }];
    //2
    UIImageView *arrowView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"箭头"]];
    arrowView.contentMode = UIViewContentModeScaleAspectFit;
    arrowView.clipsToBounds = NO;
    [nameView addSubview: arrowView];
    self.arrowView = arrowView;
    [self.arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameView).with.offset(0.0225*height);
        make.right.equalTo(nameView).with.offset(-0.0267*height);
        make.width.and.height.mas_equalTo(0.03*height);
    }];
    //3
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"招标信息"]];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [nameView addSubview: imageView];
    self.imageView = imageView;
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameView).with.offset(0.0225*height);
        make.left.equalTo(nameView).with.offset(0.04*width);
        make.width.and.height.mas_equalTo(0.03*height);
    }];
    //4
    UILabel *label = [[UILabel alloc]init];
    label.text = @"招标信息";
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:20];
    [label sizeToFit];
    label.textColor = [UIColor blackColor];
    [nameView addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView);
        make.left.equalTo(imageView.mas_right).with.offset(0.04*width);
    }];
    
    
}

-(void)nameClick{
    self.open = !self.open;
    if (self.open) {
        self.arrowView.transform = CGAffineTransformMakeRotation(M_PI_2);
    }else{
        self.arrowView.transform = CGAffineTransformMakeRotation(0);
    }
    if ([self.delegate respondsToSelector:@selector(headerViewDidClick)]) {
        [self.delegate performSelector:@selector(headerViewDidClick)];
    }
}


-(void)setOpen:(BOOL)open{
    _open = open;
    if (self.open) {
        self.arrowView.transform = CGAffineTransformMakeRotation(M_PI_2);
    }else{
        self.arrowView.transform = CGAffineTransformMakeRotation(0);
    }
}

@end
