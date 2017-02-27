//
//  THTabBar.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/12.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "THTabBar.h"
#import "THTabBarButton.h"

@interface THTabBar()

@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) UIButton *selectedBtn;

@end

@implementation THTabBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(NSMutableArray *)buttons{
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

-(void)setItems:(NSArray *)items{
    _items = items;
    int index = 0;
    for (UITabBarItem *item in items) {
        THTabBarButton *btn = [THTabBarButton buttonWithType:UIButtonTypeCustom];
        btn.item = item;
        btn.tag = self.buttons.count;
        btn.type = index;
        index++;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        if (0 == btn.tag) {
            [self btnClick:btn];
        }
        [self addSubview:btn];
        [self.buttons addObject:btn];
    }
}

-(void)btnClick:(UIButton *)btn{
    //改变按钮的选中状态
    _selectedBtn.selected = NO;
    btn.selected = YES;
    _selectedBtn = btn;
    
    if ([_delegate respondsToSelector:@selector(didClickButton:)]) {
        [_delegate didClickButton:btn.tag];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = w / (self.items.count);
    CGFloat btnH = h;
    int i = 0;
    //调整自定义的tabbar的一些属性（按钮位置）
    for (UIView *tabBarButton in self.buttons) {
        btnX = i * btnW;
        tabBarButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
//        THLog(@"btn        %f", btnW);
//        THLog(@"btn        %f", btnH);
        i++;
    }
    
    
}


@end
