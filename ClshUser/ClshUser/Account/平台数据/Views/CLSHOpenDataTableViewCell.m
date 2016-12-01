//
//  CLSHOpenDataTableViewCell.m
//  ClshUser
//
//  Created by arom on 16/11/21.
//  Copyright © 2016年 50. All rights reserved.
//

#import "CLSHOpenDataTableViewCell.h"
#import "CLSHOpenDataModel.h"

@implementation CLSHOpenDataTableViewCell
#pragma mark <lazyload>
- (UIView *)backView{

    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = 10;
    }
    return _backView;
}
- (UILabel *)userAddNumLabel{

    if (!_userAddNumLabel) {
        _userAddNumLabel = [[UILabel alloc] init];
        _userAddNumLabel.textColor = RGBColor(102, 102, 102);
        _userAddNumLabel.font = [UIFont systemFontOfSize:12*pro];
    }
    return _userAddNumLabel;
}

- (UILabel *)userSumLabel{

    if (!_userSumLabel) {
        _userSumLabel = [[UILabel alloc] init];
        _userSumLabel.textColor = RGBColor(102, 102, 102);
        _userSumLabel.font = [UIFont systemFontOfSize:12*pro];
        _userSumLabel.textAlignment = NSTextAlignmentRight;
    }
    return _userSumLabel;
}

- (UIView *)line1View{

    if (!_line1View) {
        _line1View = [[UIView alloc] init];
        _line1View.backgroundColor = RGBColor(220, 220, 220);
    }
    return _line1View;
}

- (UILabel *)joinMerNumLabel{

    if (!_joinMerNumLabel) {
        _joinMerNumLabel = [[UILabel alloc] init];
        _joinMerNumLabel.textColor = RGBColor(102, 102, 102);
        _joinMerNumLabel.font = [UIFont systemFontOfSize:12*pro];
    }
    return _joinMerNumLabel;
}

- (UILabel *)joinFacNumLabel{

    if (!_joinFacNumLabel) {
        _joinFacNumLabel = [[UILabel alloc] init];
        _joinFacNumLabel.textColor = RGBColor(102, 102, 102);
        _joinFacNumLabel.font = [UIFont systemFontOfSize:12*pro];
        _joinFacNumLabel.textAlignment = NSTextAlignmentRight;
    }
    return _joinFacNumLabel;
}
- (UIView *)line2View{

    if (!_line2View) {
        _line2View = [[UIView alloc] init];
        _line2View.backgroundColor = RGBColor(220, 220, 220);
    }
    return _line2View;
}

-(UILabel *)transLateSumDescribeLabel{

    if (!_transLateSumDescribeLabel) {
        _transLateSumDescribeLabel = [[UILabel alloc] init];
        _transLateSumDescribeLabel.text = @"总交易金额";
        _transLateSumDescribeLabel.textColor = RGBColor(102, 102, 102);
        _transLateSumDescribeLabel.font = [UIFont systemFontOfSize:12*pro];
    }
    return _transLateSumDescribeLabel;
}

- (UILabel *)translateSumLabel{

    if (!_translateSumLabel) {
        _translateSumLabel = [[UILabel alloc] init];
        _translateSumLabel.textColor = RGBColor(239, 47, 12);
        _translateSumLabel.font = [UIFont systemFontOfSize:12*pro];
        _translateSumLabel.textAlignment = NSTextAlignmentRight;
    }
    return _translateSumLabel;
}

- (UIView *)line3View{

    if (!_line3View) {
        _line3View = [[UIView alloc] init];
        _line3View.backgroundColor = RGBColor(220, 220, 220);
    }
    return _line3View;
}

- (UILabel *)AwardDescribeLabel{

    if (!_AwardDescribeLabel) {
        _AwardDescribeLabel = [[UILabel alloc] init];
        _AwardDescribeLabel.textColor = RGBColor(102, 102, 102);
        _AwardDescribeLabel.text = @"总发放奖励金额";
        _AwardDescribeLabel.font = [UIFont systemFontOfSize:12*pro];
    }
    return _AwardDescribeLabel;
}

- (UILabel *)AwardLabel{

    if (!_AwardLabel) {
        _AwardLabel = [[UILabel alloc] init];
        _AwardLabel.textColor = RGBColor(239, 47, 12);
        _AwardLabel.font = [UIFont systemFontOfSize:12*pro];
        _AwardLabel.textAlignment = NSTextAlignmentRight;
    }
    return _AwardLabel;
}

- (UIView *)line4View{

    if (!_line4View) {
        _line4View = [[UIView alloc] init];
        _line4View.backgroundColor = RGBColor(220, 220, 220);
    }
    return _line4View;
}

- (UILabel *)profitDescribeLabel{

    if (!_profitDescribeLabel) {
        _profitDescribeLabel = [[UILabel alloc] init];
        _profitDescribeLabel.text = @"总利润金额";
        _profitDescribeLabel.textColor = RGBColor(102, 102, 102);
        _profitDescribeLabel.font = [UIFont systemFontOfSize:12*pro];
    }
    return _profitDescribeLabel;
}

- (UILabel *)profirLabel{

    if (!_profirLabel) {
        _profirLabel = [[UILabel alloc] init];
        _profirLabel.textColor = RGBColor(239, 47, 12);
        _profirLabel.font = [UIFont systemFontOfSize:12*pro];
        _profirLabel.textAlignment = NSTextAlignmentRight;
    }
    return _profirLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.backgroundColor = RGBColor(44, 170, 87);
    }
    return self;
}

- (void)initUI{

    [self addSubview:self.backView];
    [_backView addSubview:self.userAddNumLabel];
    [_backView addSubview:self.userSumLabel];
    [_backView addSubview:self.line1View];
    [_backView addSubview:self.joinMerNumLabel];
    [_backView addSubview:self.joinFacNumLabel];
    [_backView addSubview:self.line2View];
    [_backView addSubview:self.transLateSumDescribeLabel];
    [_backView addSubview:self.translateSumLabel];
    [_backView addSubview:self.line3View];
    [_backView addSubview:self.AwardDescribeLabel];
    [_backView addSubview:self.AwardLabel];
    [_backView addSubview:self.line4View];
    [_backView addSubview:self.profitDescribeLabel];
    [_backView addSubview:self.profirLabel];
    
    [self updateConstraints];
}

- (void)updateConstraints{

    [super updateConstraints];
    WS(weakSelf);
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.top.equalTo(weakSelf.mas_top);
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
    
    [_userAddNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backView.mas_top);
        make.left.equalTo(_backView.mas_left).with.offset(10*pro);
        make.height.equalTo(@(30*pro));
    }];
    
    [_userSumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backView.mas_top);
        make.right.equalTo(_backView.mas_right).with.offset(-10*pro);
        make.height.equalTo(@(30*pro));
    }];
    
    [_line1View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_userSumLabel.mas_bottom);
        make.left.equalTo(_backView.mas_left).with.offset(10*pro);
        make.right.equalTo(_backView.mas_right).with.offset(-10*pro);
        make.height.equalTo(@1);
    }];
    
    [_joinMerNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line1View.mas_bottom);
        make.left.equalTo(_backView.mas_left).with.offset(10*pro);
        make.height.equalTo(@(30*pro));
    }];
    
    [_joinFacNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line1View.mas_bottom);
        make.right.equalTo(_backView.mas_right).with.offset(-10*pro);
        make.height.equalTo(@(30*pro));
    }];
    
    [_line2View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView.mas_left).with.offset(10*pro);
        make.right.equalTo(_backView.mas_right).with.offset(-10*pro);
        make.bottom.equalTo(_joinFacNumLabel.mas_bottom);
        make.height.equalTo(@1);
    }];
    
    [_transLateSumDescribeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line2View.mas_bottom);
        make.left.equalTo(_backView.mas_left).with.offset(10*pro);
        make.height.equalTo(@(30*pro));
    }];
    
    [_translateSumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line2View.mas_bottom);
        make.right.equalTo(_backView.mas_right).with.offset(-10*pro);
        make.height.equalTo(@(30*pro));
    }];
    
    [_line3View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView.mas_left).with.offset(10*pro);
        make.right.equalTo(_backView.mas_right).with.offset(-10*pro);
        make.bottom.equalTo(_transLateSumDescribeLabel.mas_bottom);
        make.height.equalTo(@1);
    }];
    
    [_AwardDescribeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line3View.mas_bottom);
        make.left.equalTo(_backView.mas_left).with.offset(10*pro);
        make.height.equalTo(@(30*pro));
    }];
    
    [_AwardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line3View.mas_bottom);
        make.right.equalTo(_backView.mas_right).with.offset(-10*pro);
        make.height.equalTo(@(30*pro));
    }];
    
    [_line4View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView.mas_left).with.offset(10*pro);
        make.right.equalTo(_backView.mas_right).with.offset(-10*pro);
        make.bottom.equalTo(_AwardDescribeLabel.mas_bottom);
        make.height.equalTo(@1);
    }];
    
    [_profitDescribeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line4View.mas_bottom);
        make.left.equalTo(_backView.mas_left).with.offset(10*pro);
        make.height.equalTo(@(30*pro));
    }];
    
    [_profirLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line4View.mas_bottom);
        make.right.equalTo(_backView.mas_right).with.offset(-10*pro);
        make.height.equalTo(@(30*pro));
    }];
}

- (void)setModel:(CLSHOpenDataModel *)model{

    _model = model;
//    NSString *addNum = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithInteger:model.newMember]];
    _userAddNumLabel.text = [NSString stringWithFormat:@"用户量：  新增%zi位",model.newMember];
//    NSString *sumNum = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithInteger:model.totalMember]];
    _userSumLabel.text = [NSString stringWithFormat:@"总数%zi位",model.totalMember];
//    NSString *joinMerNum = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithInteger:model.shops]];
    _joinMerNumLabel.text = [NSString stringWithFormat:@"入驻量：  商家%zi家",model.shops];
//    NSString *joinFacNum = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithInteger:model.factorys]];
    _joinFacNumLabel.text = [NSString stringWithFormat:@"厂家%zi家",model.factorys];
    NSString *totalVolumeNum = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:model.totalVolume]];
    _translateSumLabel.text = [NSString stringWithFormat:@"%@",totalVolumeNum];
    NSString *totalBonusNum = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:model.totalBonus]];
    _AwardLabel.text = [NSString stringWithFormat:@"%@",totalBonusNum];
    NSString *totalProfitNum = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:model.totalProfit]];
    _profirLabel.text = [NSString stringWithFormat:@"%@",totalProfitNum];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
