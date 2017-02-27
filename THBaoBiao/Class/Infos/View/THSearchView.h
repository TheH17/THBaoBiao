//
//  THSearchView.h
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/21.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol THSearchViewDelegate <NSObject>

-(void)searchFromResultWithKeyWord:(NSString *)keyword;

@end

@interface THSearchView : UIView

-(instancetype)initWithFrame:(CGRect)frame;

@property (nonatomic, weak) id<THSearchViewDelegate> delegate;

@end
