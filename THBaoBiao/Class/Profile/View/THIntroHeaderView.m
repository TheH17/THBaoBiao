//
//  THIntroHeaderView.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 2017/1/7.
//  Copyright © 2017年 李浩鹏. All rights reserved.
//

#import "THIntroHeaderView.h"
#import "Masonry.h"


#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation THIntroHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self layoutUI];
        self.backgroundColor = [UIColor colorWithRed:238/255.0 green:237/255.0 blue:246/255.0 alpha:1];
    }
    return self;
}

-(void)layoutUI{
    //1
    UIImageView *userImage = [[UIImageView alloc]init];
    //WithFrame:CGRectMake(20, (HEIGHT - 80)/2, 80, 80)
    [userImage setImage:[UIImage imageNamed:@"个人中心-头像"]];
    userImage.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:userImage];
    [userImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).with.offset(0.053*WIDTH);
        make.height.and.width.mas_equalTo(self.frame.size.height - 0.09*HEIGHT);
    }];
    //2
    UILabel *firstLabel = [UILabel new];
    firstLabel.textAlignment = NSTextAlignmentLeft;
    firstLabel.font = [UIFont systemFontOfSize:23];
    firstLabel.text = @"保标CAT";
    [self addSubview:firstLabel];
    [firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userImage.mas_right).with.offset(0.053*WIDTH);
        make.right.equalTo(self);
        make.bottom.equalTo(userImage.mas_centerY).with.offset(-0.007*HEIGHT);
        make.height.mas_equalTo(@25);
    }];
    //3
    UILabel *secondLabel = [UILabel new];
    secondLabel.textAlignment = NSTextAlignmentLeft;
    secondLabel.font = [UIFont systemFontOfSize:17];
    secondLabel.textColor = [UIColor colorWithRed:64/255.0 green:64/255.0 blue:71/255.0 alpha:1];
    secondLabel.numberOfLines = 0;
    secondLabel.text = @"世舶科技（武汉）有限公司旗下一款招投标神器";
    [self addSubview:secondLabel];
    [secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(firstLabel);
        make.right.equalTo(self).with.offset(-0.053*WIDTH);
        make.top.equalTo(userImage.mas_centerY).with.offset(0.007*HEIGHT);
    }];
    
//    UILabel *secondTitleLabel = [[UILabel alloc]init];
//    secondTitleLabel.textAlignment = NSTextAlignmentLeft;
//    secondTitleLabel.font = [UIFont systemFontOfSize:17];
//    secondTitleLabel.numberOfLines = 0;
//    [self addSubview:secondTitleLabel];
//    [secondTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(firstTitleLabel.mas_right).with.offset(0.0267*WIDTH);
//        make.right.equalTo(self).with.offset(-0.0267*WIDTH);
//        make.top.equalTo(self).with.offset(0.0267*WIDTH);
//    }];
//    secondTitleLabel.text = @"secondTitleLabelsecondTitleLabelsecondTitleLabelsecondTitleLabel";
//    //2
//    UIImageView *vipView = [[UIImageView alloc]init];
//    //WithFrame:CGRectMake(120, 35, 16, 16)
//    [vipView setImage:[UIImage imageNamed:@"VIP-开通"]];
//    vipView.contentMode = UIViewContentModeScaleAspectFit;
//    [self addSubview:vipView];
//    CGFloat marginY = (self.frame.size.height - 0.09*HEIGHT)/3;
//    [vipView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self).with.offset(marginY + 0.0105*HEIGHT);
//        make.left.equalTo(userImage.mas_right).with.offset(0.0267*WIDTH);
//        make.height.and.width.mas_equalTo(0.024*HEIGHT);
//    }];
//    
//    //3
//    UILabel *infoLabel = [[UILabel alloc]init];
//    //WithFrame:CGRectMake(120, 60, 170, 30)
//    infoLabel.textColor = [UIColor colorWithRed:137/255.0 green:160/255.0 blue:255/255.0 alpha:1];
//    infoLabel.textAlignment = NSTextAlignmentLeft;
//    infoLabel.font = [UIFont systemFontOfSize:17];
//    infoLabel.text = [NSString stringWithFormat:@"欢迎使用保标系统"];
//    [infoLabel sizeToFit];
//    [self addSubview:infoLabel];
//    [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(vipView.mas_bottom).with.offset(marginY);
//        make.left.equalTo(vipView);
//        //        make.height.and.width.mas_equalTo(0.045*HEIGHT);
//    }];
//    
//    //4
//    UILabel *userLabel = [[UILabel alloc]init];
//    //WithFrame:CGRectMake(145, 27, 150, 30)
//    userLabel.textAlignment = NSTextAlignmentLeft;
//    userLabel.textColor = [UIColor whiteColor];
//    userLabel.font = [UIFont systemFontOfSize:20];
//    [userLabel sizeToFit];
//    if (self.user) {
//        userLabel.text = [NSString stringWithFormat:@"%@", self.user.phonenum];
//    }
//    userLabel.text = @"未登录";
//    [self addSubview:userLabel];
//    [userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(vipView);
//        make.left.equalTo(vipView.mas_right).with.offset(0.04*WIDTH);
//    }];
}

@end
