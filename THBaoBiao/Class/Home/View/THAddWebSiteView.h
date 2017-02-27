//
//  THAddWebSiteView.h
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/27.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol THAddWebDelegate <NSObject>

-(void)closeInputSite;

-(void)successFulAddWeb;

@end

@interface THAddWebSiteView : UIView

@property (nonatomic, weak) id<THAddWebDelegate> delegate;

@property (nonatomic, strong) UIView *fatherView;

@end
