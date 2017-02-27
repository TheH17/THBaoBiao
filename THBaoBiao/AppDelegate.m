//
//  AppDelegate.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/12.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "AppDelegate.h"

#import "THLoginController.h"
//#import "THTabBarController.h"
//#import "THSignUpController.h"
//#import "THNewFeatureController.h"

#import "THLoginTool.h"
#import "THKeyWordTool.h"
#import "THKeyWordResult.h"
#import "THUserTool.h"
#import "THUser.h"
#import "THRootTool.h"
#import "THLocationTool.h"
//#import <CoreLocation/CoreLocation.h>
#import "WXApi.h"
#import "LocationTracker.h"
#import "THNavigationController.h"
@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate

#pragma merk 微信返回

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    /*! @brief 处理微信通过URL启动App时传递的数据
     *
     * 需要在 application:openURL:sourceApplication:annotation:或者application:handleOpenURL中调用。
     * @param url 微信启动第三方应用时传递过来的URL
     * @param delegate  WXApiDelegate对象，用来接收微信触发的消息。
     * @return 成功返回YES，失败返回NO。
     */
    return [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation{
    return [WXApi handleOpenURL:url delegate:self];
}

/*! 微信回调，不管是登录还是分享成功与否，都是走这个方法 @brief 发送一个sendReq后，收到微信的回应
 *
 * 收到一个来自微信的处理结果。调用一次sendReq后会收到onResp。
 * 可能收到的处理结果有SendMessageToWXResp、SendAuthResp等。
 * @param resp具体的回应内容，是自动释放的
 */
-(void) onResp:(BaseResp*)resp{
    NSLog(@"resp %d",resp.errCode);
    
    /*
     enum  WXErrCode {
     WXSuccess           = 0,    成功
     WXErrCodeCommon     = -1,  普通错误类型
     WXErrCodeUserCancel = -2,    用户点击取消并返回
     WXErrCodeSentFail   = -3,   发送失败
     WXErrCodeAuthDeny   = -4,    授权失败
     WXErrCodeUnsupport  = -5,   微信不支持
     };
     */
//    if ([resp isKindOfClass:[SendAuthResp class]]) {   //授权登录的类。
//        if (resp.errCode == 0) {  //成功。
//            //这里处理回调的方法 。 通过代理吧对应的登录消息传送过去。
//            if ([_wxDelegate respondsToSelector:@selector(loginSuccessByCode:)]) {
//                SendAuthResp *resp2 = (SendAuthResp *)resp;
//                [_wxDelegate loginSuccessByCode:resp2.code];
//            }
//        }else{ //失败
//            NSLog(@"error %@",resp.errStr);
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"登录失败" message:[NSString stringWithFormat:@"reason : %@",resp.errStr] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//            [alert show];
//        }
//    }
    
    if ([resp isKindOfClass:[SendMessageToWXResp class]]) { //微信分享 微信回应给第三方应用程序的类
        SendMessageToWXResp *response = (SendMessageToWXResp *)resp;
        NSLog(@"error code %d  error msg %@  lang %@   country %@",response.errCode,response.errStr,response.lang,response.country);
        
        if (resp.errCode == 0) {  //成功。
            //这里处理回调的方法 。 通过代理吧对应的登录消息传送过去。
            if (_wxDelegate) {
                if([_wxDelegate respondsToSelector:@selector(shareSuccessByCode:)]){
                    [_wxDelegate shareSuccessByCode:response.errCode];
                }
                [_wxDelegate closeView];
            }
        }else{ //失败
            [_wxDelegate closeView];
            NSLog(@"error %@",resp.errStr);
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"分享失败" message:[NSString stringWithFormat:@"reason : %@",resp.errStr] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
        }
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [WXApi registerApp:@"wxa22a27eb8fa77752"];
    [self initLoaction];
    THUser *user = [THUserTool getUser];
    if (user) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"phonenum"] = user.phonenum;
        params[@"password"] = user.password;
        params[@"askForSites"] = @"true";
        
        [THLoginTool loginWithParameters:params success:^(NSString *status, NSString *message) {
            //登录成功，跳转到新特性或者主界面
            [THRootTool chooseRootColForWindow:self.window];
            //显示窗口
            [self.window makeKeyAndVisible];
        } failure:^(NSError *error) {
            //登录失败，也跳转到新特性或者主界面，不存在用户信息
            [THRootTool chooseRootColForWindow:self.window];
            //显示窗口
            [self.window makeKeyAndVisible];
        }];
    }else{
        //用户未登录，跳转到新特性或者主界面，不存在用户信息
        [THRootTool chooseRootColForWindow:self.window];
        //显示窗口
        [self.window makeKeyAndVisible];
    }
    return YES;
}

-(void)initLoaction{
    
    THUser *user = [THUserTool getUser];
    if (user) {
        user.province = nil;
        user.city = nil;
        user.area = nil;
        user.useLocate = @"NO";
        [THUserTool saveUser:user];
    }else if([THKeyWordTool getWords]){
        THKeyWordResult *result = [THKeyWordTool getWords];
        result.province = nil;
        result.city = nil;
        result.area = nil;
        result.useLocate = @"NO";
        [THKeyWordTool saveWords:result];
    }
    
    [THLocationTool saveLocationData:nil];
    UIAlertView * alert;
    if([[UIApplication sharedApplication] backgroundRefreshStatus] == UIBackgroundRefreshStatusDenied){
        
        alert = [[UIAlertView alloc]initWithTitle:@""
                                          message:@"The app doesn't work without the Background App Refresh enabled. To turn it on, go to Settings > General > Background App Refresh"
                                         delegate:nil
                                cancelButtonTitle:@"Ok"
                                otherButtonTitles:nil, nil];
        [alert show];
        
    }else if([[UIApplication sharedApplication] backgroundRefreshStatus] == UIBackgroundRefreshStatusRestricted){
        
        alert = [[UIAlertView alloc]initWithTitle:@""
                                          message:@"The functions of this app are limited because the Background App Refresh is disable."
                                         delegate:nil
                                cancelButtonTitle:@"Ok"
                                otherButtonTitles:nil, nil];
        [alert show];
        
    } else{
        
        self.locationTracker = [[LocationTracker alloc]init];
        [self.locationTracker startLocationTracking];
        
        //Send the best location to server every 60 seconds
        //You may adjust the time interval depends on the need of your app.
        NSTimeInterval time = 15.0;
        self.locationUpdateTimer =
        [NSTimer scheduledTimerWithTimeInterval:time
                                         target:self
                                       selector:@selector(updateLocation)
                                       userInfo:nil
                                        repeats:YES];
    }
}
-(void)updateLocation {
    NSLog(@"updateLocation");
    
    [self.locationTracker updateLocationToServer];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    //1
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    //2
    //调整nav
    for (THNavigationController *vc in self.window.rootViewController.childViewControllers) {
        [vc changeNav];
    }
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
