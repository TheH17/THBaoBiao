//
//  AddressPickerView.m
//  testUTF8
//
//  Created by rhcf_wujh on 16/7/14.
//  Copyright © 2016年 wjh. All rights reserved.
//

#import "THAddressPickerView.h"
#import "THProvince.h"
#import "THCity.h"
#import "Masonry.h"
#import "NSArray+THLocationPick.h"
@interface THAddressPickerView ()<UIGestureRecognizerDelegate, UIPickerViewDelegate,UIPickerViewDataSource, UIAlertViewDelegate>

@property (nonatomic ,strong) UIButton * cancelBtn;/**< 取消按钮*/
@property (nonatomic, strong) UIButton * sureBtn;/**< 完成按钮*/

@property (nonatomic ,strong) UIPickerView   * addressPickerView;

@property (nonatomic, strong) NSMutableArray *provinces;


@property (nonatomic, assign) BOOL useAutoLocate;
@property (nonatomic, assign) NSInteger selectRowOfCom0;
@property (nonatomic, assign) NSInteger selectRowOfCom1;
@property (nonatomic, assign) NSInteger selectRowOfCom2;

@end
@implementation THAddressPickerView

-(NSMutableArray *)provinces{
    if (!_provinces) {
        _provinces = [NSMutableArray array];
    }
    return _provinces;
}

- (UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancelBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        _cancelBtn.layer.borderWidth = 0;
    }
    return _cancelBtn;
}

- (UIButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        _sureBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_sureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(sureBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        _sureBtn.layer.borderWidth = 0;
    }
    return _sureBtn;
}

- (UIPickerView *)addressPickerView{
    if (!_addressPickerView) {
        _addressPickerView = [UIPickerView new];
        _addressPickerView.backgroundColor = [UIColor colorWithRed:239/255.f green:239/255.f blue:244.0/255.f alpha:1.0];
        _addressPickerView.delegate = self;
        _addressPickerView.dataSource = self;
    }
    return _addressPickerView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.useAutoLocate = YES;
        //加载地址数据源
        [self loadData];
        //加载UI
        [self layoutUI];
    }
    return self;
}

-(void)loadData{
    if (self.provinces && self.provinces.count > 0) {
        return;
    }
    NSArray *provinceArray = [[NSMutableArray alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area" ofType:@"plist"]];
    for (NSDictionary *dict in provinceArray) {
        NSArray *cityArray = [dict objectForKey:@"cities"];
        THProvince *province = [THProvince provinceWithName:[dict objectForKey:@"state"] cities:cityArray];
        [self.provinces addObject:province];
    }
    for (THProvince *province in self.provinces) {
        NSMutableArray *temp = [NSMutableArray array];
        for (NSDictionary *dict in province.cities) {
            THCity *city = [THCity cityWithName:[dict objectForKey:@"city"] areas:[dict objectForKey:@"areas"]];
            [temp addObject:city];
        }
        province.cities = [temp mutableCopy];
    }
    
}

//加载UI
-(void)layoutUI{
    UISwipeGestureRecognizer *ges = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handSwipe)];
    ges.direction = UISwipeGestureRecognizerDirectionDown;
    ges.delegate = self;
    [self addGestureRecognizer:ges];
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    
    CGFloat HEIGHT = [UIScreen mainScreen].bounds.size.height;
    CGFloat WIDTH = [UIScreen mainScreen].bounds.size.width;
    //操作区域
    UIView *opView = [[UIView alloc]init];
    opView.backgroundColor = [UIColor whiteColor];
    [self addSubview:opView];
    [opView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(self);
        make.height.mas_equalTo(0.3748*HEIGHT);
    }];
    //1
    UIView *firstView = [[UIView alloc]init];
    firstView.backgroundColor = [UIColor whiteColor];
    [opView addSubview:firstView];
    [firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.equalTo(opView);
        make.height.mas_equalTo(0.075*HEIGHT);
    }];
    //确定
    [firstView addSubview:self.cancelBtn];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(firstView);
        make.left.equalTo(firstView).with.offset(0.0533*WIDTH);
        make.width.mas_equalTo(0.1333*WIDTH);
    }];
    //取消
    [firstView addSubview:self.sureBtn];
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(firstView);
        make.right.equalTo(firstView).with.offset(-0.0533*WIDTH);
        make.width.mas_equalTo(0.1333*WIDTH);
    }];
    
    //分割线
    UIView *sepView = [UIView new];
    [opView addSubview:sepView];
    sepView.backgroundColor = [UIColor grayColor];
    [sepView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.and.width.equalTo(opView);
        make.top.equalTo(firstView.mas_bottom);
        make.height.mas_equalTo(0.5);
    }];
    
    //2
    UIView *secondView = [UIView new];
    [opView addSubview:secondView];
    secondView.backgroundColor = [UIColor redColor];
    [secondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(opView);
        make.top.equalTo(sepView.mas_bottom);
    }];
    //addressPickerView
    [secondView addSubview:self.addressPickerView];
    [self.addressPickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.and.bottom.equalTo(secondView);
    }];
}

-(void)resetLocate{
    self.useAutoLocate = YES;
}

- (void)moveToProvince:(NSString *)province City:(NSString *)city Area:(NSString *)are{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    [self loadData];
    [self layoutUI];
    
    if (!self.useAutoLocate) {
        
        [self.addressPickerView selectRow:self.selectRowOfCom0 inComponent:0 animated:YES];
        [self.addressPickerView reloadComponent:1];
        [self.addressPickerView selectRow:self.selectRowOfCom1 inComponent:1 animated:YES];
        [self.addressPickerView reloadComponent:2];
        [self.addressPickerView selectRow:self.selectRowOfCom2 inComponent:2 animated:YES];
    }else if(province && city && are){
        self.selectRowOfCom0 = 0;
        self.selectRowOfCom1 = 0;
        self.selectRowOfCom2 = 0;
        [self.addressPickerView selectRow:self.selectRowOfCom0 inComponent:0 animated:YES];
        [self.addressPickerView reloadComponent:1];
        [self.addressPickerView selectRow:self.selectRowOfCom1 inComponent:1 animated:YES];
        [self.addressPickerView reloadComponent:2];
        [self.addressPickerView selectRow:self.selectRowOfCom2 inComponent:2 animated:YES];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"已为您定位到当前地点是%@%@%@，是否使用此地点", province, city, are] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"使用此地点", nil];
        [alertView show];
        return;
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"无法定位到您的地点，请手动选择或稍后再试" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *btnTitle = [alertView buttonTitleAtIndex:buttonIndex];
    if ([btnTitle isEqualToString:@"使用此地点"]) {
        self.useAutoLocate = NO;
        [self.delegate useLocationAuto];
    }else{
        
    }
}

#pragma mark - UIPickerDatasource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (0 == component) {
        return _provinces.count;
    }else if (1== component){
//        NSInteger selectedIndex = [pickerView selectedRowInComponent:0];
        
//        THProvince *province = [_provinces objectAtIndexCheck:selectedIndex];
        THProvince *province = [_provinces objectAtIndexCheck:self.selectRowOfCom0];
        
        return province.cities.count;
    }else{
//        NSInteger selectProvince = [pickerView selectedRowInComponent:0];
//        NSInteger selectCity     = [pickerView selectedRowInComponent:1];
        
        NSInteger selectProvince = self.selectRowOfCom0;
        NSInteger selectCity     = self.selectRowOfCom1;
        
        THProvince *province = [_provinces objectAtIndexCheck:selectProvince];
        if (selectCity > province.cities.count - 1) {
            return 0;
//            selectCity = 0;
        }
        THCity *city = [province.cities objectAtIndexCheck:selectCity];
        
//        THProvince *province = [_provinces objectAtIndexCheck:self.selectRowOfCom0];
//        
//        THCity *city = [province.cities objectAtIndexCheck:self.selectRowOfCom1];
        
        return city.areas.count;
        
    }
    return 0;
}

#pragma mark - UIPickerViewDelegate
#pragma mark 填充文字
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (0 == component) {
        
        THProvince *province = [_provinces objectAtIndexCheck:row];
        
        return province.name;
    }else if (1== component){
        
//        NSInteger selectedIndex = [pickerView selectedRowInComponent:0];
        
        NSInteger selectedIndex = self.selectRowOfCom0;
        THProvince *p = [_provinces objectAtIndexCheck:selectedIndex];
        if (row > p.cities.count - 1) {
            return nil;
        }
        THCity *city = [p.cities objectAtIndexCheck:row];
        
//        THProvince *province = [_provinces objectAtIndexCheck:self.selectRowOfCom0];
//        
//        THCity *city = [province.cities objectAtIndexCheck:row];
        
        return city.name;
    }else{
//        NSInteger selectProvince = [pickerView selectedRowInComponent:0];
//        NSInteger selectCity     = [pickerView selectedRowInComponent:1];
        NSInteger selectProvince = self.selectRowOfCom0;
        NSInteger selectCity     = self.selectRowOfCom1;
        
        THProvince *province = [_provinces objectAtIndexCheck:selectProvince];
        if (selectCity > province.cities.count - 1) {
            return nil;
        }
        THCity *city = [province.cities objectAtIndexCheck:selectCity];
        if (row > city.areas.count -1 ) {
            return nil;
        }
        
//        THProvince *province = [_provinces objectAtIndexCheck:self.selectRowOfCom0];
//        
//        THCity *city = [province.cities objectAtIndexCheck:self.selectRowOfCom1];
        
        return [city.areas objectAtIndex:row];
        
    }
    return nil;
}

#pragma mark pickerView被选中
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (0 == component) {
        self.selectRowOfCom0 = row;
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
        
    }
    else if (1 == component){
        self.selectRowOfCom1 = row;
//        NSInteger selectArea = [pickerView selectedRowInComponent:2];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel* pickerLabel = (UILabel*)view;
    
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
    }
    
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

-(void)handSwipe{
    [self cancelBtnClicked];
}

#pragma mark - AddressPickerViewDelegate
- (void)cancelBtnClicked{
    if ([_delegate respondsToSelector:@selector(closeAddressView)]) {
        [_delegate closeAddressView];
    }
}

- (void)sureBtnClicked{
    if ([self.delegate respondsToSelector:@selector(selectedProvince:City:Area:)]) {
        NSInteger selectProvince = [self.addressPickerView selectedRowInComponent:0];
        NSInteger selectCity     = [self.addressPickerView selectedRowInComponent:1];
        NSInteger selectArea     = [self.addressPickerView selectedRowInComponent:2];
        
        THProvince *province = [_provinces objectAtIndexCheck:selectProvince];
        if (selectCity > province.cities.count - 1) {
            selectCity = province.cities.count - 1;
        }
        THCity *city = [province.cities objectAtIndexCheck:selectCity];
        NSString *areaName;
        if (city.areas.count == 0) {
            areaName = nil;
        }else{
            if (selectArea > city.areas.count - 1) {
                selectArea = city.areas.count - 1;
            }
            areaName = [city.areas objectAtIndex:selectArea];
        }
        
        self.selectRowOfCom0 = selectProvince;
        self.selectRowOfCom1 = selectCity;
        self.selectRowOfCom2 = selectArea;
        
        [self handSwipe];
        [self.delegate selectedProvince:province.name City:city.name Area:areaName];
    }
}

#pragma UIGestureRecognizationDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isMemberOfClass:[UIView class]]) {
        return NO;
    }else
        return YES;
}



@end
