//
//  THInfoListCell.h
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/10/16.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@class THInfoData;
@interface THInfoListCell : UITableViewCell

@property (nonatomic, copy) NSString *siteName;

@property (nonatomic, copy) NSString *urlText;

@property (nonatomic, copy) NSString *mirrorUrl;

@property (nonatomic, copy) NSString *timeText;

@property (nonatomic, assign) BOOL isCheck;

-(void)setData:(THInfoData *)data;

-(THInfoData *)getData;

-(void)setColorWhenClick;

@end
