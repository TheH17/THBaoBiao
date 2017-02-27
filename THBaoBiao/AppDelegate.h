//
//  AppDelegate.h
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/12.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LocationTracker;
@protocol THWxDelegate <NSObject>

//-(void)loginSuccessByCode:(NSString *)code;
-(void)shareSuccessByCode:(int) code;

-(void)closeView;

@end

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, weak) id<THWxDelegate> wxDelegate;


@property (strong, nonatomic) LocationTracker * locationTracker;
@property (strong, nonatomic) NSTimer* locationUpdateTimer;

@end

