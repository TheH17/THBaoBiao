//
//  THMoreInfoController.h
//  THBaoBiao
//
//  Created by 李浩鹏 on 2016/12/6.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol THLogoutDelegate <NSObject>

-(void)reInitUIWhenLogout;

@end

@interface THMoreInfoController : UIViewController

@property (nonatomic, weak) id<THLogoutDelegate> delegate;

@end
