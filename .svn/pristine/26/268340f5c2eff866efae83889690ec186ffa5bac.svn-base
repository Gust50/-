//
//  CLSHProductPriceScreenVC.m
//  ClshUser
//
//  Created by wutaobo on 16/7/11.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHProductPriceScreenVC.h"
#import "UINavigationBar+Awesome.h"
#import "Masonry.h"
#import "CLSHGoodsListViewController.h"

@interface CLSHProductPriceScreenVC ()

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UITextField *minPrice;    ///<最低价格
@property (nonatomic, strong) UITextField *maxPrice;    ///<最高价格
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *middle;
@end

@implementation CLSHProductPriceScreenVC

#pragma mark - lazyLoad
-(UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.text = @"价格区间";
        _priceLabel.font = [UIFont systemFontOfSize:13*pro];
    }
    return _priceLabel;
}

- (UILabel *)middle
{
    if (!_middle) {
        _middle = [[UILabel alloc] init];
        _middle.backgroundColor = backGroundColor;
    }
    return _middle;
}

-(UITextField *)minPrice
{
    if (!_minPrice) {
        _minPrice = [[UITextField alloc] init];
        _minPrice.font = [UIFont systemFontOfSize:13*pro];
        _minPrice.layer.borderColor = backGroundColor.CGColor;
        _minPrice.layer.borderWidth = 1.0;
        _minPrice.layer.cornerRadius = 5.0;
        _minPrice.layer.masksToBounds = YES;
        _minPrice.textAlignment = NSTextAlignmentCenter;
        _minPrice.placeholder = @"起始价格";
    }
    return _minPrice;
}

-(UITextField *)maxPrice
{
    if (!_maxPrice) {
        _maxPrice = [[UITextField alloc] init];
        _maxPrice.font = [UIFont systemFontOfSize:13*pro];
        _maxPrice.layer.borderColor = backGroundColor.CGColor;
        _maxPrice.layer.borderWidth = 1.0;
        _maxPrice.layer.cornerRadius = 5.0;
        _maxPrice.layer.masksToBounds = YES;
        _maxPrice.textAlignment = NSTextAlignmentCenter;
        _maxPrice.placeholder = @"终止价格";
    }
    return _maxPrice;
}

-(UIView *)backView
{
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 64+10*pro, SCREENWIDTH, 50*pro)];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
    [self nav];
    
    self.view.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"筛选"];
    
    [self initUI];
}

- (void)initUI
{
    [self.backView addSubview:self.maxPrice];
    [self.backView addSubview:self.minPrice];
    [self.backView addSubview:self.middle];
    [self.backView addSubview:self.priceLabel];
    [self.view addSubview:self.backView];
    [self updateViewConstraints];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
    
}

#pragma mark - nav
- (void)nav
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem normalTitle:@"确定" selectTitle:@"确定" normalColor:[UIColor whiteColor] selectColor:[UIColor whiteColor] normalImage:nil selectImage:nil target:self action:@selector(screenFinish) size:CGSizeMake(40, 44) titleFont:[UIFont systemFontOfSize:14*pro]];
}
//确定
- (void)screenFinish
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.minPrice.text.length != 0 && self.maxPrice.text.length != 0) {
        if ([self.minPrice.text intValue] > [self.maxPrice.text intValue]) {
            [MBProgressHUD showError:@"起始价格不能高于终止价格"];
            return;
        }
    }
   
    params[@"startPrice"] = self.minPrice.text;
    params[@"endPrice"] = self.maxPrice.text;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"priceScreen" object:nil userInfo:params];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)updateViewConstraints{
    [super updateViewConstraints];
    
    WS(weakSelf);
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.backView.mas_centerY);
        make.left.equalTo(weakSelf.view.mas_left).with.offset(10*pro);
        make.size.mas_equalTo(CGSizeMake(60*pro, 20*pro));
    }];
    
    [_minPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.backView.mas_centerY);
        make.left.equalTo(_priceLabel.mas_right).with.offset(15*pro);
        make.size.mas_equalTo(CGSizeMake(80*pro, 30*pro));
    }];
    
    [_middle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.backView.mas_centerY);
        make.left.equalTo(_minPrice.mas_right).with.offset(5*pro);
        make.size.mas_equalTo(CGSizeMake(20*pro, 1));
    }];
    
    [_maxPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.backView.mas_centerY);
        make.left.equalTo(_middle.mas_right).with.offset(5*pro);
        make.size.mas_equalTo(CGSizeMake(80*pro, 30*pro));
    }];
    
}
@end
