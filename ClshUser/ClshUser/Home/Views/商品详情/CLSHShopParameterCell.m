//
//  CLSHShopParameterCell.m
//  ClshUser
//
//  Created by wutaobo on 16/6/3.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHShopParameterCell.h"
#import "Masonry.h"
#import "CLSHHomeProductDetailModel.h"

@interface CLSHShopParameterCell ()
@property (nonatomic, strong) UILabel *describe;
@property (nonatomic, strong) UILabel *shopParameter;

@end

@implementation CLSHShopParameterCell

-(UILabel *)describe{
    
    if (!_describe) {
        _describe=[[UILabel alloc]init];
        _describe.font=[UIFont systemFontOfSize:13*pro];
        _describe.textColor = RGBColor(121, 121, 121);
        _describe.text=@"净含量";
    }
    return _describe;
}

-(UILabel *)shopParameter{
    
    if (!_shopParameter) {
        _shopParameter=[[UILabel alloc]init];
        _shopParameter.font=[UIFont systemFontOfSize:13*pro];
        _describe.textColor = RGBColor(51, 51, 51);
        _shopParameter.text=@"5000g";
    }
    return _shopParameter;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor=[UIColor whiteColor];
        [self initUI];
    }
    return self;
}

-(void)initUI{
    
    [self addSubview:self.describe];
    [self addSubview:self.shopParameter];
    [self updateConstraints];
    
}

-(void)updateConstraints{
    
    [super updateConstraints];
    WS(weakSelf);
    
    [_describe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).with.offset(15*pro);
        make.size.mas_equalTo(CGSizeMake(100*pro, 20*pro));
    }];
    
    [_shopParameter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(_describe.mas_right).with.offset(15*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.height.mas_equalTo(@(20*pro));
    }];
    
    
}
#pragma mark - setter getter
-(void)setParameterValuesListModel:(CLSHHomeProductParameterValuesListModel *)parameterValuesListModel
{
    _parameterValuesListModel = parameterValuesListModel;
    _describe.text = parameterValuesListModel.name;
    _shopParameter.text = parameterValuesListModel.value;
}


@end
