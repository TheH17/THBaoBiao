//
//  THInfoListCell.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/10/16.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "THInfoListCell.h"
#import "Masonry.h"
#import "THInfoData.h"

@interface THInfoListCell()

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) THInfoData *data;

@end

@implementation THInfoListCell

-(void)setData:(THInfoData *)data{
    _data = data;
    NSRange strRange = {0, 10};
    NSString *timeString = [data.fetchTime substringWithRange:strRange];
    _isCheck = [data.isCheckValue boolValue];
    [self setSiteName:data.name urlText:data.url timeText:timeString mirrorUrl:data.mirrorUrl];
}

-(THInfoData *)getData{
    return _data;
}

-(void)setSiteName:(NSString *)name urlText:(NSString *)url timeText:(NSString *)time mirrorUrl:(NSString *)mirrorUrl{
    _siteName = name;
    _urlText = url;
    _timeText = time;
    _mirrorUrl = mirrorUrl;
    [self layoutUI];
}

-(void)layoutUI{
    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    UILabel *nameLabel = [[UILabel alloc]init];
    //WithFrame:CGRectMake(10, 15, 120, 15)
    nameLabel.text = _siteName;
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.font = [UIFont systemFontOfSize:15];
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:_siteName];
    NSRange contentRange = {0, [content length]};
    [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
    nameLabel.attributedText = content;
    nameLabel.textColor = _isCheck ? [UIColor redColor] : [UIColor blueColor];
    [self.contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(0.0267*w);
        make.top.equalTo(self).with.offset(0.0225*h);
        make.bottom.equalTo(self).with.offset(-0.0225*h);
        make.width.mas_equalTo(0.6666*w);
    }];
    _nameLabel = nameLabel;
    
    
    UILabel *timeLabel = [[UILabel alloc]init];
    //WithFrame:CGRectMake(140, 15, [UIScreen mainScreen].bounds.size.width - 170, 15)
    timeLabel.textColor = [UIColor blackColor];
    timeLabel.textAlignment = NSTextAlignmentLeft;
    timeLabel.font = [UIFont systemFontOfSize:15];
    timeLabel.text = _timeText;
    timeLabel.userInteractionEnabled = YES;
//    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTouchUpInside)];
//    
//    [timeLabel addGestureRecognizer:labelTapGestureRecognizer];
    [self.contentView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel.mas_right).with.offset(0.0267*w);
        make.top.and.bottom.equalTo(nameLabel);
        make.right.equalTo(self);
    }];
}

-(void)setColorWhenClick{
    _nameLabel.textColor = [UIColor redColor];
    _data.isCheckValue = [NSNumber numberWithBool:YES];
}

//-(void)labelTouchUpInside{
//    //调用本地浏览器
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_urlText]];
//}

@end
