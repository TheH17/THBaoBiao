//
//  THOldWebsiteView.h
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/27.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class THSite;
@protocol THOldSiteAddSiteDelegate <NSObject>

-(void)addNewSiteInOldPage;

-(void)deleteWebSite:(THSite *)site;

@end



@interface THOldWebsiteView : UICollectionView<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate>

//用来存储关键词
@property (nonatomic,strong) NSArray *siteList;

////定义collectionview
//@property (nonatomic,strong) UICollectionView *siteListView;

@property (nonatomic, weak) id<THOldSiteAddSiteDelegate> addSitedelegate;

-(instancetype)initWithFrame:(CGRect)frame WithCount:(unsigned long)count;
-(void)deleteSite:(THSite *)site;

@end
