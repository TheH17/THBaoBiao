//
//  THChargeController.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/12.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "THChargeController.h"

#import "THChargeSectionOneView.h"
#import "THChargeFooterView.h"

#import "THChargeSuccessController.h"

#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height

@interface THChargeController ()<THChargeFooterViewDelegate>

@end

@implementation THChargeController

static NSString *reuseIdentifier = @"ChargeCell";

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.tableView.backgroundColor = [UIColor redColor];
    self.tableView.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:235/255.0 alpha:1];
    self.tableView.scrollEnabled = NO;
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
//    [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    THChargeFooterView *chargeFooterView = [[THChargeFooterView alloc]initWithFrame:CGRectMake(0, 0, Width, 0.1199*Height)];
    chargeFooterView.delegate = self;
    self.tableView.tableFooterView = chargeFooterView;
    
    THLog(@"%@",NSStringFromCGRect(self.tableView.tableFooterView.frame));
    
}

#pragma mark - footerView的delegate方法
-(void)chargeNow{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"功能暂未实现，请等待下个版本" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
//    THChargeSuccessController *vc = [[THChargeSuccessController alloc]init];
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    CGRect frame = cell.bounds;
    frame.size.height = 0.085 * Height;
    frame.size.width = Width;
    cell.frame = frame;
    if (indexPath.section < 2) {
        THChargeSectionOneView *view = [[THChargeSectionOneView alloc]initWithFrame:cell.bounds withIndexPath:indexPath];
        [cell.contentView addSubview:view];
    }else{
        THChargeSectionOneView *view = [[THChargeSectionOneView alloc]initWithFrame:cell.bounds withRow:indexPath.row];
        [cell.contentView addSubview:view];
//         THLog(@"111%@",NSStringFromCGRect(view.bounds));
    }
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 0.085*Height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.03*Height;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
