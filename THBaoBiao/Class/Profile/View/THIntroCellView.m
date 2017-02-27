//
//  THIntroCellView.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 2017/1/7.
//  Copyright © 2017年 李浩鹏. All rights reserved.
//

#import "THIntroCellView.h"
#import "Masonry.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface THIntroCellView()

@property (nonatomic, strong) NSIndexPath *indexPath;

@end

@implementation THIntroCellView

-(instancetype)initWithFrame:(CGRect)frame withIndexPath:(NSIndexPath *)indexPath{
    if (self = [super initWithFrame:frame]) {
        _indexPath = indexPath;
        [self layoutUI];
    }
    return self;
}

-(void)layoutUI{
    UILabel *firstTitleLabel = [[UILabel alloc]init];
    firstTitleLabel.textAlignment = NSTextAlignmentCenter;
    firstTitleLabel.font = [UIFont systemFontOfSize:17];
    [self addSubview:firstTitleLabel];
    
    if (_indexPath.section == 0) {
        
        [firstTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).with.offset(0.0267*WIDTH);
            make.width.mas_equalTo(0.25*WIDTH);
        }];
        
        UILabel *secondTitleLabel = [[UILabel alloc]init];
        secondTitleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:secondTitleLabel];
        [secondTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(firstTitleLabel.mas_right).with.offset(0.0267*WIDTH);
            make.right.equalTo(self).with.offset(-0.0267*WIDTH);
            make.centerY.equalTo(self);
        }];
        if (_indexPath.row == 0) {
            
            secondTitleLabel.font = [UIFont systemFontOfSize:14];
            firstTitleLabel.text = @"功能介绍：";
            secondTitleLabel.text = @"快速高效采集推送最新的招标投标信息";
        }else{
            
            secondTitleLabel.font = [UIFont systemFontOfSize:17];
            firstTitleLabel.text = @"产品所属：";
            secondTitleLabel.text = @"世舶科技（武汉）有限公司";
        }
    }else if(_indexPath.section == 1){
        
        [firstTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).with.offset(0.0267*WIDTH);
            make.width.mas_equalTo(0.2933*WIDTH);
        }];
        
        if (_indexPath.row == 0) {
            
            firstTitleLabel.text = @"客服电话：";
            
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:THAppHelpPhone];
            NSRange strRange = {0,[str length]};
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:strRange];  //设置颜色
            [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setFrame:CGRectMake(120, 15, 120, HEIGHT - 30)];
            [[btn titleLabel] setFont:[UIFont systemFontOfSize:15]];
            [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];      //btn左对齐
            [btn setAttributedTitle:str forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(phoneClick) forControlEvents:UIControlEventTouchUpInside];
            [btn sizeToFit];
            [self addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.left.equalTo(firstTitleLabel.mas_right).with.offset(0.0267*WIDTH);
            }];
            
        }else{
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
            
        }
    }else{
        
        [firstTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(0.0267*WIDTH);
            make.left.equalTo(self).with.offset(0.0267*WIDTH);
            make.width.mas_equalTo(0.2933*WIDTH);
        }];
        firstTitleLabel.text = @"产品介绍：";
        
        UILabel *secondTitleLabel = [[UILabel alloc]init];
        secondTitleLabel.textAlignment = NSTextAlignmentLeft;
        secondTitleLabel.font = [UIFont systemFontOfSize:17];
        secondTitleLabel.numberOfLines = 0;
        [self addSubview:secondTitleLabel];
        [secondTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(firstTitleLabel.mas_right).with.offset(0.0267*WIDTH);
            make.right.equalTo(self).with.offset(-0.0267*WIDTH);
            make.top.equalTo(self).with.offset(0.0267*WIDTH);
        }];
        secondTitleLabel.text = @"一款项目信息聚合神器";
    }
}

-(void)phoneClick{
    [self.delegate callForHelp];
}

-(void)shareClick{
    [self.delegate showShareView];
}

@end




















