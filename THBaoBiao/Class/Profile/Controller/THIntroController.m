//
//  THIntroController.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 2017/1/7.
//  Copyright © 2017年 李浩鹏. All rights reserved.
//

#import "THIntroController.h"
#import "THIntroHeaderView.h"
#import "THIntroCellView.h"
#import "THShareView.h"
#import "AppDelegate.h"
#import "THWeiChatTool.h"

#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height


@interface THIntroController ()<THShareDelegate, THWxDelegate, THIntroDelegate, UIAlertViewDelegate>

@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, strong) THShareView *shareView;

@end

@implementation THIntroController

static NSString *reuseIdentifier = @"ProfileIntroCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:247/255.0 alpha:1];
    self.tableView.scrollEnabled = NO;
    
    [self.navigationController setTitle:@"保标详情"];
    self.title = @"保标详情";
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    THIntroHeaderView *headerView = [[THIntroHeaderView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 0.225*HEIGHT)];
    self.tableView.tableHeaderView = headerView;
    self.cellHeight = (HEIGHT - 0.1799*HEIGHT - 70 - 60 - 0.03*HEIGHT*2)/3;
    
    self.shareView = [[THShareView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height * 2, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _shareView.delegate = self;
    [self.view addSubview:_shareView];
    
}
#pragma mark THShareDelegate
-(void)shareWithType:(int)type{
    ((AppDelegate *)[UIApplication sharedApplication].delegate).wxDelegate = self;
    [THWeiChatTool shareWithType:type url:THAppShareUrl];
}

#pragma mark 监听微信分享是否成功 delegate
-(void)closeView{
    [self closeShareView];
}
-(void)shareSuccessByCode:(int)code{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"分享成功" message:[NSString stringWithFormat:@"reason : %d",code] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

-(void)closeShareView{
    [UIView animateWithDuration:0.5 animations:^{
        [_shareView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height * 2, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - THItroDelegate
-(void)showShareView{
    [self.view bringSubviewToFront:_shareView];
    [UIView animateWithDuration:0.5 animations:^{
        [_shareView setFrame:CGRectMake(0, -90, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        
    } completion:^(BOOL finished) {
        
    }];
}

-(void)callForHelp{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"点击拨号会为您拨打客服号码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拨号", nil];
    
    [alertView show];
}

#pragma mark UIAlertDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat: @"tel:%@", THAppHelpPhone]]];
    }else{
        [alertView removeFromSuperview];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (section < 2) ? 2 : 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    CGRect frame = cell.bounds;
    frame.size.width = WIDTH;
    if (indexPath.section ==2) {
        frame.size.height = _cellHeight;
    }else{
        frame.size.height = _cellHeight/2;
    }
    cell.frame = frame;
    
    THIntroCellView *view = [[THIntroCellView alloc] initWithFrame:cell.bounds withIndexPath:indexPath];
    if (indexPath.section == 1) {
        view.delegate = self;
    }
    
    [cell.contentView addSubview:view];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==2) {
        return _cellHeight;
    }else{
        return _cellHeight/2;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section ==2) {
        return 0;
    }else{
        return 0.03*HEIGHT;
    }
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
