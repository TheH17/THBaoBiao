//
//  THTabBarButton.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/12.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "THTabBarButton.h"
#import "THBadgeView.h"

#define THTabBarbuttonImageRidio 0.7

@interface THTabBarButton()

@property(nonatomic, strong)THBadgeView *badgeView;

@end

@implementation THTabBarButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setHighlighted:(BOOL)highlighted{}

-(THBadgeView *)badgeView{
    if (!_badgeView) {
        THBadgeView *btn = [THBadgeView buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        _badgeView = btn;
    }
    return _badgeView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //设置颜色
        UIColor *selectedColor = [UIColor colorWithRed:0/255.0 green:133/255.0 blue:240/255.0 alpha:1];
        UIColor *normalColor = [UIColor colorWithRed:123/255.0 green:124/255.0 blue:125/255.0 alpha:1];
        [self setTitleColor:normalColor forState:UIControlStateNormal];
        [self setTitleColor:selectedColor forState:UIControlStateSelected];
        //图片居中
        self.imageView.contentMode = UIViewContentModeCenter;
        //文本居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        //字体大小
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

-(void)setItem:(UITabBarItem *)item{
    _item = item;
    
    [self setTitle:_item.title forState:UIControlStateNormal];
    [self setImage:_item.image forState:UIControlStateNormal];
    [self setImage:_item.selectedImage forState:UIControlStateSelected];
    
    self.badgeView.badgeValue = _item.badgeValue;
    
//    //清空观察者
//    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
//    
//    [_item addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
//    [_item addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
//    [_item addObserver:self forKeyPath:@"selectedImage" options:NSKeyValueObservingOptionNew context:nil];
//    [_item addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:nil];
}

//重写系统方法，监听的属性有变动时执行
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
//    [self setTitle:_item.title forState:UIControlStateNormal];
//    [self setImage:_item.image forState:UIControlStateNormal];
//    [self setImage:_item.selectedImage forState:UIControlStateSelected];
//    
//    self.badgeView.badgeValue = _item.badgeValue;
//}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGSize size = self.bounds.size;
//    THLog(@"123123%f", self.bounds.size.width);
    //设置图片大小
    CGFloat imgX = 0;
    CGFloat imgY = 0;
    CGFloat imgW = size.width;
    CGFloat imgH = size.height * THTabBarbuttonImageRidio;
    self.imageView.frame = CGRectMake(imgX, imgY, imgW, imgH);
//    THLog(@"btn        %f", self.frame.size.width);
//    THLog(@"btn        %f", self.frame.size.height);
//    THLog(@"imageView  %f", self.imageView.frame.size.width);
//    THLog(@"imageView  %f", self.imageView.frame.size.height);
//    THLog(@"image      %f", self.imageView.image.size.width);
//    THLog(@"image      %f", self.imageView.image.size.height);
//    THLog(@"       ");
    //设置文本的大小
    CGFloat labelX = 0;
    CGFloat labelY = imgH - 3;
    CGFloat labelW = size.width;
    CGFloat labelH = size.height - labelY;
    self.titleLabel.frame = CGRectMake(labelX, labelY, labelW, labelH);
    
    //设置badgeValue
    self.badgeView.x = self.width - self.badgeView.width - 10;
    self.badgeView.y = 0;
}

@end
