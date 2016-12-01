//
//  CLSHCitySubDivitionCell.m
//  ClshUser
//
//  Created by wutaobo on 16/6/6.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHCitySubDivitionCell.h"
#import "Masonry.h"
#import "CLSHHomeCityModel.h"

@interface CLSHCitySubDivitionCell()
@property (nonatomic, strong)UILabel *cityName;

@end

@implementation CLSHCitySubDivitionCell

#pragma makr <lazyLoad>
-(UILabel *)cityName{
    if (!_cityName) {
        _cityName=[[UILabel alloc]init];
        _cityName.backgroundColor = systemColor;
        _cityName.textColor = [UIColor whiteColor];
        _cityName.layer.cornerRadius = 15.0;
        _cityName.layer.masksToBounds = YES;
        _cityName.font = [UIFont systemFontOfSize:11*pro];
        _cityName.textAlignment = NSTextAlignmentCenter;
    }
    return _cityName;
}

#pragma mark <init>
-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.cityName];
    [self updateConstraints];
}

-(void)updateConstraints{
    [super updateConstraints];
    
    WS(weakSelf);
    
    [_cityName mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.mas_top);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
}

#pragma mark - setter getter
-(void)setCityListModel:(CLSHHomeSearchCityListModel *)cityListModel
{
    _cityListModel = cityListModel;
    _cityName.text = cityListModel.name;
}

@end
