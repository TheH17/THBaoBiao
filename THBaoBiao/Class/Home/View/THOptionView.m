//
//  THOptionView.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/16.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "THOptionView.h"
#import "THOptionBtn.h"

#define Cell_Width self.bounds.size.width
#define Cell_height self.bounds.size.height / 3

@interface THOptionView()<UICollectionViewDataSource>


@end

@implementation THOptionView

static NSString * const reuseIdentifier = @"OptionViewCell";

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        self.optionList = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
        _optionList.dataSource = self;
        //注册class
        [_optionList registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        [self addSubview:_optionList];
        self.backgroundColor = [UIColor colorWithRed:230/255.0 green:231/255.0 blue:232/255.0 alpha:1];
        
    }
    return self;
}

-(THOptionBtn *)createBtnWithTag:(NSInteger)tag{
    THOptionBtn *button = [[THOptionBtn alloc]initWithFrame:CGRectMake(20, 0.03*[UIScreen mainScreen].bounds.size.height, Cell_Width - 40, Cell_height - 0.06*[UIScreen mainScreen].bounds.size.height) WithType:2];
//    THOptionBtn *button = [[THOptionBtn alloc]initWithFrame:CGRectMake(20, 20, Cell_Width - 40, Cell_height - 40) WithType:2];
    if (tag == 0) {
        [button setBackgroundColor:[UIColor colorWithRed:88/255.0 green:129/255.0 blue:252/255.0 alpha:1]];
        [button setTitle:@"添加关键词（必填）" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(keyWordBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
    }else if(tag == 1){
        [button setBackgroundColor:[UIColor colorWithRed:88/255.0 green:129/255.0 blue:252/255.0 alpha:1]];
        [button setTitle:@"添加新网址（选填）" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(newWebsiteBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [button setBackgroundColor:[UIColor colorWithRed:29/255.0 green:80/255.0 blue:247/255.0 alpha:1]];
        [button setTitle:@"开始搜索" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(startSearchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:20];
    return button;
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.frame = CGRectMake(0, indexPath.section * Cell_height, Cell_Width, Cell_height);
    cell.backgroundColor = [UIColor colorWithRed:230/255.0 green:231/255.0 blue:232/255.0 alpha:1];
    [cell.contentView addSubview:[self createBtnWithTag:indexPath.section]];
    return cell;
}

#pragma mark - 按钮点击方法，需要调用外部delegate方法
-(void)keyWordBtnClick{
    if ([self.delegate respondsToSelector:@selector(addKeyWord)]) {
        [self.delegate addKeyWord];
    }
}

-(void)newWebsiteBtnClick{
    if ([self.delegate respondsToSelector:@selector(addNewWebSite)]) {
        [self.delegate addNewWebSite];
    }
}

-(void)startSearchBtnClick{
    if ([self.delegate respondsToSelector:@selector(startSearch)]) {
        [self.delegate startSearch];
    }
}

@end
