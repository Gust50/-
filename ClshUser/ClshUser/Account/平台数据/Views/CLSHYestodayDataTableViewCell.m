//
//  CLSHYestodayDataTableViewCell.m
//  ClshUser
//
//  Created by arom on 16/11/21.
//  Copyright © 2016年 50. All rights reserved.
//

#import "CLSHYestodayDataTableViewCell.h"
#import "CLSHOpenDataModel.h"

@implementation CLSHYestodayDataTableViewCell
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
- (UILabel *)yestodayDataLabel{

    if (!_yestodayDataLabel) {
        _yestodayDataLabel = [[UILabel alloc] init];
        _yestodayDataLabel.text = @"昨日平台数据";
        _yestodayDataLabel.textColor = systemColor;
        _yestodayDataLabel.font = [UIFont systemFontOfSize:12*pro];
        _yestodayDataLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _yestodayDataLabel;
}

- (UIView *)line1View{
    
    if (!_line1View) {
        _line1View = [[UIView alloc] init];
        _line1View.backgroundColor = RGBColor(220, 220, 220);
    }
    return _line1View;
}


-(UILabel *)transLateSumDescribeLabel{
    
    if (!_transLateSumDescribeLabel) {
        _transLateSumDescribeLabel = [[UILabel alloc] init];
        _transLateSumDescribeLabel.text = @"交易金额";
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

- (UIView *)line2View{
    
    if (!_line2View) {
        _line2View = [[UIView alloc] init];
        _line2View.backgroundColor = RGBColor(220, 220, 220);
    }
    return _line2View;
}

- (UILabel *)AwardDescribeLabel{
    
    if (!_AwardDescribeLabel) {
        _AwardDescribeLabel = [[UILabel alloc] init];
        _AwardDescribeLabel.textColor = RGBColor(102, 102, 102);
        _AwardDescribeLabel.text = @"发放奖励金额";
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

- (UIView *)line3View{
    
    if (!_line3View) {
        _line3View = [[UIView alloc] init];
        _line3View.backgroundColor = RGBColor(220, 220, 220);
    }
    return _line3View;
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

- (UILabel *)attenLabel{

    if (!_attenLabel) {
        _attenLabel = [[UILabel alloc] init];
        _attenLabel.textColor = RGBColor(240, 240, 240);
        _attenLabel.font = [UIFont systemFontOfSize:10*pro];
        _attenLabel.textAlignment = NSTextAlignmentCenter;
        _attenLabel.text = @"注: 以上均为平台真是数据，实时更新。";
    }
    return _attenLabel;
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
    [_backView addSubview:self.yestodayDataLabel];
    [_backView addSubview:self.line1View];
    [_backView addSubview:self.transLateSumDescribeLabel];
    [_backView addSubview:self.translateSumLabel];
    [_backView addSubview:self.line2View];
    [_backView addSubview:self.AwardDescribeLabel];
    [_backView addSubview:self.AwardLabel];
    [_backView addSubview:self.line3View];
    [_backView addSubview:self.profitDescribeLabel];
    [_backView addSubview:self.profirLabel];
    [self addSubview:self.attenLabel];
    [self updateConstraints];
}

- (void)updateConstraints{

    [super updateConstraints];
    WS(weakSelf);
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 10*pro, 30*pro, 10*pro));
    }];
    
    [_yestodayDataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView.mas_left);
        make.right.equalTo(_backView.mas_right);
        make.height.equalTo(@(30*pro));
    }];
    
    [_line1View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView.mas_left).with.offset(10*pro);
        make.right.equalTo(_backView.mas_right).with.offset(-10*pro);
        make.bottom.equalTo(_yestodayDataLabel.mas_bottom);
        make.height.equalTo(@1);
    }];
    
    [_transLateSumDescribeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line1View.mas_bottom);
        make.left.equalTo(_backView.mas_left).with.offset(10*pro);
        make.height.equalTo(@(30*pro));
    }];
    
    [_translateSumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line1View.mas_bottom);
        make.right.equalTo(_backView.mas_right).with.offset(-10*pro);
        make.height.equalTo(@(30*pro));
    }];
    [_line2View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView.mas_left).with.offset(10*pro);
        make.right.equalTo(_backView.mas_right).with.offset(-10*pro);
        make.bottom.equalTo(_transLateSumDescribeLabel.mas_bottom);
        make.height.equalTo(@1);
    }];
    [_AwardDescribeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line2View.mas_bottom);
        make.left.equalTo(_backView.mas_left).with.offset(10*pro);
        make.height.equalTo(@(30*pro));
    }];
    
    [_AwardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line2View.mas_bottom);
        make.right.equalTo(_backView.mas_right).with.offset(-10*pro);
        make.height.equalTo(@(30*pro));
    }];
    
    [_line3View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView.mas_left).with.offset(10*pro);
        make.right.equalTo(_backView.mas_right).with.offset(-10*pro);
        make.bottom.equalTo(_AwardDescribeLabel.mas_bottom);
        make.height.equalTo(@1);
    }];
    
    [_profitDescribeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line3View.mas_bottom);
        make.left.equalTo(_backView.mas_left).with.offset(10*pro);
        make.height.equalTo(@(30*pro));
    }];
    
    [_profirLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line3View.mas_bottom);
        make.right.equalTo(_backView.mas_right).with.offset(-10*pro);
        make.height.equalTo(@(30*pro));
    }];
    [_attenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.top.equalTo(_backView.mas_bottom);
        make.height.equalTo(@(30*pro));
    }];
    
}

- (void)setModel:(CLSHOpenDataModel *)model{

    _model = model;
    NSString * volumeNum = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:model.yesterdayVolume]];
    _translateSumLabel.text = [NSString stringWithFormat:@"%@",volumeNum];
    NSString *BonusNum = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:model.bonus]];
    _AwardLabel.text = [NSString stringWithFormat:@"%@",BonusNum];
    NSString *profitNum = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:model.yesterdayProfit]];
    _profirLabel.text = [NSString stringWithFormat:@"%@",profitNum];
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
