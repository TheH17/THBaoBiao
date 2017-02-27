//
//  UIImage+THImage.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/12.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "UIImage+THImage.h"

@implementation UIImage (THImage)

//建立一个没有经过渲染的原始图片
+(instancetype)imageWithName:(NSString *)name{
    UIImage *image = [UIImage imageNamed:name];
    
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+(instancetype)imageWithStretchableName:(NSString *)name{
    UIImage *image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}
@end