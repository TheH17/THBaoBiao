//
//  THNewFeatureCell.h
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/10/24.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THNewFeatureCell : UICollectionViewCell

@property (nonatomic, strong) UIImage *image;

//判断是否是最后一页，用来加上或者取消按钮
-(void)checkBtnFromIndexPath:(NSIndexPath *)indexPath andCount:(int)count;

@end
