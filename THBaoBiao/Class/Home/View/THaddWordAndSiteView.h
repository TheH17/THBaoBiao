//
//  THaddWordAndSiteView.h
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/27.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol THaddWordSiteDelegate <NSObject>

-(void)closeAddWordSiteView;

-(void)successFulAddData;

@end

@interface THaddWordAndSiteView : UIView

@property (nonatomic, assign) int type;

@property (nonatomic, weak) id<THaddWordSiteDelegate> delegate;

@end
