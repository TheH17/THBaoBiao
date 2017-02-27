//
//  THNewFeatureCell.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/10/24.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "THNewFeatureCell.h"
#import "THTabBarController.h"

@interface THNewFeatureCell()

@property (nonatomic, strong) UIButton *startButton;

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation THNewFeatureCell

-(UIButton *)startButton{
    if (!_startButton) {
        _startButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_startButton setTitle:@"  开启应用  " forState:UIControlStateNormal];
        [_startButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_startButton sizeToFit];
        _startButton.layer.cornerRadius = 7;
        [_startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_startButton];
    }
    return _startButton;
}

-(void)start{
    THTabBarController *tabBarVc = [[THTabBarController alloc] init];
    //登陆成功
//    [UIView animateWithDuration:1.0 animations:^{
        THKeyWindow.rootViewController = tabBarVc;
//    }];
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}

-(void)setImage:(UIImage *)image{
    _image = image;
    self.imageView.image = image;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
    
    _startButton.center = CGPointMake(self.width * 0.5, self.height * 0.85);
    
}

-(void)checkBtnFromIndexPath:(NSIndexPath *)indexPath andCount:(int)count{
    if (indexPath.row == count - 1) {
        self.startButton.backgroundColor = [UIColor colorWithRed:254/255.0 green:180/255.0 blue:26/255.0 alpha:1];
    }else{
        self.startButton.backgroundColor = [UIColor colorWithRed:37/255.0 green:61/255.0 blue:248/255.0 alpha:1];
    }
}

@end
