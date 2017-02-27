//
//  THCustomBtn.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/26.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "THCustomBtn.h"
#import "Masonry.h"

#define HEIGHT [UIScreen mainScreen].bounds.size.height

#define WIDTH [UIScreen mainScreen].bounds.size.width

@implementation THCustomBtn

//初始化方法
-(id)initWithIndex:(int)index type:(int)type{
    self = [super init];
    if (self) {
        //指定类型
        self.type = type;
        self.index = index;
        (index == 1) ? [self makeConstraintsForSubviewWithIndexOne] : [self makeConstraintsForSubviewWithIndexTwo];
    }
    return self;
}

-(void)makeConstraintsForSubviewWithIndexOne{
    
    self.backgroundColor = [UIColor colorWithRed:248/255.0 green:249/255.0 blue:250/255.0 alpha:1];
    (_type==0) ? [self setTitle:@"添加搜索关键词" forState:UIControlStateNormal] : [self setTitle:@"添加搜索新网站" forState:UIControlStateNormal];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:22];
    [self.titleLabel sizeToFit];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [UIColor colorWithRed:218/255.0 green:219/255.0 blue:219/255.0 alpha:1].CGColor;
    [self setImage:[UIImage imageNamed:@"添加框"] forState:UIControlStateNormal];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self).with.offset(35);
    }];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left).with.offset(-35);
        make.width.and.height.mas_equalTo(@35);
    }];
}

-(void)makeConstraintsForSubviewWithIndexTwo{
    
    self.backgroundColor = [UIColor colorWithRed:248/255.0 green:249/255.0 blue:250/255.0 alpha:1];
    (_type == 0) ? [self setTitle:@"已添加关键词" forState:UIControlStateNormal] : [self setTitle:@"已添加新网站" forState:UIControlStateNormal];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:20];
    self.layer.cornerRadius = 5;
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [UIColor colorWithRed:218/255.0 green:219/255.0 blue:219/255.0 alpha:1].CGColor;
    [self setImage:[UIImage imageNamed:@"文件夹"] forState:UIControlStateNormal];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(10);
        make.width.and.height.mas_equalTo(@35);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageView.mas_right).with.offset(20);
    }];
}

//-(CGRect)imageRectForContentRect:(CGRect)contentRect{
//    
//    CGFloat W = contentRect.size.width;
//    CGFloat H = contentRect.size.height;
//    if (_type == 1) {
//        //上图片
//        return CGRectMake(0.2667*[UIScreen mainScreen].bounds.size.width, (H - H / 2)/2, H/2, H/2);
//    }else if(_type == 2){
//        //图片在左
//        return CGRectMake(0.0533*[UIScreen mainScreen].bounds.size.width, (H - 35)/2, 35, 35);
//    }else{
//        //图片在右
//        return CGRectMake(W*2/3.0, 0, W*1.0/3, H);
//    }
//    
//}

//-(CGRect)titleRectForContentRect:(CGRect)contentRect{
//    
//    CGFloat W = contentRect.size.width;
//    CGFloat H = contentRect.size.height;
//    
//    if (_type == 1) {
//        //文字在下
//        //self.titleLabel.font = [UIFont systemFontOfSize:14];
//        return CGRectMake(W/4.0 - 20, 0, W*3/4.0, H);
//    }else if (_type == 2){
//        //文字在右边
//        // self.titleLabel.font = [UIFont systemFontOfSize:14];
//        return CGRectMake(0, 0, W*3/4.0, H);
//    }else{
//        //文字在左边
//        // self.titleLabel.textColor = [UIColor orangeColor];
//        //self.titleLabel.font = [UIFont systemFontOfSize:16];
//        return CGRectMake(0, 0, W*2/3.0, H);
//    }
//    
//}

@end
