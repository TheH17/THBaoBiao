//
//  UIBarButtonItem+THBarItem.h
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/13.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (THBarItem)

+(UIBarButtonItem *)barButtonItemWithImage:(NSString *)image andSelectedImage:(NSString *)selectedImage andTitle:(NSString *)title andTarget:(id) target Action:(SEL)action forControlEvents:(UIControlEvents)events;

@end
