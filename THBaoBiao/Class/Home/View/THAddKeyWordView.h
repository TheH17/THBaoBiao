//
//  THAddKeyWordView.h
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/27.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol THAddWordDelegate <NSObject>

-(void)closeInputWord;

-(void)successFulAddWord;

@end

@interface THAddKeyWordView : UIView

@property (nonatomic, weak) id<THAddWordDelegate> delegate;

@property (nonatomic, strong) UIView *fatherView;

@end
