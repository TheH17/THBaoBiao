//
//  THRootTool.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/10/24.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "THRootTool.h"
#import "THTabBarController.h"
#import "THNewFeatureController.h"
#import "THLoginController.h"

#define THVersionKey @"version"

@implementation THRootTool

+(void)chooseRootColForWindow:(UIWindow *)window{
    //获取当前的版本号
    NSString *currentVerison = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    //获取上次的版本号
    NSString *lastVerison = [[NSUserDefaults standardUserDefaults] objectForKey:THVersionKey];
    //比较两次的版本号
    if ([currentVerison isEqualToString:lastVerison]) {
        THTabBarController *tabBarVc = [[THTabBarController alloc] init];
        //登陆成功
        
            window.rootViewController = tabBarVc;
        
    }else{
        THNewFeatureController *newFeatureVc = [[THNewFeatureController alloc] init];
        //登陆成功
        [UIView animateWithDuration:1.0 animations:^{
            window.rootViewController = newFeatureVc;
        }];
    }
    [[NSUserDefaults standardUserDefaults] setObject:currentVerison forKey:THVersionKey];
}

+(void)changeRootControllerToLogin:(UIViewController *)nowVc{
    THLoginController *vc = [[THLoginController alloc]init];
    
    [nowVc presentViewController:vc animated:YES completion:^{
        nowVc.view = nil;
    }];
}

@end
