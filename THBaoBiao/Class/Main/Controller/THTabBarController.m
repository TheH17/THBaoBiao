//
//  THTabBarController.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/12.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "THTabBarController.h"

#import "THHomeController.h"
#import "THInfosController.h"
#import "THChargeController.h"
#import "THProfileController.h"

#import "THTabBar.h"
#import "THTabBarButton.h"
#import "THNavigationController.h"
@interface THTabBarController ()<THTabBarDelegate>

@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation THTabBarController

-(void)setSelectedIndex:(NSUInteger)selectedIndex{
    [super setSelectedIndex:selectedIndex];
    THLog(@"%@", self.tabBar.subviews);
    for (UIView *view in self.tabBar.subviews) {
        if ([view isKindOfClass:[THTabBar class]]) {
            for (UIView *subView in view.subviews) {
                if ([subView isKindOfClass:[THTabBarButton class]]){
                    
                    if (((THTabBarButton *)subView).type == selectedIndex) {
                        ((THTabBarButton *)subView).selected = YES;
                    }else{
                        ((THTabBarButton *)subView).selected = NO;
                    }
                }
            }
            break;
        }
    }
}

-(NSMutableArray *)items{
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //管理tabbar的四个子控制器
    [self setUpChildViewController];
    //自定义tabbar
    [self setUpTabBar];
//    self.selectedIndex = 1;
}

//改变tabbar的高度（本次app需要）
//注意因为我们是将自定义的tabbar加到系统的tabbar上面所以需要修改两个
//这里会出现问题，在uiview的initWithFrame方法以及点语法设置frame时一定要采用bounds来设置
- (void)viewWillLayoutSubviews{
    
    CGRect tabFrame = self.tabBar.frame; //self.TabBar is IBOutlet of your TabBar
    CGFloat y = tabFrame.origin.y + tabFrame.size.height - 60;
    tabFrame.size.height = 60;
    tabFrame.origin.y = y;
    self.tabBar.frame = tabFrame;
    for (UIView *view in self.tabBar.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"THTabBar")]) {
            view.frame = self.tabBar.bounds;
        }
    }
}

#pragma mark - 设置自定义tabBar
-(void)setUpTabBar{
    THTabBar *tabBar = [[THTabBar alloc] initWithFrame:self.tabBar.bounds];
    tabBar.backgroundColor = [UIColor whiteColor];
    
    //传递item数组用于设置按钮
    tabBar.items = self.items;
    tabBar.delegate = self;
    
    //添加自定义tabBar到系统的tabbar上面
    //这样做会导致系统自带的tabbar上面的按钮和我们自定义的按钮发生重叠
    //解决的办法是在tabbar加载的时候消去系统的按钮，一般选择在导航条哪里完成
    [self.tabBar addSubview:tabBar];
    
}

#pragma mark - tabBar代理方法
-(void)didClickButton:(NSInteger)index{
    //tabbar自带的选中方法
    self.selectedIndex = index;
}

#pragma mark - 管理tabBar的子控制器，一共有四个控制器
//将文件封装到单独的文件上面可以保证代码的可用性
-(void)setUpChildViewController{
    //1.首页
    THHomeController *home = [[THHomeController alloc]init];
    [self setChildControllerFrom:home andImage:@"home" andSelectedImage:@"home_selected" andTitle:@"保标CAT"];
    //2.信息
    THInfosController *info = [[THInfosController alloc]init];
    [self setChildControllerFrom:info andImage:@"info" andSelectedImage:@"info_selected" andTitle:@"招标信息"];
//    //3.充值
//    THChargeController *charge = [[THChargeController alloc]init];
//    [self setChildControllerFrom:charge andImage:@"charge" andSelectedImage:@"charge_selected" andTitle:@"充值"];
    //4.个人中心
    THProfileController *profile = [[THProfileController alloc]init];
    [self setChildControllerFrom:profile andImage:@"profile" andSelectedImage:@"profile_selected" andTitle:@"个人中心"];
}

#pragma mark - 添加子控件并赋值
-(void)setChildControllerFrom:(UIViewController *)controller andImage:(NSString *)icon andSelectedImage:(NSString *)icon_selected andTitle:(NSString *)title{
    //设置图片，创建分类，目的是建立一个没有经过渲染的原始图片
    controller.tabBarItem.image = [UIImage imageWithName:icon];
    controller.tabBarItem.selectedImage = [UIImage imageWithName:icon_selected];
    //设置标题
    controller.title = title;
//    controller.tabBarItem.badgeValue = @"10";
    //将tabBarItem传入数组中保存起来，用于自定义tabbar时候使用
    [self.items addObject:controller.tabBarItem];
    
    //为每一个controller加上一个顶部的导航条
    THNavigationController *navController = [[THNavigationController alloc]initWithRootViewController:controller];
    
    [self addChildViewController:navController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
