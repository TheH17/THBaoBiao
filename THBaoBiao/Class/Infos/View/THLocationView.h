//
//  THLocationView.h
//  THBaoBiao
//
//  Created by 李浩鹏 on 2017/1/10.
//  Copyright © 2017年 李浩鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol THLocationDelegate <NSObject>

-(void)showAddressPickView;

@end

@interface THLocationView : UIView

@property (nonatomic, weak) id<THLocationDelegate> delegate;

-(BOOL)checkIsOpen;

-(void)cancelLoacation;

-(void)setProvince:(NSString *)province city:(NSString *)city area:(NSString *)area;

@end
