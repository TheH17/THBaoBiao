//
//  THOldWebsiteView.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/27.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "THOldWebsiteView.h"
#import "THSite.h"

#import "THaddWordAndSiteView.h"
#import "MJRefresh.h"
#import "THSiteViewCell.h"

@interface THOldWebsiteView()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) THaddWordAndSiteView *addView;

@end

@implementation THOldWebsiteView

-(instancetype)initWithFrame:(CGRect)frame WithCount:(unsigned long)count{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        
        self.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:237/255.0 alpha:1];
        self.dataSource = self;
        self.delegate = self;
        self.alwaysBounceVertical = YES;
        self.userInteractionEnabled = YES;
        self.layer.borderColor = [UIColor colorWithRed:222/255.0 green:222/255.0 blue:221/255.0 alpha:1].CGColor;
        self.layer.borderWidth = 0.5;
        //注册class
        [self registerClass:[THSiteViewCell class] forCellWithReuseIdentifier:@"collectItem"];
    }
    return self;
}

-(void)setSiteList:(NSArray *)siteList{
    _siteList = siteList;
    [self reloadData];
}

#pragma mark dataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return _siteList.count + 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:
(NSInteger)section{
    
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    THSiteViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectItem" forIndexPath:indexPath];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    UILabel * lab = [[UILabel alloc] initWithFrame:cell.bounds];
    lab.font = [UIFont systemFontOfSize:17];
    cell.layer.borderColor = [UIColor colorWithRed:188/255.0 green:190/255.0 blue:191/255.0 alpha:1].CGColor;
    cell.layer.borderWidth = 1.0f;
    if (indexPath.section == 0) {
        lab.text = @"添加";
        lab.textColor = [UIColor whiteColor];
        lab.textAlignment = NSTextAlignmentCenter;
        cell.backgroundColor = [UIColor colorWithRed:29/255.0 green:80/255.0 blue:248/255.0 alpha:1];
    }else{
        THSite *site = [_siteList objectAtIndex:indexPath.section - 1];
        THLog(@"%@",site);
        
        lab.text = [site.sitename isEqualToString:@""] ? [NSString stringWithFormat:@"%@", site.startUrl] : [NSString stringWithFormat:@"%@", site.sitename];
        
        lab.textColor = [UIColor blueColor];
        lab.textAlignment = NSTextAlignmentLeft;
        cell.backgroundColor = [UIColor whiteColor];
        cell.site = site;
        cell.fatherView = self;
        UILongPressGestureRecognizer *tap = [[UILongPressGestureRecognizer alloc]initWithTarget:cell action:@selector(handLong)];
        tap.delegate = self;
        tap.numberOfTouchesRequired = 1;
        /* Maximum 100 pixels of movement allowed before the gesture is recognized */
        /*最大100像素的运动是手势识别所允许的*/
        tap.allowableMovement = 100.0f;
        /*这个参数表示,两次点击之间间隔的时间长度。*/
        tap.minimumPressDuration = 1.0;
        [cell addGestureRecognizer:tap];
    }
    [cell.contentView addSubview:lab];
//    cell
    
    
    
    return cell;
}

-(void)deleteSite:(THSite *)site{
    [self.addSitedelegate deleteWebSite:site];
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 10;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake([UIScreen mainScreen].bounds.size.width - 40, 40);
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 12);
}


//section间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(5, 10, 5, 10);
    
}

//点击单元格
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        [self.addSitedelegate performSelector:@selector(addNewSiteInOldPage)];
        THLog(@"132");
    }
}
//取消选中单元格时的方法，这里不需要
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
