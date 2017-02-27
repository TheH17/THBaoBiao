//
//  THWebViewController.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 2016/11/14.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "THWebViewController.h"
#import "UIBarButtonItem+THBarItem.h"
#import "THShareView.h"
#import "WXApi.h"
#import "AppDelegate.h"

@interface THWebViewController ()<UIWebViewDelegate, THShareDelegate, THWxDelegate>

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, strong) UIView *opaqueView;

@property (nonatomic, strong) THShareView *shareView;

@end

@implementation THWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    webView.delegate = self;
    [webView setOpaque:NO];
    [webView setScalesPageToFit:YES];
    [self.view addSubview:webView];
    _webView = webView;
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:nil andSelectedImage:nil andTitle:@"分享" andTarget:self Action:@selector(showShareView) forControlEvents:UIControlEventTouchUpInside];
    
    [self layoutWeb];
    
    self.shareView = [[THShareView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height * 2, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _shareView.delegate = self;
    [self.view addSubview:_shareView];
    
}

-(void)layoutWeb{
    NSURL *url = [NSURL URLWithString:self.urlString];
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:3];
    
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [_webView loadRequest:request];
    
    UIView *opaqueView = [[UIView alloc]initWithFrame:self.view.frame];
    _opaqueView = opaqueView;
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc]initWithFrame:self.view.frame];
    _activityIndicatorView = activityIndicatorView;
    [activityIndicatorView setCenter:opaqueView.center];
    [activityIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [opaqueView setBackgroundColor:[UIColor blackColor]];
    [opaqueView setAlpha:0.6];
    [self.view addSubview:opaqueView];
    [opaqueView addSubview:activityIndicatorView];
}

#pragma mark THShareDelegate
-(void)shareWithType:(int)type{
    if(![WXApi isWXAppInstalled]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您没有安装微信无法进行此操作" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    //创建分享内容对象
    WXMediaMessage *urlMessage = [WXMediaMessage message];
    urlMessage.title = @"查看更多招标信息下载 “保标” app";//分享标题
    urlMessage.description = nil;//分享描述
    [urlMessage setThumbImage:[UIImage imageNamed:@"1024 6"]];//分享图片,使用SDK的setThumbImage方法可压缩图片大小
    
    //创建多媒体对象
    WXWebpageObject *webObj = [WXWebpageObject object];
    webObj.webpageUrl = _urlString;//分享链接
    
    //完成发送对象实例
    urlMessage.mediaObject = webObj;
    
    //创建发送对象实例
    SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
    sendReq.bText = NO;//不使用文本信息
    sendReq.message = urlMessage;
    sendReq.scene = type;//0 = 好友列表 1 = 朋友圈 2 = 收藏
    
    ((AppDelegate *)[UIApplication sharedApplication].delegate).wxDelegate = self;
    
    //发送分享信息
    [WXApi sendReq:sendReq];
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
-(void)showShareView{
    [UIView animateWithDuration:0.5 animations:^{
        [_shareView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark 网络相关
-(void)webViewDidStartLoad:(UIWebView *)webView{
    [_activityIndicatorView startAnimating];
    _opaqueView.hidden = NO;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [_activityIndicatorView startAnimating];
    _opaqueView.hidden = YES;
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error

{
    
    NSURL *url = [NSURL URLWithString:self.mirrorUrlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [_webView loadRequest:request];
    
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

//#pragma mark 微信登录
//- (void)weixinLogin {
//
//    if ([WXApi isWXAppInstalled]) {
//        SendAuthReq *req = [[SendAuthReq alloc]init];
//        req.scope = @"snsapi_userinfo";
//        req.openID = @"wxa22a27eb8fa77752";
//        req.state = @"1245";
//        ((AppDelegate *)[UIApplication sharedApplication].delegate).wxDelegate = self;
//
//        [WXApi sendReq:req];
//    }else{
//        //把微信登录的按钮隐藏掉。
//    }
//}
//#pragma mark 微信登录回调。
//-(void)loginSuccessByCode:(NSString *)code{
//    NSLog(@"code %@",code);
//    __weak typeof(*&self) weakSelf = self;
//
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];//请求
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//响应
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json",@"text/plain", nil];
//    //通过 appid  secret 认证code . 来发送获取 access_token的请求
//    [manager GET:[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",@"wxa22a27eb8fa77752",@"微信生成的appsecert",code] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {  //获得access_token，然后根据access_token获取用户信息请求。
//
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"dic %@",dic);
//
//        /*
//         access_token   接口调用凭证
//         expires_in access_token接口调用凭证超时时间，单位（秒）
//         refresh_token  用户刷新access_token
//         openid 授权用户唯一标识
//         scope  用户授权的作用域，使用逗号（,）分隔
//         unionid     当且仅当该移动应用已获得该用户的userinfo授权时，才会出现该字段
//         */
//        NSString* accessToken=[dic valueForKey:@"access_token"];
//        NSString* openID=[dic valueForKey:@"openid"];
//        [weakSelf requestUserInfoByToken:accessToken andOpenid:openID];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"error %@",error.localizedFailureReason);
//    }];
//
//}
//
//-(void)requestUserInfoByToken:(NSString *)token andOpenid:(NSString *)openID{
//
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [manager GET:[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",token,openID] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary *dic = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        //开发人员拿到相关微信用户信息后， 需要与后台对接，进行登录
//        NSLog(@"login success dic  ==== %@",dic);
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"error %ld",(long)error.code);
//    }];
//}

@end
