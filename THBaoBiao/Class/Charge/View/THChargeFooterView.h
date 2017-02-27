//
//  THChargeFooterView.h
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/19.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol THChargeFooterViewDelegate <NSObject>

-(void)chargeNow;

@end

@interface THChargeFooterView : UIView

@property (nonatomic, weak) id<THChargeFooterViewDelegate> delegate;

@end
