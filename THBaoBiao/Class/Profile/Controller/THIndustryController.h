//
//  THIndustryController.h
//  THBaoBiao
//
//  Created by 李浩鹏 on 2016/11/17.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol THChangeIndustryDelegate <NSObject>

-(void)changeIndustryWithIndex:(long)index;

@end

@interface THIndustryController : UITableViewController

@property (nonatomic, assign) int selectedIndex;

@property (nonatomic, strong) NSDictionary *industryDict;

@property (nonatomic, weak) id<THChangeIndustryDelegate> delegate;

-(void)setSelectedIndex:(int)selectedIndex industryData:(NSDictionary *)dict;

@end
