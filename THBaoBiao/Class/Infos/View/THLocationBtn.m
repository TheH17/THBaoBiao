//
//  THLocationBtn.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 2017/1/10.
//  Copyright © 2017年 李浩鹏. All rights reserved.
//

#import "THLocationBtn.h"
#import "Masonry.h"

@implementation THLocationBtn

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    CGFloat W = contentRect.size.width;
    CGFloat H = contentRect.size.height;
    return CGRectMake(3*W/4, (H - W/8)/2, W/8, W/8);
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    CGFloat W = contentRect.size.width;
    CGFloat H = contentRect.size.height;
    return CGRectMake(0, 0, 3*W/4, H);
}

@end
