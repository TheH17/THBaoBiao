//
//  THOldWorldSiteController.h
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/27.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class THKeyWordAndWebsiteController;

@interface THOldWorldSiteController : UIViewController

@property (nonatomic, assign) int type;

@property (nonatomic, strong) NSMutableArray *datas;

@property (nonatomic, strong) THKeyWordAndWebsiteController *col;

@end
