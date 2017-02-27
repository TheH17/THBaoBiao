//
//  THProfileCellView.h
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/20.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol THProfileCellViewDelegate <NSObject>

-(void)showHistory;

-(void)showShareView;

-(void)showIntro;

-(void)selectIndustry;

@end

@interface THProfileCellView : UIView




-(instancetype)initWithFrame:(CGRect)frame withIndexPath:(NSIndexPath *)indexPath withString:(NSString *)string;

@property (nonatomic, weak) id<THProfileCellViewDelegate> delegate;

@end
