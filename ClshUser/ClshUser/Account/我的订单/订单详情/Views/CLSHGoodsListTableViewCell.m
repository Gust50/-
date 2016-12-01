//
//  CLSHGoodsListTableViewCell.m
//  ClshUser
//
//  Created by arom on 16/5/31.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHGoodsListTableViewCell.h"
#import "Masonry.h"
#import "CLSHAccountOrderModel.h"

@interface CLSHGoodsListTableViewCell()

@property (nonatomic,strong)UIImageView * Goodsicon;//商品图标
@property (nonatomic,strong)UILabel * nameLabel;//商品名称
@property (nonatomic,strong)UILabel * numLable;//数量
@property (nonatomic,strong)UILabel * priceLabel;//价格
@end

@implementation CLSHGoodsListTableViewCell

#pragma mark <lazyload>
- (UIImageView *)Goodsicon{

    if (!_Goodsicon) {
        _Goodsicon = [[UIImageView alloc] init];
//        _Goodsicon.layer.borderWidth = 1;
//        _Goodsicon.layer.borderColor = RGBColor(102, 102, 102).CGColor;
        _Goodsicon.image = [UIImage imageNamed:@"酒水饮料"];
    }
    return _Goodsicon;
    
}

-(UILabel *)nameLabel{

    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"冰镇黄瓜";
        _nameLabel.font = [UIFont systemFontOfSize:12*pro];
    }
    return _nameLabel;
}

- (UILabel *)numLable{

    if (!_numLable) {
        _numLable = [[UILabel alloc] init];
        _numLable.text = @"x4";
        _numLable.textColor = RGBColor(248, 31, 0);
        _numLable.font = [UIFont systemFontOfSize:12*pro];
    }
    return _numLable;
}

- (UILabel *)priceLabel{

    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.text = @"￥168.00";
        _priceLabel.font = [UIFont systemFontOfSize:12*pro];
        _priceLabel.textAlignment = NSTextAlignmentRight;
    }
    return _priceLabel;
}

#pragma mark init
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{

    [self addSubview:self.Goodsicon];
    [self addSubview:self.nameLabel];
    [self addSubview:self.numLable];
    [self addSubview:self.priceLabel];
    
    [self updateConstraints];
}

- (void)updateConstraints{

    [super updateConstraints];
    WS(weakSelf);
    
    [_Goodsicon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(50*pro, 50*pro));
        
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.Goodsicon.mas_right).with.offset(10*pro);
        make.top.equalTo(weakSelf.mas_top).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.height.equalTo(@(20*pro));
    }];
    [_numLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_Goodsicon.mas_right).with.offset(10*pro);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-10*pro);
        make.width.equalTo(@(60*pro));
        make.height.equalTo(@(20*pro));
    }];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-10*pro);
         make.left.equalTo(_numLable.mas_right).with.offset(10*pro);
        make.height.equalTo(@(20*pro));
    }];
}


- (void)setModel:(CLSHAccountOrderDetailOneModel *)model{

    _model = model;
    [self.Goodsicon sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:nil];
    self.nameLabel.text = model.goodsName;
    self.numLable.text = [NSString stringWithFormat:@"X %ld",model.quantity];
    NSString *priceStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:model.price]];
    self.priceLabel.text = priceStr;
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
