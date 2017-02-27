//
//  THWeiChatTool.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 2017/1/8.
//  Copyright © 2017年 李浩鹏. All rights reserved.
//

#import "THWeiChatTool.h"
#import "WXApi.h"
@implementation THWeiChatTool

+(void)shareWithType:(int)type url:(NSString *)url{
    if(![WXApi isWXAppInstalled]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您没有安装微信无法进行此操作" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    //创建分享内容对象
    WXMediaMessage *urlMessage = [WXMediaMessage message];
    urlMessage.title = @"保标APP分享";//分享标题
    urlMessage.description = @"查看更多招标信息下载 “保标” app";//分享描述
    [urlMessage setThumbImage:[UIImage imageNamed:@"1024 6"]];//分享图片,使用SDK的setThumbImage方法可压缩图片大小
    
    //创建多媒体对象
    WXWebpageObject *webObj = [WXWebpageObject object];
//    webObj.webpageUrl = url;//分享链接
    webObj.webpageUrl = @"www.baidu.com";
    
    //完成发送对象实例
    urlMessage.mediaObject = webObj;
    
    //创建发送对象实例
    SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
    sendReq.bText = NO;//不使用文本信息
    sendReq.message = urlMessage;
    sendReq.scene = type;//0 = 好友列表 1 = 朋友圈 2 = 收藏
    
    //发送分享信息
    [WXApi sendReq:sendReq];
}

@end
