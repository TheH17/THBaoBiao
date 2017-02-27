//
//  THIntroCellView.h
//  THBaoBiao
//
//  Created by 李浩鹏 on 2017/1/7.
//  Copyright © 2017年 李浩鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol THIntroDelegate <NSObject>

-(void)showShareView;

-(void)callForHelp;

@end

@interface THIntroCellView : UIView

-(instancetype)initWithFrame:(CGRect)frame withIndexPath:(NSIndexPath *)indexPath;

@property (nonatomic, weak) id<THIntroDelegate> delegate;

@end
