//
//  THOptionView.h
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/16.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol THOptionDelegate <NSObject>

-(void)addKeyWord;

-(void)addNewWebSite;

-(void)startSearch;

@end

@interface THOptionView : UIView

//操作区域
@property (nonatomic, strong) UICollectionView *optionList;

@property (nonatomic, weak) id<THOptionDelegate> delegate;

@end
