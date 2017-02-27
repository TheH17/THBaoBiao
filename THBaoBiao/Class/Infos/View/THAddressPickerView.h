//
//  AddressPickerView.h
//  testUTF8
//
//  Created by rhcf_wujh on 16/7/14.
//  Copyright © 2016年 wjh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol THAddressPickerViewDelegate <NSObject>

/** 取消按钮点击事件*/
- (void)closeAddressView;

-(void)useLocationAuto;

/**
 *  完成按钮点击事件
 *
 *  @param province 当前选中的省份
 *  @param city     当前选中的市
 *  @param area     当前选中的区
 */
- (void)selectedProvince:(NSString *)province City:(NSString *)city Area:(NSString *)area;

@end

@interface THAddressPickerView : UIView

/** 实现点击按钮代理*/
@property (nonatomic ,weak) id<THAddressPickerViewDelegate> delegate;



- (void)moveToProvince:(NSString *)province City:(NSString *)city Area:(NSString *)area;

-(void)resetLocate;

@end
