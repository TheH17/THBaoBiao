//
//  THShareView.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 2016/12/18.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "THShareView.h"
#import "Masonry.h"

#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH [UIScreen mainScreen].bounds.size.width

@interface THShareView()<UIGestureRecognizerDelegate>

@end

@implementation THShareView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UISwipeGestureRecognizer *ges = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handSwipe)];
        ges.direction = UISwipeGestureRecognizerDirectionDown;
        ges.delegate = self;
        [self addGestureRecognizer:ges];
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    }
    [self layoutUI];
    return self;
}

-(void)layoutUI{
    CGFloat btnX = WIDTH / 4.0;
    
    UIView *opView = [[UIView alloc]init];
    opView.backgroundColor = [UIColor whiteColor];
    [self addSubview:opView];
    [opView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(self);
        make.height.mas_equalTo(0.3*HEIGHT);
    }];
    //1
    UIView *firstView = [[UIView alloc]init];
    firstView.backgroundColor = [UIColor whiteColor];
    [opView addSubview:firstView];
    [firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.equalTo(opView);
        make.height.mas_equalTo(0.2*HEIGHT);
    }];
    
    //微信好友
    UIButton *firstBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [firstBtn setImage:[UIImage imageNamed:@"weichat"] forState:UIControlStateNormal];
//    [firstBtn setTitle:@"微信好友" forState:UIControlStateNormal];
    [firstBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    firstBtn.layer.cornerRadius = 7;
    firstBtn.tag = 1771;
    [firstBtn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    [firstView addSubview:firstBtn];
    [firstBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(firstView);
        make.centerX.equalTo(firstView).with.offset(-btnX);
        make.width.and.height.mas_equalTo(@80);
    }];

    //微信朋友圈
    UIButton *secondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [secondBtn setImage:[UIImage imageNamed:@"weichat_friend"] forState:UIControlStateNormal];
    [secondBtn setTitle:@"微信朋友圈" forState:UIControlStateNormal];
    [secondBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    secondBtn.layer.cornerRadius = 7;
    secondBtn.tag = 1772;
    [secondBtn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    [firstView addSubview:secondBtn];
    [secondBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(firstView);
        make.centerX.equalTo(firstView);
        make.width.and.height.mas_equalTo(@80);
    }];
    
    //微信收藏
    UIButton *thirdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [thirdBtn setImage:[UIImage imageNamed:@"weichat_save"] forState:UIControlStateNormal];
    [thirdBtn setTitle:@"微信收藏" forState:UIControlStateNormal];
    [thirdBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    thirdBtn.layer.cornerRadius = 7;
    thirdBtn.tag = 1773;
    [thirdBtn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    [firstView addSubview:thirdBtn];
    [thirdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(firstView);
        make.centerX.equalTo(firstView).with.offset(btnX);
        make.width.and.height.mas_equalTo(@80);
    }];
    
    //分割线
    UIView *sepView = [UIView new];
    [opView addSubview:sepView];
    sepView.backgroundColor = [UIColor grayColor];
    [sepView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.and.width.equalTo(opView);
        make.top.equalTo(firstView.mas_bottom);
        make.height.mas_equalTo(0.5);
    }];
    //2
    UIView *secondView = [UIView new];
    [opView addSubview:secondView];
    secondView.backgroundColor = [UIColor whiteColor];
    [secondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.width.and.bottom.equalTo(opView);
        make.top.equalTo(sepView.mas_bottom);
    }];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.backgroundColor = [UIColor colorWithRed:233/255.0 green:234/255.0 blue:235/255.0 alpha:1];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:23];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancelBtn.layer.cornerRadius = 7;
    
    [cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [secondView addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.bottom.and.right.equalTo(secondView);
    }];
}

-(void)cancel{
    [self handSwipe];
}

-(void)share:(UIButton *)sender{
    int type = sender.tag == 1771 ? 0 : sender.tag == 1772 ? 1 : 2;
    [self.delegate shareWithType:type];
}

-(void)handSwipe{
    [self.delegate performSelector:@selector(closeShareView)];
}

#pragma UIGestureRecognizationDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isMemberOfClass:[UIView class]]) {
        return NO;
    }else
        return YES;
}

@end
