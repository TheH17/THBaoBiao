//
//  THOldKeyWordView.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/26.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "THOldKeyWordView.h"
#import "THaddWordAndSiteView.h"
#import "THWordViewCell.h"

@interface THOldKeyWordView()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) THaddWordAndSiteView *addView;

@end

@implementation THOldKeyWordView
//40*(count / 3 + 1) +40

-(instancetype)initWithFrame:(CGRect)frame WithCount:(unsigned long)count{
    if (self = [super initWithFrame:frame]) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        self.wordListView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40*(count /3 +1)+40) collectionViewLayout:layout];
        _wordListView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:237/255.0 alpha:1];
        _wordListView.dataSource = self;
        _wordListView.delegate = self;
        _wordListView.layer.borderColor = [UIColor colorWithRed:222/255.0 green:222/255.0 blue:221/255.0 alpha:1].CGColor;
        _wordListView.layer.borderWidth = 0.5;
        //注册class
        [_wordListView registerClass:[THWordViewCell class] forCellWithReuseIdentifier:@"collectItem"];
        [self addSubview:_wordListView];
        
        
    }
    return self;
}

-(void)setWordList:(NSArray *)wordList{
    _wordList = wordList;
    [_wordListView reloadData];
}

#pragma mark dataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return _wordList.count/3+1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:
(NSInteger)section{
    
    return 3;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    THWordViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectItem" forIndexPath:indexPath];
    if (indexPath.section*3+indexPath.row<=_wordList.count) {
        
        UILabel * lab = [[UILabel alloc] initWithFrame:cell.bounds];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont systemFontOfSize:17];
        cell.layer.borderColor = [UIColor colorWithRed:188/255.0 green:190/255.0 blue:191/255.0 alpha:1].CGColor;
        cell.layer.borderWidth = 1.0f;
        if (indexPath.section == 0 && indexPath.row ==0) {
            lab.text = @"添加";
            lab.textColor = [UIColor whiteColor];
            cell.backgroundColor = [UIColor colorWithRed:29/255.0 green:80/255.0 blue:248/255.0 alpha:1];
        }else{
            lab.text = [_wordList objectAtIndex:indexPath.section*3+indexPath.row -1];
            cell.backgroundColor = [UIColor whiteColor];
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
        cell.index = (int)(indexPath.section*3+indexPath.row -1);
        [cell.contentView addSubview:lab];
        
        
    }else{
        cell.hidden = YES;
        if ([[cell.subviews lastObject] isKindOfClass:[UILabel class]]) {
            //
        THLog(@"1111");
        }
    }
    return cell;
}


#pragma mark cell删除
-(void)deleteWord:(int)index{
    [self.addWorddelegate deleteWord:[_wordList objectAtIndex:index]];
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 20;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 10;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(([UIScreen mainScreen].bounds.size.width-60)/3.0, 40);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section == (_wordList.count + 1)/3) {
        return CGSizeMake([UIScreen mainScreen].bounds.size.width, 15);
    }else
        return CGSizeZero;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake([UIScreen mainScreen].bounds.size.width, 12);
    }else
        return CGSizeZero;
}


//section间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(5, 10, 5, 10);
    
}

//点击单元格
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        //只有当点击第一个cell时才回触发事件
        [self.addWorddelegate performSelector:@selector(addNewWordInOldPage)];
        THLog(@"132");
    }
}
//取消选中单元格时的方法，这里不需要
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
