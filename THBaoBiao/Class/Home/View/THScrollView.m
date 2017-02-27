//
//  THScrollView.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/15.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "THScrollView.h"
#import "UIImageView+WebCache.h"
#import "THIntroController.h"

#define S_WIDTH self.bounds.size.width
#define S_HEIGHT self.bounds.size.height

@interface THScrollView()

//当前索引
@property (assign, nonatomic) NSUInteger currentImageIndex;

@property (strong, nonatomic) UIImageView *imgVLeft;
@property (strong, nonatomic) UIImageView *imgVCenter;
@property (strong, nonatomic) UIImageView *imgVRight;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation THScrollView

-(void)setImgs:(NSArray *)imgs{
    _imgs = imgs;
    if (_imgs.count > 1) {
        //不止一张图片加入scrollview滚动显示
        [self layoutUI];
    }else{
        //只有一张图片，则直接添加即可，不需要滚动
        [self addImageView];
    }
}

-(void)addScrollView{
    _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    _scrollView.contentSize = CGSizeMake(S_WIDTH * 3, 0);
//    _scrollView.contentOffset = CGPointMake(S_WIDTH, 0);
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
}

-(void)addImageViewToScrollView{
    //图片视图；左边
    _imgVLeft = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, S_WIDTH, S_HEIGHT)];
    _imgVLeft.contentMode = UIViewContentModeScaleAspectFill;
    [_scrollView addSubview:_imgVLeft];
    _imgVLeft.userInteractionEnabled = YES;
    
    
    //图片视图；中间
    _imgVCenter = [[UIImageView alloc] initWithFrame:CGRectMake(S_WIDTH, 0.0, S_WIDTH, S_HEIGHT)];
    _imgVCenter.contentMode = UIViewContentModeScaleAspectFill;
    [_scrollView addSubview:_imgVCenter];
    
    //图片视图；右边
    _imgVRight = [[UIImageView alloc] initWithFrame:CGRectMake(S_WIDTH * 2.0, 0.0, S_WIDTH, S_HEIGHT)];
    _imgVRight.contentMode = UIViewContentModeScaleAspectFill;
    [_scrollView addSubview:_imgVRight];
    
    //初始化一个手势
    UIGestureRecognizer *singleTap = [[UIGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction:)];
    //为图片添加手势
    [_imgVLeft addGestureRecognizer:singleTap];
    [_imgVCenter addGestureRecognizer:singleTap];
    [_imgVRight addGestureRecognizer:singleTap];
    
}

-(void)singleTapAction:(UIButton *)sender{
    [self.delegate didClickImg:sender.tag];
}

-(void)addPageControl{
    _pageConl = [UIPageControl new];
    //根据页数来得到大小
    CGSize size = [_pageConl sizeForNumberOfPages:_imgs.count];
    //设置大小位置
    _pageConl.bounds = CGRectMake(0, 0, size.width, size.height);
    _pageConl.center = CGPointMake(S_WIDTH - size.width - 10, S_HEIGHT - 15);
    _pageConl.numberOfPages = _imgs.count;
    _pageConl.pageIndicatorTintColor = [UIColor colorWithRed:148/255.0 green:104/255.0 blue:233/255.0 alpha:1];
    
    _pageConl.currentPageIndicatorTintColor = [UIColor colorWithRed:253/255.0 green:251/255.0 blue:4/255.0 alpha:1];
    _pageConl.userInteractionEnabled = NO;//设置是否允许用户交互；默认值为 YES，当为 YES 时，针对点击控件区域左（当前页索引减一，最小为0）右（当前页索引加一，最大为总数减一），可以编写 UIControlEventValueChanged 的事件处理方法
    [self addSubview:_pageConl];

}

-(void)setInfoByCurrentindex:(NSUInteger)currentImageIndex{
    [_imgVCenter sd_setImageWithURL:[NSURL URLWithString:[_imgs objectAtIndex:currentImageIndex]] placeholderImage:[UIImage imageNamed:@"ad_01"]];
    
    
    [_imgVRight sd_setImageWithURL:[NSURL URLWithString:[_imgs objectAtIndex:(unsigned long)((_currentImageIndex + 1) % _imgs.count)]] placeholderImage:[UIImage imageNamed:@"ad_02"]];
    
    [_imgVLeft sd_setImageWithURL:[NSURL URLWithString:[_imgs objectAtIndex:(unsigned long)((_currentImageIndex - 1 + _imgs.count) % _imgs.count)]] placeholderImage:[UIImage imageNamed:@"ad_03"]];
    
    _pageConl.currentPage = currentImageIndex;
}

-(void)setDrfaultInfo{
    _currentImageIndex = 0;
    [self setInfoByCurrentindex:_currentImageIndex];
}

-(void)layoutUI{
    //加载UI组件
    [self addScrollView];
    [self addImageViewToScrollView];
    [self addPageControl];
    [self setDrfaultInfo];
//    THLog(@"111%@", NSStringFromCGRect(self.frame));
//    THLog(@"222%@", NSStringFromCGRect(self.scrollView.frame));
    [self addTimerToRun];
}

-(void)addTimerToRun{
    NSTimer *timer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(nextImg) userInfo:nil repeats:YES];
    self.timer = timer;
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

-(void)nextImg{
    NSInteger currentPage = self.pageConl.currentPage;
    if (currentPage != self.pageConl.numberOfPages - 1) {
        currentPage ++;
    }else{
        currentPage = 0;
    }
    CGFloat offsetX = currentPage * self.scrollView.frame.size.width;
    [UIView animateWithDuration:1.0 animations:^{
        self.scrollView.contentOffset = CGPointMake(offsetX, 0);
    }];
}

#pragma Mark - scrollView的delegate方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int page = (scrollView.contentOffset.x +scrollView.frame.size.width / 2)/ scrollView.frame.size.width;
    self.pageConl.currentPage = page;
}
//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    [self reloadImage];
//    _scrollView.contentOffset = CGPointMake(S_WIDTH, 0);
//    _pageConl.currentPage = _currentImageIndex;
////    THLog(@"222%@", NSStringFromCGRect(self.scrollView.frame));
//}
//#pragma mark - imgScrollView的代理方法
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    int page = (scrollView.contentOffset.x +scrollView.frame.size.width / 2)/ scrollView.frame.size.width;
//    _pageConl.currentPage = page;
//}
- (void)reloadImage {
    CGPoint contentOffset = [_scrollView contentOffset];
    if (contentOffset.x > S_WIDTH) { //向左滑动
        _currentImageIndex = (_currentImageIndex + 1) % _imgs.count;
    } else if (contentOffset.x < S_WIDTH) { //向右滑动
        _currentImageIndex = (_currentImageIndex - 1 + _imgs.count) % _imgs.count;
    }
    
    [self setCurrentImageIndex:_currentImageIndex];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.timer invalidate];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self addTimerToRun];
}

-(void)addImageView{
    
}

@end
