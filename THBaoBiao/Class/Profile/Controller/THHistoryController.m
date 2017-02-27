//
//  THHistoryController.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 2017/1/8.
//  Copyright © 2017年 李浩鹏. All rights reserved.
//

#import "THHistoryController.h"
#import "THInfoListCell.h"
#import "THWebViewController.h"
#import "THUserTool.h"
#import "THUser.h"
#import "THInfoTool.h"
#import "THInfoResult.h"
#import "THInfoData.h"
#import "UIBarButtonItem+THBarItem.h"

@interface THHistoryController ()<UIAlertViewDelegate>

@property (nonatomic, strong) NSArray *infoArray;

@property (nonatomic, strong) NSIndexPath *indexPath;

@end

@implementation THHistoryController

static NSString * const reuseIdentifier = @"InfoListHistoryViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:230/255.0 green:231/255.0 blue:232/255.0 alpha:1];
    [self loadInfo];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:nil andSelectedImage:nil andTitle:@"清空" andTarget:self Action:@selector(clearHistory) forControlEvents:UIControlEventTouchUpInside];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_indexPath) {
        [self.tableView scrollToRowAtIndexPath:_indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        _indexPath = nil;
    }
}

-(void)loadInfo{
    _infoArray = [[THInfoTool getHistoryInfoDataResult].data mutableCopy];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)clearHistory{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"警告" message:@"您即将清除所有的历史数据，操作不可恢复，是否确定" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
    [THInfoTool saveHistoryInfoDataResult:nil];
    
}

#pragma mark uialertView
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [THInfoTool saveHistoryInfoDataResult:nil];
        [self loadInfo];
    }else{
        [alertView removeFromSuperview];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _infoArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    THInfoListCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[THInfoListCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    }else{
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
    }
    THInfoData *data = self.infoArray[indexPath.row];
    [cell setData:data];
    cell.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:243/255.0 alpha:1];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    THInfoListCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [cell setColorWhenClick];
//    THInfoResult *result = [THInfoTool getInfoDataResult];
//    result.data = self.infoArray;
//    [THInfoTool saveInfoDataResult:result];
    [self loadWebViewWithUrlString:cell.urlText mirrorUrlString:cell.mirrorUrl indexPath:indexPath];
}

-(void)loadWebViewWithUrlString:(NSString *)string mirrorUrlString:(NSString *)mirrorUrl indexPath:(NSIndexPath *)indexPath{
    
    if (![THUserTool getUser]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"失败" message:@"您还没有登录无法使用此功能" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
        
        [alertView show];
        return;
    }
    
    THWebViewController *col = [[THWebViewController alloc]init];
    col.urlString = string;
    col.mirrorUrlString = mirrorUrl;
    col.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:col animated:YES];
    _indexPath = indexPath;
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
