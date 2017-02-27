//
//  THNavigationController.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/13.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "THNavigationController.h"
#import "UIBarButtonItem+THBarItem.h"

#import "THProfileController.h"

@interface THNavigationController ()<UINavigationControllerDelegate>

@property (nonatomic, strong) id popDelegate;

@end

@implementation THNavigationController

//设置两边按钮的颜色
+(void)initialize{
    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[self]] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //清空之前要保存，后续需要还原
    _popDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
//    //选择自己喜欢的颜色
//    UIColor * color = [UIColor whiteColor];
//    
//    //这里我们设置的是颜色，还可以设置shadow等，具体可以参见api
//    NSDictionary * dict = [NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
    
    //设置标题的大小颜色属性
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:30.0],NSFontAttributeName,nil]];
    
    
//    THLog(@"%f",self.navigationBar.frame.size.height);
    
    self.navigationBar.barTintColor = [UIColor colorWithRed:29/255.0 green:80/255.0 blue:247/255.0 alpha:1];
}
-(void)changeNav{
    CGRect frame = self.navigationBar.frame;
    //修改NavigaionBar的高度
    self.navigationBar.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 70);
}
//修改navbar的高度
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    NSLog(@"修改前");
//    [self printViewHierarchy:self.navigationBar];
    
    CGRect frame = self.navigationBar.frame;
    //修改NavigaionBar的高度
    self.navigationBar.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 70);
    
//    NSLog(@"\n修改后");
//    [self printViewHierarchy:self.navigationBar];
}

//- (void)printViewHierarchy:(UIView *)superView
//{
//    static uint level = 0;
//    for(uint i = 0; i < level; i++){
//        printf("\t");
//    }
//    
//    const char *className = NSStringFromClass([superView class]).UTF8String;
//    const char *frame = NSStringFromCGRect(superView.frame).UTF8String;
//    printf("%s:%s\n", className, frame);
//    
//    ++level;
//    for(UIView *view in superView.subviews){
//        [self printViewHierarchy:view];
//    }
//    --level;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//当控制器完全显示以后调用，用于设置滑动代理，解决滑动的bug
//当目前是跟控制器时要设置代理
//其它控制器时为了实现滑动我们要清空代理
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //表示此时已经回到根控制器
    if (viewController == self.viewControllers[0]) {
        //还原滑动的代理
        self.interactivePopGestureRecognizer.delegate = _popDelegate;
    }else{
        //实现滑动返回功能
        //清空滑动返回的代理就可以实现功能了
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}

//控制器准备显示的时候调用，用于设置重复显示系统按钮的bug
//原理是清除系统自带的tabbar上面的按钮
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //得到tabbarcontroller，目前它是根控制器
    UITabBarController *controller = (UITabBarController *)THKeyWindow.rootViewController;
    for (UIView *view in controller.tabBar.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [view removeFromSuperview];
        }
//        else if ([view isKindOfClass:NSClassFromString(@"THTabBar")]) {
//            THLog(@"111%@", NSStringFromCGRect(view.frame));
//        }
    }
//    if ([viewController isKindOfClass:[THProfileController class]]) {
//        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:@"more" andSelectedImage:@"more_selected" andTitle:@"" andTarget:(THProfileController *)viewController Action:@selector(changePassword) forControlEvents:UIControlEventTouchUpInside];
//    }
//    THLog(@"%@", NSStringFromCGRect(controller.tabBar.frame));
}
//将其它控制器加入栈时采取的操作，用于设置导航栏上面两边的按钮
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count) {
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:@"return" andSelectedImage:@"return_selected" andTitle:@"  返回" andTarget:self Action:@selector(backToPre) forControlEvents:UIControlEventTouchUpInside];
        
//        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:@"more" andSelectedImage:@"more_selected" andTitle:@"" andTarget:self Action:@selector(backToRoot) forControlEvents:UIControlEventTouchUpInside];
    }
    [super pushViewController:viewController animated:animated];
}

-(void)backToPre{
    [self popViewControllerAnimated:YES];
    
}

-(void)backToRoot{
    [self popToRootViewControllerAnimated:YES];
    
}

@end
