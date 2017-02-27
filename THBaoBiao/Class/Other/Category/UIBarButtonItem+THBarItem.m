//
//  UIBarButtonItem+THBarItem.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/13.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "UIBarButtonItem+THBarItem.h"

@implementation UIBarButtonItem (THBarItem)

+(UIBarButtonItem *)barButtonItemWithImage:(NSString *)image andSelectedImage:(NSString *)selectedImage andTitle:(NSString *)title andTarget:(id) target Action:(SEL)action forControlEvents:(UIControlEvents)events{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateSelected];
    
    [btn sizeToFit];
    CGRect frame = btn.imageView.frame;
    btn.imageView.frame = CGRectMake(frame.origin.x, frame.origin.y, 20, 20);
    btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [btn addTarget:target action:action forControlEvents:events];
    
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
    
}

@end
