//
//  THaddWordAndSiteView.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/27.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "THaddWordAndSiteView.h"
#import "THAddKeyWordView.h"
#import "THAddWebSiteView.h"

@interface THaddWordAndSiteView()<UIGestureRecognizerDelegate, THAddWordDelegate, THAddWebDelegate>

@end

@implementation THaddWordAndSiteView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //添加手势处理器
        UISwipeGestureRecognizer *tap = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handSwipe)];
        tap.direction = UISwipeGestureRecognizerDirectionDown;
        tap.delegate = self;
        [self addGestureRecognizer:tap];
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    }
    return self;
}

-(void)setType:(int)type{
    _type = type;
    [self layoutUI];
}

-(void)layoutUI{
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    if (_type == 0) {
        THAddKeyWordView *wordView = [[THAddKeyWordView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 0.37*height, self.frame.size.width, 0.37*height)];
        wordView.delegate = self;
        wordView.fatherView = self;
        [self addSubview:wordView];
    }else{
        THAddWebSiteView *siteView = [[THAddWebSiteView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 0.52*height, self.frame.size.width, 0.52*height)];
        siteView.delegate = self;
        siteView.fatherView = self;
        [self addSubview:siteView];
    }
}

#pragma mark UISwipeGestureRecognizerDelegate
-(void)handSwipe{
    [self.delegate performSelector:@selector(closeAddWordSiteView)];
}

#pragma UIGestureRecognizationDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isMemberOfClass:[UIView class]]) {
        return NO;
    }else
        return YES;
}

#pragma THAddWordDelegate
-(void)closeInputWord{
    [self handSwipe];
}
-(void)successFulAddWord{
    [self.delegate performSelector:@selector(successFulAddData)];
}

#pragma THAddWebDelegate
-(void)closeInputSite{
    [self handSwipe];
}
-(void)successFulAddWeb{
    [self.delegate performSelector:@selector(successFulAddData)];
}

@end
