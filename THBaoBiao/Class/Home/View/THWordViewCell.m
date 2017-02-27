//
//  THWordViewCell.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 16/10/14.
//  Copyright © 2016年 李浩鹏. All rights reserved.
//

#import "THWordViewCell.h"
#import "THOldKeyWordView.h"

@implementation THWordViewCell

-(BOOL)canBecomeFirstResponder{
    return YES;
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    if (action == @selector(func)) {
        return YES;
    }
    return NO;
}
-(void)handLong{
    [self becomeFirstResponder];
    UIMenuItem *item = [[UIMenuItem alloc]initWithTitle:@"删除" action:@selector(func)];
    
    [[UIMenuController sharedMenuController] setTargetRect:CGRectMake(0, 0, 40, 40) inView:self];
    [UIMenuController sharedMenuController].menuVisible = YES;
    [UIMenuController sharedMenuController].menuItems = @[item];
    
    
}

-(void)func{
    //    THLog(@"123%@", self.lab.text);
    [self.fatherView deleteWord:self.index];
}


@end
