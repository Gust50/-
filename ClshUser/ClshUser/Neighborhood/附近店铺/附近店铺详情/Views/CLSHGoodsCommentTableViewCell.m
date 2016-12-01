//
//  CLSHGoodsCommentTableViewCell.m
//  ClshUser
//
//  Created by arom on 16/6/2.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHGoodsCommentTableViewCell.h"
#import "CLGSStarRate.h"
#import "Masonry.h"
#import "CLSHNeighborhoodModel.h"

@interface CLSHGoodsCommentTableViewCell (){

    CLGSStarRate * StarRate;
}

@end
@implementation CLSHGoodsCommentTableViewCell


#pragma mark <lazyload>
- (UILabel *)GoodsCommentsLabel{

    if (!_GoodsCommentsLabel) {
        _GoodsCommentsLabel = [[UILabel alloc] init];
        
        _GoodsCommentsLabel.font = [UIFont systemFontOfSize:13*pro];
        _GoodsCommentsLabel.text = @"商品评价";
    }
    return _GoodsCommentsLabel;
}

- (UILabel *)NumOfCommetnLable{

    if (!_NumOfCommetnLable) {
        _NumOfCommetnLable = [[UILabel alloc] init];
        _NumOfCommetnLable.font = [UIFont systemFontOfSize:12*pro];
        _NumOfCommetnLable.textColor = RGBColor(102, 102, 102);
        
        _NumOfCommetnLable.text = @"共有168个评价";
    }
    return _NumOfCommetnLable;
}

- (UILabel *)goodCommentLabel{

    if (!_goodCommentLabel) {
        _goodCommentLabel = [[UILabel alloc] init];
        
        _goodCommentLabel.font = [UIFont systemFontOfSize:13*pro];
        _goodCommentLabel.text = @"好 评 率";
    }
    return _goodCommentLabel;
}

- (UIView *)starRateView{

    if (!_starRateView) {
        _starRateView = [[UIView alloc] init];
        _starRateView.userInteractionEnabled = NO;
    }
    return _starRateView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{

    [self addSubview:self.GoodsCommentsLabel];
    [self addSubview:self.NumOfCommetnLable];
    [self addSubview:self.goodCommentLabel];
    [self addSubview:self.starRateView];
    
    
    [self updateConstraints];
}

- (void)updateConstraints{

    [super updateConstraints];
    WS(weakSelf);
    
    [_GoodsCommentsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(10*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.height.equalTo(@(20*pro));
        make.width.equalTo(@(70*pro));
    }];
    
    [_NumOfCommetnLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_GoodsCommentsLabel.mas_right);
        make.bottom.equalTo(_GoodsCommentsLabel.mas_bottom);
        make.height.equalTo(@(20*pro));
        make.width.equalTo(@(150*pro));
    }];
    
    [_goodCommentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_GoodsCommentsLabel.mas_bottom).with.offset(10*pro);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-10*pro);
        make.width.equalTo(@(70*pro));
    }];
    [_starRateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_NumOfCommetnLable.mas_bottom).with.offset(10*pro);
        //make.bottom.equalTo(_goodCommentLabel.mas_bottom);
        make.centerY.equalTo(_goodCommentLabel.mas_centerY);
        make.left.equalTo(_goodCommentLabel.mas_right);
        make.width.equalTo(@(150*pro));
    }];
}

- (void)setModel:(CLSHNeighborhoodMerchantProductDetailGoodsModel *)model{

    _model = model;
    self.NumOfCommetnLable.text = [NSString stringWithFormat:@"共有%@人评价",model.scoreCount];
    StarRate = [[CLGSStarRate alloc] initWithFrame:CGRectMake(0, -6*pro, 60, 40) numberOfStars:5];
    StarRate.scorePercent = [model.scoreRate floatValue]/5;
    [self.starRateView addSubview:StarRate];
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
