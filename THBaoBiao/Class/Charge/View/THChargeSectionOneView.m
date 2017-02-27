//
//  THChargeSectionOneView.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/18.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "THChargeSectionOneView.h"
#import "Masonry.h"
#import "THChargeController.h"
#import "THUserTool.h"
#import "THUser.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface THChargeSectionOneView()

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, assign) NSInteger row;

@property (nonatomic, strong) UILabel *optionLabel;

@property (nonatomic, strong) UILabel *infoLabel;

@property (nonatomic, strong) UITextField *infoTextField;

@end

@implementation THChargeSectionOneView

-(instancetype)initWithFrame:(CGRect)frame withIndexPath:(NSIndexPath *)indexPath{
    if (self = [super initWithFrame:frame]) {
        _indexPath = indexPath;
        [self layoutUI];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame withRow:(NSInteger)row{
    if (self = [super initWithFrame:frame]) {
        _row = row;
        [self layoutUIForRow];
    }
    return self;
}

-(void)layoutUIForRow{
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.equalTo(self).with.offset(0.015*HEIGHT);
        make.bottom.equalTo(self).with.offset(-0.015*HEIGHT);
        make.width.mas_equalTo(0.09*HEIGHT);
    }];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize:17];
    [self addSubview:titleLabel];
    [titleLabel sizeToFit];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView.mas_right);
        make.top.equalTo(imageView);
//        make.height.mas_equalTo(0.03*HEIGHT);
//        make.width.mas_equalTo(0.3448*HEIGHT);
    }];
    
    UILabel *detailLabel = [[UILabel alloc]init];
    detailLabel.textAlignment = NSTextAlignmentLeft;
    detailLabel.font = [UIFont systemFontOfSize:11];
    [self addSubview:detailLabel];
    [detailLabel sizeToFit];
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel);
        make.top.equalTo(titleLabel.mas_bottom);
//        make.height.and.width.equalTo(titleLabel);
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:btn];
    [btn setImage:[UIImage imageNamed:@"未选择"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"选择"] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(btnSelected:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).with.offset(-0.0533*WIDTH);
        make.top.equalTo(self).with.offset(0.0225*HEIGHT);
        make.height.and.width.mas_equalTo(0.045*HEIGHT);
    }];
    
    if (_row == 0) {
        imageView.image = [UIImage imageNamed:@"微信"];
        titleLabel.text = @"微信支付";
        detailLabel.text = @"推荐已安装微信客户端的用户使用";
    }else{
        imageView.image = [UIImage imageNamed:@"支付宝"];
        titleLabel.text = @"支付宝支付";
        detailLabel.text = @"推荐已安装支付宝客户端的用户使用";
    }
}

-(void)btnSelected:(UIButton *)sender{
//    if (sender.selected) {
//        self.col.chargeType--;
//    }else{
//        self.col.chargeType++;
//    }
    sender.selected = !sender.selected;
    
}

-(void)layoutUI{
    self.optionLabel = [[UILabel alloc]init];
    _optionLabel.textAlignment = NSTextAlignmentCenter;
    _optionLabel.font = [UIFont systemFontOfSize:20];
    [self addSubview:_optionLabel];
    [_optionLabel sizeToFit];
    [_optionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(0.0267*WIDTH);
        make.centerY.equalTo(self);
    }];
    
    if (_indexPath.section == 0) {
        
        self.infoLabel = [[UILabel alloc]init];
        _infoLabel.textAlignment = NSTextAlignmentRight;
        _infoLabel.font = [UIFont systemFontOfSize:20];
        [self addSubview:_infoLabel];
        [_infoLabel sizeToFit];
        [_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(0.3298*HEIGHT);
//            make.top.equalTo(self).with.offset(0.015*HEIGHT);
//            make.bottom.equalTo(self).with.offset(-0.015*HEIGHT);
//            make.width.mas_equalTo(@120);
            make.right.equalTo(self).with.offset(-0.0667*WIDTH);
            make.centerY.equalTo(self);
        }];
        
        if (_indexPath.row == 0) {
            _optionLabel.text = @"充值帐号";
            if ([THUserTool getUser].username.length > 0) {
                _infoLabel.text = [THUserTool getUser].username;
            }else{
                _infoLabel.text = @"**********";
            }
        }else{
            _optionLabel.text = @"充值时间";
            _infoLabel.text = @"年";
            self.infoTextField = [[UITextField alloc]init];
            _infoTextField.textAlignment = NSTextAlignmentCenter;
            _infoTextField.text = @"1";
            _infoTextField.font = [UIFont systemFontOfSize:20];
            _infoTextField.textColor = [UIColor blackColor];
            _infoTextField.layer.borderColor = [UIColor colorWithRed:18/255.0 green:36/255.0 blue:241/255.0 alpha:1].CGColor;
            _infoTextField.layer.borderWidth = 1;
            [self addSubview:_infoTextField];
            [_infoTextField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(_infoLabel.mas_left).with.offset(-0.0334*WIDTH);
                make.centerY.equalTo(self);
                make.width.and.height.mas_equalTo(0.1067*WIDTH);
            }];
            
        }
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"箭头"] forState:UIControlStateNormal];
        btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).with.offset(-0.0267*WIDTH);
            make.top.equalTo(self).with.offset(0.03*HEIGHT);
            make.height.mas_equalTo(0.0255*HEIGHT);
            make.width.mas_equalTo(0.0225*HEIGHT);
        }];
        
    }else if (_indexPath.section == 1){

        self.infoLabel = [[UILabel alloc]init];
        _infoLabel.textAlignment = NSTextAlignmentRight;
        _infoLabel.font = [UIFont systemFontOfSize:20];
        [_infoLabel sizeToFit];
        [self addSubview:_infoLabel];
        [_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).with.offset(-0.0267*HEIGHT);
            make.centerY.equalTo(self);
            make.width.mas_equalTo(0.1799*HEIGHT);
        }];
        
        if (_indexPath.row == 0) {
            _optionLabel.text = @"实际价格";
            _infoLabel.text = @"****元";
        }else{
            _optionLabel.text = @"优惠价格";
            _infoLabel.text = @"****元";
        }
    }
    
}

@end
