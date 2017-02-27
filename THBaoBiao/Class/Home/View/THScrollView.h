//
//  THScrollView.h
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/15.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol THScrollDelegate <NSObject>

-(void)didClickImg:(long)type;

@end

@interface THScrollView : UIView<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIPageControl *pageConl;

@property (nonatomic, strong) NSArray *imgs;

@property (nonatomic, weak) id<THScrollDelegate> delegate;

@end
