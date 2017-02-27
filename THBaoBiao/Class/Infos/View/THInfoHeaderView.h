//
//  THInfoHeaderView.h
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/22.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@class THInfoHeaderView;
@protocol THInfoHeaderDelegate <NSObject>

-(void)headerViewDidClick;

@end

@interface THInfoHeaderView : UITableViewHeaderFooterView

+(instancetype)headerViewFromTableView:(UITableView *)tableView;

@property (nonatomic, weak) id<THInfoHeaderDelegate> delegate;

@property (nonatomic, assign) BOOL open;

@end
