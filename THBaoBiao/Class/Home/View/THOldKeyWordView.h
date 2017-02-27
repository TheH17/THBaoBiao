//
//  THOldKeyWordView.h
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/26.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol THOldWordAddWordDelegate <NSObject>

-(void)addNewWordInOldPage;
-(void)deleteWord:(NSString *)word;

@end

@interface THOldKeyWordView : UIView<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate>

//用来存储关键词
@property (nonatomic,strong) NSArray *wordList;

//定义collectionview
@property (nonatomic,strong) UICollectionView *wordListView;

@property (nonatomic, weak) id<THOldWordAddWordDelegate> addWorddelegate;

-(instancetype)initWithFrame:(CGRect)frame WithCount:(unsigned long)count;
-(void)deleteWord:(int)index;
@end
