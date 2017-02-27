//
//  THShareView.h
//  THBaoBiao
//
//  Created by 李浩鹏 on 2016/12/18.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol THShareDelegate <NSObject>

-(void)closeShareView;

-(void)shareWithType:(int)type;

@end

@interface THShareView : UIView

@property (nonatomic, weak) id<THShareDelegate> delegate;

@end
