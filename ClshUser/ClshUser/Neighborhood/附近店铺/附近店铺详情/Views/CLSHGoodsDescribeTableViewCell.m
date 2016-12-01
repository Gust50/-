//
//  CLSHGoodsDescribeTableViewCell.m
//  ClshUser
//
//  Created by arom on 16/6/2.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHGoodsDescribeTableViewCell.h"
#import "Masonry.h"
#import "CLSHNeighborhoodModel.h"

@interface CLSHGoodsDescribeTableViewCell (){

    CGFloat height;
}

@end

@implementation CLSHGoodsDescribeTableViewCell

#pragma mark <lazyload>
- (UILabel *)GoodsDes{

    if (!_GoodsDes) {
        _GoodsDes = [[UILabel alloc] init];
        _GoodsDes.textColor = [UIColor blackColor];
        _GoodsDes.font = [UIFont systemFontOfSize:13*pro];
        _GoodsDes.text = @"商品描述";
    }
    return _GoodsDes;
}

- (UILabel *)Describe{

    if (!_Describe) {
        _Describe = [[UILabel alloc] init];
//        [_Describe sizeToFit];
        [_Describe setContentMode:UIViewContentModeTop];
        _Describe.textColor = RGBColor(102, 102, 102);
        _Describe.font = [UIFont systemFontOfSize:11*pro];
        _Describe.numberOfLines = 0;
        _Describe.lineBreakMode = NSLineBreakByWordWrapping;
        _Describe.text = @"牛头梗(Bull Terrier)这一品种有两个品系——白色牛头梗和有色牛头梗。该品种的起源可追溯到1835年。大家一致相信该品种是由现已绝种的英国白梗繁育产生的。几年后，为达到其外观上的标准，该犬与西班牙指示犬进行杂交，至今仍可在该犬的身上偶尔发现指示犬的遗传特征。";
    }
    return _Describe;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{

    [self addSubview:self.GoodsDes];
    [self addSubview:self.Describe];

    [_Describe setContentMode:UIViewContentModeTopLeft];
    [self updateConstraints];
}

- (void)updateConstraints{

    [super updateConstraints];
    WS(weakSelf);
    
    [_GoodsDes mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.top.equalTo(weakSelf.mas_top).with.offset(10*pro);
        make.height.equalTo(@(20*pro));
        make.width.equalTo(@(80*pro));
    }];
    
    [_Describe mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.top.equalTo(_GoodsDes.mas_bottom).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
    }];
    [_Describe mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(height));
    }];
}

- (void)setModel:(CLSHNeighborhoodMerchantProductDetailGoodsModel *)model{

    _model = model;
    self.Describe.text = model.caption;
    CGSize strSize = [NSString sizeWithStr:self.Describe.text font:[UIFont systemFontOfSize:11*pro] width:SCREENWIDTH-20];
    height = strSize.height;
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
