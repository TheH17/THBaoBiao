//
//  THProfileHeaderView.h
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/20.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol THProfileHeaderViewDelegate <NSObject>

-(void)changeInfo:(UIButton *)sender;
-(void)saveInfo;

@end


@interface THProfileHeaderView : UIView

@property (nonatomic, weak) id<THProfileHeaderViewDelegate> delegate;

@end
