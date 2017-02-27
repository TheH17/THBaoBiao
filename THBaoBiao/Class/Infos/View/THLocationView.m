//
//  THLocationView.m
//  THBaoBiao
//
//  Created by 李浩鹏 on 2017/1/10.
//  Copyright © 2017年 李浩鹏. All rights reserved.
//

#import "THLocationView.h"
#import "THLocationBtn.h"
#import "Masonry.h"

#import "THUser.h"
#import "THUserTool.h"
#import "THKeyWordResult.h"
#import "THKeyWordTool.h"

@interface THLocationView()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) THLocationBtn *provinceBtn;
@property (nonatomic, strong) THLocationBtn *cityBtn;
@property (nonatomic, strong) THLocationBtn *areaBtn;
@property (nonatomic, assign) BOOL isOpen;

@property (nonatomic , copy) NSString *selectedProvince;
@property (nonatomic , copy) NSString *selectedCity;
@property (nonatomic , copy) NSString *selectedArea;

@end

@implementation THLocationView

-(BOOL)checkIsOpen{
    return _isOpen;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.text = @"地    区：";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _titleLabel;
}

-(THLocationBtn *)provinceBtn{
    if (!_provinceBtn) {
        _provinceBtn = [THLocationBtn buttonWithType:UIButtonTypeCustom];
        _provinceBtn.layer.borderWidth = 0;
        if (self.selectedProvince) {
            [_provinceBtn setTitle:self.selectedProvince forState:UIControlStateNormal];
        }else{
            [_provinceBtn setTitle:@"选择省" forState:UIControlStateNormal];
        }
        
        _provinceBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_provinceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _provinceBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_provinceBtn setImage:[UIImage imageNamed:@"箭头"] forState:UIControlStateNormal];
        [_provinceBtn addTarget:self action:@selector(chooseArea) forControlEvents:UIControlEventTouchDown];
        
    }
    return _provinceBtn;
}

-(THLocationBtn *)cityBtn{
    if (!_cityBtn) {
        _cityBtn = [THLocationBtn buttonWithType:UIButtonTypeCustom];
        _cityBtn.layer.borderWidth = 0;
        if (self.selectedCity) {
            [_cityBtn setTitle:self.selectedCity forState:UIControlStateNormal];
        }else{
            [_cityBtn setTitle:@"选择市" forState:UIControlStateNormal];
        }
        
        _cityBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_cityBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _cityBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_cityBtn setImage:[UIImage imageNamed:@"箭头"] forState:UIControlStateNormal];
        [_cityBtn addTarget:self action:@selector(chooseArea) forControlEvents:UIControlEventTouchDown];
    }
    return _cityBtn;
}

-(THLocationBtn *)areaBtn{
    if (!_areaBtn) {
        _areaBtn = [THLocationBtn buttonWithType:UIButtonTypeCustom];
        _areaBtn.layer.borderWidth = 0;
        if (self.selectedArea) {
            [_areaBtn setTitle:self.selectedArea forState:UIControlStateNormal];
        }else{
            [_areaBtn setTitle:@"区或县" forState:UIControlStateNormal];
        }
        _areaBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_areaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _areaBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_areaBtn setImage:[UIImage imageNamed:@"箭头"] forState:UIControlStateNormal];
        [_areaBtn addTarget:self action:@selector(chooseArea) forControlEvents:UIControlEventTouchDown];
    }
    return _areaBtn;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:243/255.0 green:244/255.0 blue:246/255.0 alpha:1];
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor colorWithRed:213/255.0 green:214/255.0 blue:216/255.0 alpha:1].CGColor;
        _isOpen = NO;
        THUser *user = [THUserTool getUser];
        if (user) {
            self.selectedProvince = user.province;
            self.selectedCity = user.city;
            self.selectedArea = user.area;
        }else{
            THKeyWordResult *result = [THKeyWordTool getWords];
            self.selectedProvince = result.province;
            self.selectedCity = result.city;
            self.selectedArea = result.area;
        }
        [self layoutUI];
    }
    return self;
}



//加载UI
-(void)layoutUI{
    
//    CGFloat HEIGHT = [UIScreen mainScreen].bounds.size.height;
    CGFloat WIDTH = [UIScreen mainScreen].bounds.size.width;
    CGFloat w = WIDTH / 4.0;
    //1
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.bottom.equalTo(self);
        make.width.mas_equalTo(w);
    }];
    //2
    [self addSubview:self.provinceBtn];
    [self.provinceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.width.and.bottom.equalTo(self.titleLabel);
        make.left.equalTo(self.titleLabel.mas_right);
    }];
    //3
    [self addSubview:self.cityBtn];
    [self.cityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.width.and.bottom.equalTo(self.titleLabel);
        make.left.equalTo(self.provinceBtn.mas_right);
    }];
    //4
    [self addSubview:self.areaBtn];
    [self.areaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.width.and.bottom.equalTo(self.titleLabel);
        make.left.equalTo(self.cityBtn.mas_right);
    }];
    //addressPickerView
    
}

#pragma mark 选择地区
-(void)chooseArea{
    if (_isOpen) {
        self.provinceBtn.imageView.transform = CGAffineTransformMakeRotation(0);
        self.cityBtn.imageView.transform = CGAffineTransformMakeRotation(0);
        self.areaBtn.imageView.transform = CGAffineTransformMakeRotation(0);
    }else{
        self.provinceBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
        self.cityBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
        self.areaBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
        
        [self.delegate showAddressPickView];
    }
    
    _isOpen = !_isOpen;
}

-(void)cancelLoacation{
    [self chooseArea];
}

-(void)setProvince:(NSString *)province city:(NSString *)city area:(NSString *)area{
    [self.provinceBtn setTitle:province forState:UIControlStateNormal];
    [self.cityBtn setTitle:city forState:UIControlStateNormal];
    if (area) {
        [self.areaBtn setTitle:area forState:UIControlStateNormal];
    }else{
        [self.areaBtn setTitle:@"全部" forState:UIControlStateNormal];
    }
    
    THUser *user = [THUserTool getUser];
    if (user) {
        user.province = province;
        user.city = city;
        user.area = area;
        user.useLocate = @"YES";
        [THUserTool saveUser:user];
    }else{
        THKeyWordResult *result = [THKeyWordTool getWords];
        result.province = province;
        result.city = city;
        result.area = area;
        result.useLocate = @"YES";
        [THKeyWordTool saveWords:result];
    }
    
}

@end












