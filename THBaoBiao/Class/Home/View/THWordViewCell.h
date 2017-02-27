//
//  THWordViewCell.h
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/10/14.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class THOldKeyWordView;
@interface THWordViewCell : UICollectionViewCell

@property (nonatomic, assign) int index;

-(void)handLong;

@property (nonatomic, strong) THOldKeyWordView *fatherView;


@end
