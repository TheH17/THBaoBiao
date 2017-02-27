//
//  THSiteViewCell.h
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/10/14.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@class THOldWebsiteView, THSite;
@interface THSiteViewCell : UICollectionViewCell

@property (nonatomic, strong) THSite *site;

-(void)handLong;

@property (nonatomic, strong) THOldWebsiteView *fatherView;

@end
