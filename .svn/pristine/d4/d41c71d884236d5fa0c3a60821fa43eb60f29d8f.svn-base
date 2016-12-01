//
//  CLGSHomeNavigationView.m
//  粗粮
//
//  Created by kobe on 16/5/17.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import "CLGSHomeNavigationView.h"
#import "Masonry.h"
#import "CLGSDotView.h"
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
@interface CLGSHomeNavigationView()<UITextFieldDelegate>

@end

@implementation CLGSHomeNavigationView


#pragma mark <lazyLoad>
-(UIButton *)areaButton{
    if (!_areaButton) {
        _areaButton=[[UIButton alloc]init];
        _areaButton.backgroundColor = RGBAColor(0, 0, 0, 0.6);
        _areaButton.layer.cornerRadius = 3.0f;
        _areaButton.layer.masksToBounds = YES;
        [_areaButton setImage:[UIImage imageNamed:@"Location"] forState:UIControlStateNormal];
        _areaButton.titleLabel.font = [UIFont systemFontOfSize:12*pro];
        [_areaButton setTitle:@"" forState:UIControlStateNormal];
        [_areaButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_areaButton addTarget:self action:@selector(areaButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _areaButton;
}

-(UIButton *)searchButton{
    if (!_searchButton) {
        _searchButton=[[UIButton alloc]init];
        [_searchButton setImage:[UIImage imageNamed:@"Magnifier"] forState:UIControlStateNormal];
        [_searchButton addTarget:self action:@selector(iconTapGesture:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchButton;
}

-(UITextField *)searchField{
    if (!_searchField) {
        _searchField=[[UITextField alloc]init];
        _searchField.borderStyle = UITextBorderStyleRoundedRect;
        _searchField.textAlignment = NSTextAlignmentCenter;
        _searchField.textColor = [UIColor whiteColor];
        _searchField.backgroundColor = RGBAColor(0, 0, 0, 0.6);
        _searchField.font = [UIFont systemFontOfSize:11*pro];
        _searchField.text = @"您需要找哪里的特产？";
        _searchField.delegate = self;
    }
    return _searchField;
}

-(CLGSDotView *)dot
{
    if (!_dot) {
        _dot = [[CLGSDotView alloc] init];
        [_dot.button setImage:[UIImage imageNamed:@"ShopDetailShoppingCart"] forState:UIControlStateNormal];
        [_dot.button addTarget:self action:@selector(iconTapGesture:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dot;
}

-(UIImageView *)icon{
    if (!_icon) {
        _icon=[[UIImageView alloc]init];
        _icon.backgroundColor = RGBAColor(0, 0, 0, 0.6);
        _icon.layer.cornerRadius = 12.0f;
        _icon.layer.masksToBounds = YES;
        _icon.image = [UIImage imageNamed:@"IconLogo"];
        _icon.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(iconTapGesture:)];
        [_icon addGestureRecognizer:tap];
    }
    return _icon;
}


#pragma mark <init>
-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}


#pragma mark <add UI>
-(void)initUI{
    [self addSubview:self.areaButton];
    [self addSubview:self.searchField];
    [self.searchField addSubview:self.searchButton];
    [self addSubview:self.dot];
    [self updateConstraints];
}

#pragma mark <otherResponse>
-(void)areaButtonClick:(UIButton *)button{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectArea:)]) {
        [self.delegate selectArea:self];
    }
}

-(void)iconTapGesture:(UIGestureRecognizer *)gesture{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickIcon:)]) {
        
        [self.delegate clickIcon:self];
    }
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectCity:)]) {
        [self.delegate selectCity:self];
    }
}

#pragma mark <update>
-(void)updateConstraints{
    [super updateConstraints];
    
    WS(weakSelf);
    [_areaButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.size.mas_equalTo(CGSizeMake(55*pro, 30*pro));
    }];
    
    [_searchField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX).offset(10*pro);
        make.top.equalTo(weakSelf.mas_top);
        make.size.mas_equalTo(CGSizeMake(160*pro, 30*pro));
    }];
    
    [_searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_searchField.mas_left).with.offset(10*pro);
        make.centerY.equalTo(_searchField.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(10*pro, 10*pro));
    }];
    
    [_dot mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.top.equalTo(weakSelf.mas_top).offset(-4*pro);
        make.size.mas_equalTo(CGSizeMake(40*pro, 40*pro));
    }];
}

@end
