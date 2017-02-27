//
//  THChargeSuccessController.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/27.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "THChargeSuccessController.h"

#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height
@interface THChargeSuccessController ()

@end

@implementation THChargeSuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:237/255.0 green:236/255.0 blue:235/255.0 alpha:1];
//    [self.navigationController setTitle:@"保标"];
    self.title = @"充值";
    [self layoutUI];
}

-(void)layoutUI{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((WIDTH - 200)/2, HEIGHT / 2 - 40, 40, 40)];
    imageView.image = [UIImage imageNamed:@"成功"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(imageView.frame.origin.x + 50, imageView.frame.origin.y + 5, 150, 30)];
    label.font = [UIFont systemFontOfSize:30];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"充值成功!";
    //    countLabel.text = @"123";
    [self.view addSubview:label];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, HEIGHT - 100, WIDTH - 40, 60);
    button.backgroundColor = [UIColor colorWithRed:61/255.0 green:184/255.0 blue:23/255.0 alpha:1];
    button.layer.cornerRadius = 10;
    [button setTitle:@"返回主页面" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:20];
    [button addTarget:self action:@selector(backToRootControl) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
}

-(void)backToRootControl{
    
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
