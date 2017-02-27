//
//  THChargeSectionOneView.h
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/18.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@class THChargeController;
@interface THChargeSectionOneView : UIView

@property (nonatomic, strong) THChargeController *col;

-(instancetype)initWithFrame:(CGRect)frame withIndexPath:(NSIndexPath *)indexPath;

-(instancetype)initWithFrame:(CGRect)frame withRow:(NSInteger)row;

@end
