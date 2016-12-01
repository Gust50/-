//
//  CLSHShopDetailShopRecommendCell.m
//  ClshUser
//
//  Created by wutaobo on 16/6/3.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHShopDetailShopRecommendCell.h"
#import "Masonry.h"
#import "CLSHCartModel.h"

@interface CLSHShopDetailShopRecommendCell()
@property (nonatomic, strong) UIImageView *shopIcon;
@property (nonatomic, strong) UILabel *shopDescribe;
@property (nonatomic, strong) UILabel *shopPrice;
@property (nonatomic, strong) UILabel *purchasePersonCount;
@end

@implementation CLSHShopDetailShopRecommendCell

#pragma mark-getter setter
-(UIImageView *)shopIcon{
    if (!_shopIcon) {
        _shopIcon=[[UIImageView alloc]init];
        _shopIcon.image = [UIImage imageNamed:@"ProductPicture"];
    }
    return _shopIcon;
}

-(UILabel *)shopDescribe{
    if (!_shopDescribe) {
        _shopDescribe=[[UILabel alloc]init];
        _shopDescribe.textColor = RGBColor(51, 51, 51);
        _shopDescribe.font = [UIFont systemFontOfSize:12*pro];
        _shopDescribe.text = @"果园现摘";
        _shopDescribe.numberOfLines = 0;
    }
    return _shopDescribe;
}

-(UILabel *)shopPrice{
    if (!_shopPrice) {
        _shopPrice=[[UILabel alloc]init];
        _shopPrice.textColor = [UIColor redColor];
        _shopPrice.font = [UIFont systemFontOfSize:12*pro];
        _shopPrice.text = @"48.00";
        
    }
    return _shopPrice;
}

-(UILabel *)purchasePersonCount{
    if (!_purchasePersonCount) {
        _purchasePersonCount=[[UILabel alloc]init];
        _purchasePersonCount.textColor = [UIColor lightGrayColor];
        _purchasePersonCount.font = [UIFont systemFontOfSize:12*pro];
        _purchasePersonCount.text = @"508人已买";
        _purchasePersonCount.textAlignment = NSTextAlignmentRight;
    }
    return _purchasePersonCount;
}


#pragma mark-init UI
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    [self addSubview:self.shopIcon];
    [self addSubview:self.shopDescribe];
    [self addSubview:self.shopPrice];
    [self addSubview:self.purchasePersonCount];
    [self updateConstraints];
}

#pragma mark-updateUI
-(void)updateConstraints{
    [super updateConstraints];
    
    WS(weakSelf);
    [_shopIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.height.mas_equalTo(@(160*pro));
    }];
    [_shopDescribe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_shopIcon.mas_bottom).with.offset(10*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(5*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-5*pro);
        make.height.mas_equalTo(@(40*pro));
    }];
    [_shopPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_shopDescribe.mas_bottom).with.offset(10*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(5*pro);
        make.size.mas_equalTo(CGSizeMake(80*pro, 20*pro));
    }];
    [_purchasePersonCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_shopDescribe.mas_bottom).with.offset(10*pro);
        make.left.equalTo(_shopPrice.mas_right).with.offset(5*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-5*pro);
        make.height.mas_equalTo(@(20*pro));
    }];
}

#pragma mark - setter getter
-(void)setCommendListModel:(CLSHCartCommendListModel *)commendListModel
{
    _commendListModel = commendListModel;
    [_shopIcon sd_setImageWithURL:[NSURL URLWithString:commendListModel.image] placeholderImage:nil];
    _shopDescribe.text = commendListModel.name;
    NSString *str = [NSString stringWithFormat:@"%.f", commendListModel.price];
    NSString *shopPriceStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:commendListModel.price]];
    _shopPrice.text = shopPriceStr;
    [NSString labelString:_shopPrice font:[UIFont systemFontOfSize:16*pro] range:NSMakeRange(1, str.length) color:[UIColor redColor]];
    _purchasePersonCount.text = [NSString stringWithFormat:@"%.f人已买", commendListModel.sales];
}

@end
