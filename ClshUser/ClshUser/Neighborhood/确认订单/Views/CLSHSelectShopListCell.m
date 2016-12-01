//
//  CLSHSelectShopListCell.m
//  ClshUser
//
//  Created by wutaobo on 16/6/1.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHSelectShopListCell.h"
#import "Masonry.h"
#import "CLSHNeighborhoodMerChantOrderModel.h"

@interface CLSHSelectShopListCell ()
@property (nonatomic, strong) UIImageView *shopIcon;
@property (nonatomic, strong) UILabel *shopDescribe;
@property (nonatomic, strong) UILabel *shopPrice;
@property (nonatomic, strong) UILabel *quantityLabel;

@end

@implementation CLSHSelectShopListCell

#pragma mark-getter setter
-(UIImageView *)shopIcon{
    if (!_shopIcon) {
        _shopIcon=[[UIImageView alloc]init];
        _shopIcon.image = [UIImage imageNamed:@"ShopIcon"];
    }
    return _shopIcon;
}

-(UILabel *)shopDescribe{
    if (!_shopDescribe) {
        _shopDescribe=[[UILabel alloc]init];
        _shopDescribe.textColor = RGBColor(51, 51, 51);
        _shopDescribe.font = [UIFont systemFontOfSize:13*pro];
        _shopDescribe.numberOfLines = 0;
        _shopDescribe.text = @"云南过桥米线，正宗的云南美食 特产";
    }
    return _shopDescribe;
}

-(UILabel *)shopPrice{
    if (!_shopPrice) {
        _shopPrice=[[UILabel alloc]init];
        _shopPrice.textColor = RGBColor(242, 51, 47);
        _shopPrice.font = [UIFont systemFontOfSize:14*pro];
        _shopPrice.text = @"￥20/份";
    }
    return _shopPrice;
}

- (UILabel *)quantityLabel{

    if (!_quantityLabel ) {
        _quantityLabel = [[UILabel alloc] init];
        _quantityLabel.textColor = RGBColor(102 , 102, 102);
        _quantityLabel.font = [UIFont systemFontOfSize:14*pro];
    }
    return _quantityLabel;
}

#pragma mark-init UI
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    [self addSubview:self.shopIcon];
    [self addSubview:self.shopDescribe];
    [self addSubview:self.shopPrice];
    [self addSubview:self.quantityLabel];
    [self updateConstraints];
}

#pragma mark-updateUI
-(void)updateConstraints{
    [super updateConstraints];
    
    WS(weakSelf);
    [_shopIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(10*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.size.mas_equalTo(CGSizeMake(80*pro, 80*pro));
    }];
    
    [_shopDescribe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(10*pro);
        make.left.equalTo(_shopIcon.mas_right).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.height.mas_equalTo(@(40*pro));
    }];
    [_shopPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-10*pro);
        make.left.equalTo(_shopIcon.mas_right).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.height.mas_equalTo(@(20*pro));
    }];
    
    [_quantityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_shopPrice.mas_centerY);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        
    }];
}

#pragma mark - setter getter
-(void)setMerChantCreateOrderListModel:(CLSHNeighborhoodMerChantCreateOrderListModel *)merChantCreateOrderListModel
{
    _merChantCreateOrderListModel = merChantCreateOrderListModel;
    [_shopIcon sd_setImageWithURL:[NSURL URLWithString:merChantCreateOrderListModel.image] placeholderImage:nil];
    _shopDescribe.text = merChantCreateOrderListModel.productName;
    NSString *shopPriceStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:merChantCreateOrderListModel.price]];
    _shopPrice.text = [NSString stringWithFormat:@"%@/份", shopPriceStr];
    [NSString labelString:_shopPrice font:[UIFont systemFontOfSize:10*pro] range:NSMakeRange(_shopPrice.text.length-2, 2) color:RGBColor(153, 153, 153)];
    _quantityLabel.text = [NSString stringWithFormat:@"x%zi",merChantCreateOrderListModel.quantity];
}

@end
