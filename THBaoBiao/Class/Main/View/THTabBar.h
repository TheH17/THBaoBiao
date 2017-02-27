//
//  THTabBar.h
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/12.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol THTabBarDelegate <NSObject>

@optional
-(void)didClickButton:(NSInteger)index;

@end

@interface THTabBar : UIView

// items:保存每一个按钮对应tabBarItem模型
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, weak) id<THTabBarDelegate> delegate;

@end
