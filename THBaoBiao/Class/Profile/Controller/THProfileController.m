//
//  THProfileController.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/9/12.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "THProfileController.h"
#import "THProfileHeaderView.h"
#import "THProfileCellView.h"
#import "MBProgressHUD.h"
#import "THUser.h"
#import "THUserTool.h"
#import "THChangeInfoTool.h"
#import "THIndustryController.h"
#import "UIBarButtonItem+THBarItem.h"
#import "THMoreInfoController.h"
#import "THIntroController.h"

#import "THShareView.h"
#import "AppDelegate.h"
#import "THWeiChatTool.h"

#import "THRootTool.h"
#import "THHistoryController.h"

#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height

@interface THProfileController ()<THProfileHeaderViewDelegate,THProfileCellViewDelegate, THChangeIndustryDelegate, THShareDelegate, THWxDelegate, UIAlertViewDelegate, THLogoutDelegate>

@property (nonatomic, strong) THProfileHeaderView *headerView;

@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, strong) NSDictionary *industryDict;

@property (nonatomic, assign) long index;

@property (nonatomic, strong) THShareView *shareView;

@end

@implementation THProfileController

static NSString *reuseIdentifier = @"ProfileCell";

-(long)index{
    if (!_index) {
        _index = [[THUserTool getUser].industry longValue];
    }
    return _index;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:247/255.0 alpha:1];
    self.tableView.scrollEnabled = NO;
    [self layoutUI];
    
}

-(void)layoutUI{
    THProfileHeaderView *headerView = [[THProfileHeaderView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 0.1799*HEIGHT)];
    headerView.delegate = self;
    _headerView = headerView;
    self.tableView.tableHeaderView = headerView;
    
    self.cellHeight = (HEIGHT - 0.1799*HEIGHT - 70 - 60 - 0.03*HEIGHT*2)/3;
    [self initData];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handTap)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:@"more" andSelectedImage:@"more_selected" andTitle:@"" andTarget:self Action:@selector(changePassword) forControlEvents:UIControlEventTouchUpInside];
    
    self.shareView = [[THShareView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height * 2, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _shareView.delegate = self;
    [self.view addSubview:_shareView];
}

-(void)initData{
    _industryDict = [NSDictionary dictionaryWithObjectsAndKeys:@"机械设备加工", @"1", @"交通运输", @"2", @"出版印刷包装", @"3", @"安全防护", @"4", @"建筑水利桥梁", @"5", @"化工能源", @"6", @"电子电器", @"7", @"医疗卫生", @"8", @"通讯通信", @"9", @"计算机网络", @"10", @"环护绿化园林", @"11", @"商业服务", @"12", @"冶金矿产", @"13", @"科教办公", @"14", @"仪器仪表", @"15", @"艺术相关", @"16", @"农林渔牧", @"17", @"轻工业纺织食品", @"18", @"旅游运动娱乐", @"19", @"其他行业", @"20",nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)handTap{
    UITableViewCell *cell;
    //邮箱输入框
    cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    for (UIView *view in cell.contentView.subviews) {
        if ([view isKindOfClass:[THProfileCellView class]]) {
            for (UIView *subView in view.subviews) {
                if ([subView isKindOfClass:[UITextField class]]) {
                    [subView resignFirstResponder];
                }
            }
        }
    }
    //公司输入框
    cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    for (UIView *view in cell.contentView.subviews) {
        if ([view isKindOfClass:[THProfileCellView class]]) {
            for (UIView *subView in view.subviews) {
                if ([subView isKindOfClass:[UITextField class]]) {
                    [subView resignFirstResponder];
                }
            }
        }
    }
}

#pragma mark alertDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [THRootTool changeRootControllerToLogin:self];
    }else{
        [alertView removeFromSuperview];
    }
}

#pragma mark changePass
-(void)changePassword{
    
    if (![THUserTool getUser]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"失败" message:@"您还没有登录无法使用此功能" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"现在去登录", nil];
        
        [alertView show];
        return;
    }
    
    THMoreInfoController *vc = [[THMoreInfoController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark THLogoutDelegate
-(void)reInitUIWhenLogout{
    for (UIView *view in self.view.subviews) {
        if([view isKindOfClass:[THProfileHeaderView class]] || [view isKindOfClass:[THShareView class]])
        [view removeFromSuperview];
    }
    [self layoutUI];
    [self.tableView reloadData];
}

#pragma mark headerViewDelegate
-(void)changeInfo:(UIButton *)sender{
    if (![THUserTool getUser]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"失败" message:@"您还没有登录无法使用此功能" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"现在去登录", nil];
        
        [alertView show];
        return;
    }
    UITableViewCell *cell;
    //邮箱输入框
    cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    for (UIView *view in cell.contentView.subviews) {
        if ([view isKindOfClass:[THProfileCellView class]]) {
            for (UIView *subView in view.subviews) {
                if ([subView isKindOfClass:[UITextField class]]) {
                    subView.layer.borderColor = [UIColor grayColor].CGColor;
                    subView.layer.borderWidth = 1;
                    subView.userInteractionEnabled = YES;
                }
            }
        }
    }
    //行业选择按钮
    cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    for (UIView *view in cell.contentView.subviews) {
        if ([view isKindOfClass:[THProfileCellView class]]) {
            for (UIView *subView in view.subviews) {
                if ([subView isKindOfClass:[UIButton class]]) {
                    subView.layer.borderWidth = 1;
                    subView.userInteractionEnabled = YES;
                }
            }
        }
    }
    
    //公司输入框
    cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    for (UIView *view in cell.contentView.subviews) {
        if ([view isKindOfClass:[THProfileCellView class]]) {
            for (UIView *subView in view.subviews) {
                if ([subView isKindOfClass:[UITextField class]]) {
                    subView.layer.borderColor = [UIColor grayColor].CGColor;
                    subView.layer.borderWidth = 1;
                    subView.userInteractionEnabled = YES;
                }
            }
        }
    }
}

-(void)saveInfo{
    NSString *email;
    NSString *cor;
    
    UITableViewCell *cell;
    //邮箱输入框
    cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    for (UIView *view in cell.contentView.subviews) {
        if ([view isKindOfClass:[THProfileCellView class]]) {
            for (UIView *subView in view.subviews) {
                if ([subView isKindOfClass:[UITextField class]]) {
                    subView.layer.borderColor = [UIColor clearColor].CGColor;
                    subView.layer.borderWidth = 0;
                    subView.userInteractionEnabled = NO;
                    email = [NSString stringWithFormat:@"%@", ((UITextField *)subView).text];
                }
            }
        }
    }
    //行业输入框
    cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    for (UIView *view in cell.contentView.subviews) {
        if ([view isKindOfClass:[THProfileCellView class]]) {
            for (UIView *subView in view.subviews) {
                if ([subView isKindOfClass:[UIButton class]]) {
                    subView.layer.borderWidth = 0;
                    subView.userInteractionEnabled = NO;
                }
            }
        }
    }
    //公司输入框
    cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    for (UIView *view in cell.contentView.subviews) {
        if ([view isKindOfClass:[THProfileCellView class]]) {
            for (UIView *subView in view.subviews) {
                if ([subView isKindOfClass:[UITextField class]]) {
                    subView.layer.borderColor = [UIColor clearColor].CGColor;
                    subView.layer.borderWidth = 0;
                    subView.userInteractionEnabled = NO;
                    cor = [NSString stringWithFormat:@"%@", ((UITextField *)subView).text];
                }
            }
        }
    }
    MBProgressHUD * HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.mode = MBProgressHUDModeText;
    HUD.labelText = @"正在保存数据...";
    HUD.margin = 10;
    HUD.yOffset = [UIScreen mainScreen].bounds.size.height/3.0;
    HUD.removeFromSuperViewOnHide = YES;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"username"] = [THUserTool getUser].phonenum;
    params[@"email"] = email;
    params[@"corporation"] = cor;
    params[@"industry"] = [NSString stringWithFormat:@"%ld", self.index];
    [THChangeInfoTool saveInfoWithParameters:params success:^(NSString *stauts, NSString *message) {
        [HUD hide:YES];
        if (![stauts isEqualToString:@"ok"]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"修改失败" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
            return;
        }
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"修改成功" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        THUser *user = [THUserTool getUser];
        user.industry = [NSNumber numberWithInt:(int)self.index];
        user.email = email;
        user.corporation = cor;
        [THUserTool saveUser:user];
    } failure:^(NSError *error) {
        [HUD hide:YES];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"修改失败" message:@"网络故障请重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return;
    }];

}

#pragma mark cellViewDelegate
-(void)showHistory{
//    if (![THUserTool getUser]) {
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"失败" message:@"您还没有登录无法使用此功能" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
//        
//        [alertView show];
//        return;
//    }
    THHistoryController *vc = [[THHistoryController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)showShareView{
    [self.view bringSubviewToFront:_shareView];
    [UIView animateWithDuration:0.5 animations:^{
        [_shareView setFrame:CGRectMake(0, -150, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        
    } completion:^(BOOL finished) {
        
    }];
}

-(void)showIntro{
    THIntroController *vc = [[THIntroController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)selectIndustry{
    THIndustryController *vc = [[THIndustryController alloc]init];
    [vc setSelectedIndex:(int)self.index industryData:self.industryDict];
    vc.hidesBottomBarWhenPushed = YES;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark changeIndustry
-(void)changeIndustryWithIndex:(long)index{
    UITableViewCell *cell;
    //行业按钮
    cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    for (UIView *view in cell.contentView.subviews) {
        if ([view isKindOfClass:[THProfileCellView class]]) {
            for (UIView *subView in view.subviews) {
                if ([subView isKindOfClass:[UIButton class]]) {
                    NSString *key = [NSString stringWithFormat:@"%ld", index];
                    [((UIButton *)subView)setTitle:self.industryDict[key] forState:UIControlStateNormal];
                    self.index = index;
                }
            }
        }
    }
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
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"分享成功" message:[NSString stringWithFormat:@"reason : %d",code] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

-(void)closeShareView{
    [UIView animateWithDuration:0.5 animations:^{
        [_shareView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height * 2, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return (section < 2) ? 2 : 1;
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }else{
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
    }
    CGRect frame = cell.bounds;
    frame.size.width = WIDTH;
    frame.size.height = _cellHeight/2;
//    if (indexPath.section ==2) {
//        frame.size.height = _cellHeight;
//    }else{
//        frame.size.height = _cellHeight/2;
//    }
    cell.frame = frame;
    
    NSString *str = [self.industryDict objectForKey:[NSString stringWithFormat:@"%d", (int)self.index]];
    NSString *industry;
    if (str) {
        industry = [NSString stringWithString:str];
    }else{
        industry = @"请选择";
    }
    
    THProfileCellView *view = [[THProfileCellView alloc] initWithFrame:cell.bounds withIndexPath:indexPath withString:industry];
//    if (indexPath.section == 1 && indexPath.row == 1) {
//        view.delegate = self;
//    }else if (indexPath.section == 0 && indexPath.row == 1){
        view.delegate = self;
        
//    }
    [cell.contentView addSubview:view];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section ==2) {
//        return _cellHeight;
//    }else{
//        return _cellHeight/2;
//    }
    return _cellHeight/2;
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
