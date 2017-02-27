//
//  THInfoListView.h
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/21.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol THInfoListDelegate <NSObject>

-(void)loadWebViewWithUrlString:(NSString *)string mirrorUrlString:(NSString *)mirrorUrl indexPath:(NSIndexPath *)indexPath;

-(NSString *)getLocalKeyWord;

@end

@interface THInfoListView : UIView

@property (nonatomic, weak) id<THInfoListDelegate> delegate;

-(void)reInitData;

-(void)loadInfo;

-(void)scrollToIndexPath:(NSIndexPath *)indexPath;

-(void)updataWithKeyword:(NSString *)keyword;

@end
