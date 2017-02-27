//
//  THProfileCellView.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/20.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "THProfileCellView.h"
#import "Masonry.h"
#import "THUserTool.h"
#import "THUser.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface THProfileCellView()

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, copy) NSString *industry;

@property (nonatomic, strong) THUser *user;


@end

@implementation THProfileCellView

-(THUser *)user{
    if (!_user) {
        _user = [THUserTool getUser];
    }
    return _user;
}

-(instancetype)initWithFrame:(CGRect)frame withIndexPath:(NSIndexPath *)indexPath withString:(NSString *)string{
    if (self = [super initWithFrame:frame]) {
        _indexPath = indexPath;
        _industry = string;
        [self layoutUI];
    }
    return self;
}

-(void)layoutUI{
    UILabel *firstTitleLabel = [[UILabel alloc]init];
    firstTitleLabel.textAlignment = NSTextAlignmentCenter;
    firstTitleLabel.font = [UIFont systemFontOfSize:20];
    [self addSubview:firstTitleLabel];
    [firstTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).with.offset(0.0267*WIDTH);
        make.width.mas_equalTo(0.2933*WIDTH);
    }];
    
    if (_indexPath.section == 0) {
        
        if (_indexPath.row == 0) {
            
            firstTitleLabel.text = @"邮        箱：";
            
            UITextField *mailTextField = [[UITextField alloc]init];
            //WithFrame:CGRectMake(120, 10, WIDTH - 120, HEIGHT - 20)
            mailTextField.textAlignment = NSTextAlignmentLeft;
            mailTextField.font = [UIFont systemFontOfSize:20];
            mailTextField.textColor = [UIColor blackColor];
            mailTextField.layer.borderColor = [UIColor clearColor].CGColor;
            mailTextField.layer.borderWidth = 0;
            mailTextField.layer.cornerRadius = 5;
            mailTextField.userInteractionEnabled = NO;
            [self addSubview:mailTextField];
            
            if (!self.user.email) {
                mailTextField.placeholder = @"点击填写邮箱地址";
            }else{
                mailTextField.text = self.user.email;
            }
            [mailTextField mas_makeConstraints:^(MASConstraintMaker *make) {
                //            make.centerY.equalTo(self);
                make.left.equalTo(firstTitleLabel.mas_right).with.offset(0.0267*WIDTH);
                make.right.equalTo(self).with.offset(-0.0267*WIDTH);
                make.top.equalTo(self).with.offset(0.015*HEIGHT);
                make.bottom.equalTo(self).with.offset(-0.015*HEIGHT);
            }];
            
        }else if (_indexPath.row == 1) {
            firstTitleLabel.text = @"所属行业：";

            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            //    button.frame = CGRectMake(280, 38, 80, 40);
            button.backgroundColor = [UIColor colorWithRed:203/255.0 green:203/255.0 blue:208/255.0 alpha:1];
            button.layer.cornerRadius = 3;
            [button setTitle:self.industry forState:UIControlStateNormal];
            button.titleLabel.textAlignment = NSTextAlignmentLeft;
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            button.layer.borderWidth = 0;
            button.userInteractionEnabled = NO;
            [button addTarget:self action:@selector(chooseIndustry) forControlEvents:UIControlEventTouchDown];
            [self addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(firstTitleLabel.mas_right).with.offset(0.0267*WIDTH);
                make.right.equalTo(self).with.offset(-0.0267*WIDTH);
                make.top.equalTo(self).with.offset(0.015*HEIGHT);
                make.bottom.equalTo(self).with.offset(-0.015*HEIGHT);
            }];
            
        }else{
            firstTitleLabel.text = @"公司名称：";
            
            UITextField *corTextView = [[UITextField alloc]init];
            corTextView.textAlignment = NSTextAlignmentLeft;
            corTextView.font = [UIFont systemFontOfSize:20];
            corTextView.textColor = [UIColor blackColor];
            corTextView.layer.borderColor = [UIColor clearColor].CGColor;
            corTextView.layer.borderWidth = 0;
            corTextView.layer.cornerRadius = 5;
            corTextView.userInteractionEnabled = NO;
            [self addSubview:corTextView];
            
            
            if (self.user.corporation) {
                corTextView.text = self.user.corporation;
            }else{
                corTextView.placeholder = @"点击填写公司名称";
            }
            
            [corTextView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(firstTitleLabel.mas_right).with.offset(0.0267*WIDTH);
                make.right.equalTo(self).with.offset(-0.0267*WIDTH);
                make.top.equalTo(self).with.offset(0.015*HEIGHT);
                make.bottom.equalTo(self).with.offset(-0.015*HEIGHT);
            }];
        }
        
        
        
    }else {
        
        if (_indexPath.row == 0) {
            
            firstTitleLabel.text = @"最近浏览：";
            
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"点击查看详情"];
            NSRange strRange = {0,[str length]};
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:strRange];  //设置颜色
            [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setFrame:CGRectMake(120, 15, 120, HEIGHT - 30)];
            [[btn titleLabel] setFont:[UIFont systemFontOfSize:17]];
            [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];      //btn左对齐
            [btn setAttributedTitle:str forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(checkClick) forControlEvents:UIControlEventTouchUpInside];
            [btn sizeToFit];
            [self addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.left.equalTo(firstTitleLabel.mas_right).with.offset(0.0267*WIDTH);
            }];
            
        }else if (_indexPath.row == 1) {
            firstTitleLabel.text = @"快速分享：";
            
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"点击分享好友"];
            NSRange strRange = {0,[str length]};
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:strRange];  //设置颜色
            [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setFrame:CGRectMake(120, 15, 120, HEIGHT - 30)];
            [[btn titleLabel] setFont:[UIFont systemFontOfSize:17]];
            [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];      //btn左对齐
            [btn setAttributedTitle:str forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(shareClick) forControlEvents:UIControlEventTouchUpInside];
            [btn sizeToFit];
            [self addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.left.equalTo(firstTitleLabel.mas_right).with.offset(0.0267*WIDTH);
            }];
            
        }else{
            firstTitleLabel.text = @"保标详情：";
            
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"点击查看"];
            NSRange strRange = {0,[str length]};
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:strRange];  //设置颜色
            [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setFrame:CGRectMake(120, 15, 120, HEIGHT - 30)];
            [[btn titleLabel] setFont:[UIFont systemFontOfSize:17]];
            [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];      //btn左对齐
            [btn setAttributedTitle:str forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(introClick) forControlEvents:UIControlEventTouchUpInside];
            [btn sizeToFit];
            [self addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.left.equalTo(firstTitleLabel.mas_right).with.offset(0.0267*WIDTH);
            }];
        }
    }
}

-(void)chooseIndustry{
    if ([self.delegate respondsToSelector:@selector(selectIndustry)]) {
        [self.delegate selectIndustry];
    }
}

-(void)checkClick{
    if ([self.delegate respondsToSelector:@selector(showHistory)]) {
        [self.delegate performSelector:@selector(showHistory)];
    }
}

-(void)shareClick{
    if ([self.delegate respondsToSelector:@selector(showShareView)]) {
        [self.delegate performSelector:@selector(showShareView)];
    }
}

-(void)introClick{
    if ([self.delegate respondsToSelector:@selector(showIntro)]) {
        [self.delegate performSelector:@selector(showIntro)];
    }
}

@end
