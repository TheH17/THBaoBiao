//
//  THNewFeatureController.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/10/24.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "THNewFeatureController.h"
#import "THNewFeatureCell.h"

@interface THNewFeatureController ()

@property (nonatomic, strong) UIPageControl *pageCol;

@end

@implementation THNewFeatureController

static NSString * const reuseIdentifier = @"NewFeatureCell";

-(instancetype)init{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    
    layout.minimumLineSpacing = 0;
    
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    return [super initWithCollectionViewLayout:layout];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerClass:[THNewFeatureCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.collectionView.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:244/255.0 alpha:1];
    //分页
    self.collectionView.pagingEnabled = YES;
    //无弹性
    self.collectionView.bounces = NO;
    //水平条设置
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    [self layoutPageCol];
}

-(void)layoutPageCol{
    UIPageControl *pageCol = [[UIPageControl alloc]init];
    
    pageCol.numberOfPages = 2;
    
    pageCol.currentPageIndicatorTintColor = [UIColor colorWithRed:37/255.0 green:61/255.0 blue:248/255.0 alpha:1];
    
    pageCol.pageIndicatorTintColor = [UIColor colorWithRed:131/255.0 green:132/255.0 blue:136/255.0 alpha:1];
    
    pageCol.center = CGPointMake(self.view.width * 0.5, self.view.height - 50);
    
    _pageCol = pageCol;
    
    [self.view addSubview:pageCol];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    THNewFeatureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.image = [UIImage imageNamed:[NSString stringWithFormat:@"newFeature_0%ld", indexPath.row + 1]];
    
    [cell checkBtnFromIndexPath:indexPath andCount:2];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 获取当前的偏移量，计算当前第几页
    int page = scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5;
    
    // 设置页数
    _pageCol.currentPage = page;
}

@end
