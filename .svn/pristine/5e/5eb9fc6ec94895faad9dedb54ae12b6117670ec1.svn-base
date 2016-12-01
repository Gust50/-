//
//  CLSHBusinessAddressCell.m
//  ClshUser
//
//  Created by arom on 16/7/2.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHBusinessAddressCell.h"
#import "Masonry.h"
#import "CLSHAccountOrderModel.h"

@implementation CLSHBusinessAddressCell

- (UIImageView *)businessIcon{

    if (!_businessIcon) {
        _businessIcon = [[UIImageView alloc] init];
        _businessIcon.image = [UIImage imageNamed:@"专卖店"];
    }
    return _businessIcon;
}

- (UILabel *)businessLabel{

    if (!_businessLabel) {
        _businessLabel = [[UILabel alloc] init];
        _businessLabel.text = @"店铺信息";
        _businessLabel.font = [UIFont systemFontOfSize:13*pro];
    }
    return _businessLabel;
}

- (UIView *)oneView{

    if (!_oneView) {
        _oneView = [[UIView alloc] init];
        _oneView.backgroundColor = backGroundColor;
    }
    return _oneView;
}

- (UILabel *)businessName{

    if (!_businessName) {
        _businessName = [[UILabel alloc] init];
        _businessName.font = [UIFont systemFontOfSize:12*pro];
    }
    return _businessName;
}

-(UIView *)twoView{

    if (!_twoView) {
        _twoView = [[UIView alloc] init];
        _twoView.backgroundColor = backGroundColor;
        
    }
    return _twoView;
}

- (UILabel *)telephone{

    if (!_telephone) {
        _telephone = [[UILabel alloc] init];
        _telephone.text = @"联系电话：";
        _telephone.font = [UIFont systemFontOfSize:12*pro];
    }
    return _telephone;
}

- (UILabel *)phone{

    if (!_phone) {
        _phone = [[UILabel alloc] init];
        _phone.font = [UIFont systemFontOfSize:12*pro];
        _phone.textAlignment = NSTextAlignmentLeft;
    }
    return _phone;
}

- (UIButton *)callButton{
    
    if (!_callButton) {
        _callButton = [[UIButton alloc] init];
        [_callButton setImage:[UIImage imageNamed:@"phoneIcon"] forState:(UIControlStateNormal)];
        [_callButton addTarget:self action:@selector(callToBussiness) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _callButton;
}

-(UIView *)threeView{

    if (!_threeView) {
        _threeView = [[UIView alloc] init];
        _threeView.backgroundColor = backGroundColor;
    }
    return _threeView;
}

- (UILabel *)address{

    if(!_address){
    
        _address = [[UILabel alloc] init];
        _address.font = [UIFont systemFontOfSize:12*pro];
    }
    return _address;
}

- (UIButton *)locationButton{

    if (!_locationButton) {
        _locationButton = [[UIButton alloc] init];
        [_locationButton setImage:[UIImage imageNamed:@"location1"] forState:(UIControlStateNormal)];
        [_locationButton addTarget:self action:@selector(locationNav) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _locationButton;
}

- (UIView *)fourView{

    if (!_fourView) {
        _fourView = [[UIView alloc] init];
        _fourView.backgroundColor = backGroundColor;
    }
    return _fourView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{

    [self addSubview:self.businessIcon];
    [self addSubview:self.businessLabel];
    [self addSubview:self.oneView];
    [self addSubview:self.businessName];
    [self addSubview:self.twoView];
    [self addSubview:self.telephone];
    [self addSubview:self.phone];
    [self addSubview:self.callButton];
    [self addSubview:self.threeView];
    [self addSubview:self.address];
    [self addSubview:self.locationButton];
    [self addSubview:self.fourView];
    
    [self updateConstraints];
    
}


- (void)updateConstraints{

    [super updateConstraints];
    
    WS(weakSelf);
    [_businessIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.top.equalTo(weakSelf.mas_top).with.offset(12*pro);
        make.height.equalTo(@(19*pro));
        make.width.equalTo(@(15*pro));
    }];
    
    [_businessLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_businessIcon.mas_right).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-8*pro);
       make.top.equalTo(weakSelf.mas_top).with.offset(12*pro);
        make.height.equalTo(@(20*pro));
    }];
    
    [_oneView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.mas_right).with.offset(0);
        make.height.equalTo(@(1));
        make.top.equalTo(_businessIcon.mas_bottom).with.offset(12*pro);
        
    }];
    
    [_businessName mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.mas_left).with.offset(35*pro);
        make.top.equalTo(_oneView.mas_bottom).with.offset(12*pro);
        make.height.equalTo(@(20*pro));
        make.width.equalTo(@(SCREENWIDTH));
    }];
    
    [_twoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(15);
        make.right.equalTo(weakSelf.mas_right).with.offset(0);
        make.height.equalTo(@(1));
        make.top.equalTo(_businessName.mas_bottom).with.offset(12*pro);
    }];
    
    [_telephone mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.mas_left).with.offset(35*pro);
        make.top.equalTo(_twoView.mas_bottom).with.offset(12*pro);
        make.height.equalTo(@(20*pro));
        make.width.equalTo(@(60*pro));
    }];
    
    [_phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_telephone.mas_right).with.offset(0);
        make.top.equalTo(_twoView.mas_bottom).with.offset(12*pro);
        make.width.equalTo(@(150*pro));
        make.height.equalTo(@(20*pro));
    }];
    
    [_callButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_twoView.mas_bottom).with.offset(12*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-8*pro);
        make.width.equalTo(@(40*pro));
        make.height.equalTo(@(30*pro));
    }];
    
    [_threeView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.mas_left).with.offset(15);
        make.right.equalTo(weakSelf.mas_right).with.offset(0);
        make.height.equalTo(@(1));
        make.top.equalTo(_telephone.mas_bottom).with.offset(12*pro);
     }];
    
    [_address mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.mas_left).with.offset(35*pro);
        make.top.equalTo(_threeView.mas_bottom).with.offset(12*pro);
        make.height.equalTo(@(20*pro));
        make.width.equalTo(@(200*pro));
    }];
    
    [_locationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_threeView.mas_bottom).with.offset(12*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-8*pro);
        make.width.equalTo(@(40*pro));
        make.height.equalTo(@(30*pro));
    }];
    
    [_fourView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.mas_left).with.offset(15);
        make.right.equalTo(weakSelf.mas_right).with.offset(0);
        make.height.equalTo(@(1));
        make.top.equalTo(_address.mas_bottom).with.offset(12*pro);

    }];
    
}

/**
 @property (nonatomic,strong)UIImageView * businessIcon;
 @property (nonatomic,strong)UILabel * businessLabel;
 @property (nonatomic,strong)UIView * oneView;
 @property (nonatomic,strong)UILabel * businessName;
 @property (nonatomic,strong)UIView * twoView;
 @property (nonatomic,strong)UILabel * telephone;
 @property (nonatomic,strong)UILabel * phone;
 @property (nonatomic,strong)UIButton * callButtion;
 @property (nonatomic,strong)UIView * threeView;
 @property (nonatomic,strong)UILabel * address;
 @property (nonatomic,strong)UIButton * locationButton;
 @property (nonatomic,strong)UIView * fourView;
 */

- (void)setModel:(CLSHOrderShopModel *)model{

    _model = model;
    if (model.name == nil) {
        self.businessName.text = @"暂无店铺信息";
    }else
    {
        self.businessName.text = [NSString stringWithFormat:@"店铺名称：%@",model.name];
    }
    if (model.phoneNumber == nil) {
        self.phone.text = @"暂无联系电话";
    }else
    {
        self.phone.text = model.phoneNumber;
    }
    if (model.address == nil) {
        self.address.text = @"暂无地址";
    }else
    {
        self.address.text = [NSString stringWithFormat:@"地址：%@",model.address];
    }
    
}

//电话
- (void)callToBussiness{

    if (self.CallToBussinessblock) {
        self.CallToBussinessblock();
    }
}

//导航

- (void)locationNav{

    if (self.LocationNacblock) {
        self.LocationNacblock();
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
