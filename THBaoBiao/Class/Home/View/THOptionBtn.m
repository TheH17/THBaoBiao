//
//  THOptionBtn.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/17.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "THOptionBtn.h"

@implementation THOptionBtn

-(instancetype)initWithFrame:(CGRect)frame WithType:(int)type{
    if (self = [super initWithFrame:frame]) {
        self.type = type;
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

//-(CGRect)imageRectForContentRect:(CGRect)contentRect{
//    
//    CGFloat W = contentRect.size.width;
//    CGFloat H = contentRect.size.height;
//    if (_type == 1) {
//        //上图片
//        return CGRectMake(0, 0, W, H*3/4.0);
//    }else if(_type == 2){
//        //图片在左
//        return CGRectMake(0, 0, W*1/4.0, H);
//    }else{
//        //图片在右
//        return CGRectMake(W*2/3.0, 0, W*1.0/3, H);
//    }
//    
//}
//
//-(CGRect)titleRectForContentRect:(CGRect)contentRect{
//    
//    CGFloat W = contentRect.size.width;
//    CGFloat H = contentRect.size.height;
//    
//    if (_type == 1) {
//        //文字在下
//        //self.titleLabel.font = [UIFont systemFontOfSize:14];
//        return CGRectMake(0, H*3/4.0+5, W, H/4.0-5);
//    }else if (_type == 2){
//        //文字在右边
//        // self.titleLabel.font = [UIFont systemFontOfSize:14];
//        return CGRectMake(W/4.0, 0, W*3/4.0, H);
//    }else{
//        //文字在左边
//        // self.titleLabel.textColor = [UIColor orangeColor];
//        //self.titleLabel.font = [UIFont systemFontOfSize:16];
//        return CGRectMake(0, 0, W*2/3.0, H);
//    }
//    
//}

@end
